import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.SequenceFileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.SequenceFileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

/*
 * This is the skeleton for CS61c project 1, Fall 2012.
 *
 * Contact Alan Christopher or Ravi Punj with questions and comments.
 *
 * Reminder:  DO NOT SHARE CODE OR ALLOW ANOTHER STUDENT TO READ YOURS.
 * EVEN FOR DEBUGGING. THIS MEANS YOU.
 *
 */
public class Proj1 {

    /** An Example Writable which contains two String Objects. */
    public static class FloatSum implements Writable {
        /** The String objects I wrap. */
        private double total;
        private long count;

	/** Initializes me to contain empty strings. */
        public FloatSum() {
            total = 0.0;
            count = 0;
	}
	
	/** Initializes me to contain A, B. */
        public FloatSum(double total, long count) {
            this.total = total;
            this.count = count;
        }

        /** Serializes object - needed for Writable. */
        public void write(DataOutput out) throws IOException {
            new DoubleWritable(total).write(out);
            new LongWritable(count).write(out);
        }

        /** Deserializes object - needed for Writable. */
        public void readFields(DataInput in) throws IOException {
            total = in.readDouble();
            count = in.readLong();
        }

        /** Returns Total. */
        public double getTotal() {
            return total;
	}
        /** Returns Count. */
        public long getCount() {
            return count;
	}
    }


  /**
   * Inputs a set of (docID, document contents) pairs.
   * Outputs a set of (Text, Text) pairs.
   */
    public static class Map1 extends Mapper<WritableComparable, Text, Text, FloatSum> {
        /** Regex pattern to find words (alphanumeric + _). */
        final static Pattern WORD_PATTERN = Pattern.compile("\\w+");

        private String targetGram = null;
        private int funcNum = 0;
        private int targetGramLength = 1;

        /*
         * Setup gets called exactly once for each mapper, before map() gets called the first time.
         * It's a good place to do configuration or setup that can be shared across many calls to map
         */
        @Override
        public void setup(Context context) {
            targetGram = context.getConfiguration().get("targetGram").toLowerCase();
	    try {
                funcNum = Integer.parseInt(context.getConfiguration().get("funcNum"));
                for (int i=0; i < targetGram.length(); i++) {
                    if (targetGram.charAt(i) == ' ') targetGramLength++;
                }
	    } catch (NumberFormatException e) {
		/* Do nothing. */
	    }
        }

        @Override
        public void map(WritableComparable docID, Text docContents, Context context)
                throws IOException, InterruptedException {
            Matcher matcher = WORD_PATTERN.matcher(docContents.toString());
	    Func func = funcFromNum(funcNum);

            ArrayList<String> words = new ArrayList<String>();
            ArrayList<Integer> targetLocations = new ArrayList<Integer>();

	    //Maybe read in the input?
            while (matcher.find()) {
                String word = matcher.group().toLowerCase();
                words.add(word);
            }
            //Maybe do something with the input?
            for(int i=0; i < words.size() + 1 - targetGramLength; i++) {
                String gram = words.get(i);
                for (int j=1; j < targetGramLength; j++) {
                    gram += " " + words.get(i+j);
                }
                if (gram.equalsIgnoreCase(targetGram)) {
                    targetLocations.add(i);
                }
            }

            int location = 0;
            //Maybe generate output?
            for(int i=0; i < words.size() + 1 - targetGramLength; i++) {
                String gram = words.get(i);
                for (int j=1; j < targetGramLength; j++) {
                    gram += " " + words.get(i+j);
                }
                if (targetLocations.size() < 1) {
                    context.write(new Text(gram), new FloatSum(func.f(Double.POSITIVE_INFINITY), 1));
                } else {
                    int distance;
                    if (location < targetLocations.size() && i == targetLocations.get(location)) {
                        location++;
                    } else {
                        int d1 = 0;
                        int d2 = 0;
                        int test = 0;
                        if (location > 0) {
                            test++;
                            d1 = i - targetLocations.get(location-1);
                        }
                        if (location < targetLocations.size()) {
                            test++;
                            d2 = targetLocations.get(location) - i;
                        }
                        int closestDistance;
                        if (d1 > 0 && d1 > d2) {
                            closestDistance = d1;
                        } else {
                            closestDistance = d2;
                        }
                        if (closestDistance > 0) {
                            context.write(new Text(gram),new FloatSum(func.f(closestDistance), 1));
                        } else {
                        }
                    }
                }
            }
        }

        /** Returns the Func corresponding to FUNCNUM*/
        private Func funcFromNum(int funcNum) {
            Func func = null;
            switch (funcNum) {
            case 0:
                func = new Func() {
                        public double f(double d) {
                            return d == Double.POSITIVE_INFINITY ? 0.0 : 1.0;
                        }
                    };
                break;
            case 1:
                func = new Func() {
                        public double f(double d) {
                            return d == Double.POSITIVE_INFINITY ? 0.0 : 1.0 + 1.0 / d;
                        }
                    };
                break;
            case 2:
                func = new Func() {
                        public double f(double d) {
                            return d == Double.POSITIVE_INFINITY ? 0.0 : Math.sqrt(d);
                        }
                    };
                break;
            }
            return func;
        }
    }

    /** Here's where you'll be implementing your combiner. It must be non-trivial for you to receive credit. */
    public static class Combine1 extends Reducer<Text, FloatSum, Text, FloatSum> {

      @Override
      public void reduce(Text key, Iterable<FloatSum> values,
              Context context) throws IOException, InterruptedException {
          double sum = 0;
          int size = 0;
          for (FloatSum value : values) {
              sum += value.getTotal();
              size += value.getCount();
          }
          context.write(key, new FloatSum(sum, size));
      }
    }


    public static class Reduce1 extends Reducer<Text, FloatSum, DoubleWritable, Text> {
        @Override
        public void reduce(Text key, Iterable<FloatSum> values,
                           Context context) throws IOException, InterruptedException {
            double sum = 0;
            int size = 0;
            for (FloatSum value : values) {
                sum += value.getTotal();
                size += value.getCount();
            }
            double rate = 0;
            if (sum > 0) {
                rate = sum * Math.pow(Math.log(sum),3) / size;
            }
            context.write(new DoubleWritable(-rate), key);
        }
    }

    public static class Map2 extends Mapper<DoubleWritable, Text, DoubleWritable, Text> {
        //maybe do something, maybe don't
    }

    public static class Reduce2 extends Reducer<DoubleWritable, Text, DoubleWritable, Text> {

      int n = 0;
      static int N_TO_OUTPUT = 100;

      /*
       * Setup gets called exactly once for each reducer, before reduce() gets called the first time.
       * It's a good place to do configuration or setup that can be shared across many calls to reduce
       */
      @Override
      protected void setup(Context c) {
        n = 0;
      }

        @Override
        public void reduce(DoubleWritable key, Iterable<Text> values,
                Context context) throws IOException, InterruptedException {
            //you should be outputting the final values here.
            for (Text value : values) {
                context.write(new DoubleWritable(Math.abs(key.get())), value);
            }
        }
    }

    /*
     *  You shouldn't need to modify this function much. If you think you have a good reason to,
     *  you might want to discuss with staff.
     *
     *  The skeleton supports several options.
     *  if you set runJob2 to false, only the first job will run and output will be
     *  in TextFile format, instead of SequenceFile. This is intended as a debugging aid.
     *
     *  If you set combiner to false, neither combiner will run. This is also
     *  intended as a debugging aid. Turning on and off the combiner shouldn't alter
     *  your results. Since the framework doesn't make promises about when it'll
     *  invoke combiners, it's an error to assume anything about how many times
     *  values will be combined.
     */
    public static void main(String[] rawArgs) throws Exception {
        GenericOptionsParser parser = new GenericOptionsParser(rawArgs);
        Configuration conf = parser.getConfiguration();
        String[] args = parser.getRemainingArgs();

        boolean runJob2 = conf.getBoolean("runJob2", true);
        boolean combiner = conf.getBoolean("combiner", false);

        if(runJob2)
          System.out.println("running both jobs");
        else
          System.out.println("for debugging, only running job 1");

        if(combiner)
          System.out.println("using combiner");
        else
          System.out.println("NOT using combiner");

        Path inputPath = new Path(args[0]);
        Path middleOut = new Path(args[1]);
        Path finalOut = new Path(args[2]);
        FileSystem hdfs = middleOut.getFileSystem(conf);
        int reduceCount = conf.getInt("reduces", 32);

        if(hdfs.exists(middleOut)) {
          System.err.println("can't run: " + middleOut.toUri().toString() + " already exists");
          System.exit(1);
        }
        if(finalOut.getFileSystem(conf).exists(finalOut) ) {
          System.err.println("can't run: " + finalOut.toUri().toString() + " already exists");
          System.exit(1);
        }

        {
            Job firstJob = new Job(conf, "wordcount+co-occur");

            firstJob.setJarByClass(Map1.class);

            /* You may need to change things here */
            firstJob.setMapOutputKeyClass(Text.class);
            firstJob.setMapOutputValueClass(FloatSum.class);
            firstJob.setOutputKeyClass(DoubleWritable.class);
            firstJob.setOutputValueClass(Text.class);
	    /* End region where we expect you to perhaps need to change things. */

            firstJob.setMapperClass(Map1.class);
            firstJob.setReducerClass(Reduce1.class);
            firstJob.setNumReduceTasks(reduceCount);


            if(combiner)
              firstJob.setCombinerClass(Combine1.class);

            firstJob.setInputFormatClass(SequenceFileInputFormat.class);
            if(runJob2)
              firstJob.setOutputFormatClass(SequenceFileOutputFormat.class);

            FileInputFormat.addInputPath(firstJob, inputPath);
            FileOutputFormat.setOutputPath(firstJob, middleOut);

            firstJob.waitForCompletion(true);
        }

        if(runJob2) {
            Job secondJob = new Job(conf, "sort");

            secondJob.setJarByClass(Map1.class);
	    /* You may need to change things here */
            secondJob.setMapOutputKeyClass(DoubleWritable.class);
            secondJob.setMapOutputValueClass(Text.class);
            secondJob.setOutputKeyClass(DoubleWritable.class);
            secondJob.setOutputValueClass(Text.class);
	    /* End region where we expect you to perhaps need to change things. */

            secondJob.setMapperClass(Map2.class);
            if(combiner)
              secondJob.setCombinerClass(Reduce2.class);
            secondJob.setReducerClass(Reduce2.class);

            secondJob.setInputFormatClass(SequenceFileInputFormat.class);
            secondJob.setOutputFormatClass(TextOutputFormat.class);
            secondJob.setNumReduceTasks(1);


            FileInputFormat.addInputPath(secondJob, middleOut);
            FileOutputFormat.setOutputPath(secondJob, finalOut);

            secondJob.waitForCompletion(true);
        }
    }

}
