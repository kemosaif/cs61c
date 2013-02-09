puts "#include <emmintrin.h>"
puts "void sgemm( int m, int n, float *A, float *C ) {"
puts "__m128 c,at,a;"

puts "if (m == 60 && n == 60) {"

60.times do |j|
    60.times do|k|
        puts "at = _mm_set1_ps(A[#{j}+#{k}*m]);"
        15.times do |i|
            n = i*4
            puts "a = _mm_loadu_ps(A+#{k}*m+#{n});"
            puts "c = _mm_loadu_ps(C+#{j}*m+#{n});"
            puts "a = _mm_mul_ps(a,at);"
            puts "a = _mm_add_ps(a,c);"
            puts "_mm_storeu_ps(C+#{j}*m+#{n},a);"
            puts
        end
    end
end

puts "} else {"
puts "for( int i = 0; i < m; i++ )"
puts "for( int k = 0; k < n; k++ )"
puts "for( int j = 0; j < m; j++ )"
puts "C[i+j*m] += A[i+k*m] * A[j+k*m];"
puts "}"
puts "}"
