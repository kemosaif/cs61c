puts "#include <emmintrin.h>"
puts "void sgemm( int m, int n, float *A, float *C ) {"
puts "__m128 c[15],at,a[15];"

puts "if (m == 60 && n == 60) {"

puts "for( int j = 0; j < m; j++) {"
puts "float* temp1 = C+j*m;"

puts
15.times do |num|
    n = num*4
    puts "c[#{n}] = _mm_loadu_ps(temp1 + #{n});"
end
puts

60.times do |k|
    puts "at = _mm_set1_ps(A[j+#{k}*m]);"
    15.times do |i|
        n = i*4
        puts "a[#{n}] = _mm_loadu_ps(A+#{k}*m+#{n});"
        puts "a[#{n}] = _mm_mul_ps(a[#{n}],at);"
        puts "c[#{n}] = _mm_add_ps(a[#{n}],c[#{n}]);"
        puts
    end
end

puts
15.times do |num|
    n = num*4
    puts "_mm_storeu_ps(temp1+#{n},c[#{n}]);"
end
puts

puts "}"
puts "} else {"
puts "for( int i = 0; i < m; i++ )"
puts "for( int k = 0; k < n; k++ )"
puts "for( int j = 0; j < m; j++ )"
puts "C[i+j*m] += A[i+k*m] * A[j+k*m];"
puts "}"
puts "}"
