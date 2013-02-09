puts "#include <emmintrin.h>"
puts "void sgemm( int m, int n, float *A, float *C ) {"

puts "if (m == 60 && n == 60) {"

puts "__m128 c[15],at,a[15];"

puts "for( int j = 0; j < m; j++) {"
puts "float* temp1 = C+j*m;"

puts
15.times do |n|
    puts "c[#{n}] = _mm_loadu_ps(temp1 + #{n*4});"
end
puts

puts "for( int k = 0; k < n; k+=1 ) {"
puts "at = _mm_set1_ps(A[j+k*m]);"
15.times do |i|
    puts "a[#{i}] = _mm_loadu_ps(A+k*m+#{i*4});"
    puts "a[#{i}] = _mm_mul_ps(a[#{i}],at);"
    puts "c[#{i}] = _mm_add_ps(a[#{i}],c[#{i}]);"
    puts
end
puts "}"

puts
15.times do |n|
    puts "_mm_storeu_ps(temp1+#{n*4},c[#{n}]);"
end
puts

puts "}"
puts "} else {"

puts "__m128 c[m/4],at,a[m/4];"

puts "for( int j = 0; j < m; j++) {"
puts "float* temp1 = C+j*m;"

puts
puts "for (int num = 0; num < m/4; num++) {"
puts "c[num] = _mm_loadu_ps(temp1 + num*4);"
puts "}"
puts

puts "for( int k = 0; k < n; k+=1 ) {"
puts "at = _mm_set1_ps(A[j+k*m]);"
puts "for (int i = 0; i < m/4; i++) {"
puts "a[i] = _mm_loadu_ps(A+k*m+i*4);"
puts "a[i] = _mm_mul_ps(a[i],at);"
puts "c[i] = _mm_add_ps(a[i],c[i]);"
puts "}"
puts "for ( int i = m/4*4; i<m; i++)"
puts "C[i+j*m] += A[i+k*m] * A[j+k*m];"
puts "}"


puts
puts "for (int num = 0; num < m/4; num++) {"
puts "_mm_storeu_ps(temp1+num*4,c[num]);"
puts "c[num] = _mm_loadu_ps(temp1 + num*4);"
puts "}"
puts


puts "}"
puts "}"
puts "}"
