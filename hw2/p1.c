int main(){
  int a1[] = {100, 101, 102};
  int i;
  for(i = 0; i<3;i++)
    printf("Before Shift: " "%d\n", a1[i]);
  shift(a1, 4);
  //pointer_shift(a1, 4);
  for(i = 0; i<3;i++)
    printf("After Shift In Main: " "%d\n", a1[i]);
}

void shift(int a[], int n) {
  int *p;
  for (p=a; p != a + n-1; p++)
    *p = *(p+1);
}
