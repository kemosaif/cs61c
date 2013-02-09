#include <stdio.h>
#include <stdlib.h>

#define MAX_NAME_LEN 127

typedef struct {
    char name[MAX_NAME_LEN + 1];
    unsigned long sid;
} Student;

/* return the name of student s */
const char* getName (const Student* s) {
    return s->name;
}

/* set the name of student s
If name is too long, cut off characters after the maximum number of characters allowed.
*/
void setName(Student* s, const char* name) {
    int i;
    for (i=0; i < MAX_NAME_LEN; i++) {
        s->name[i] = *(name+i);
    }
    s->name[MAX_NAME_LEN +1] = '\0';
}

/* return the SID of student s */
unsigned long getStudentID(const Student* s) {
     return s->sid;
}

/* set the SID of student s */
void setStudentID(Student* s, unsigned long sid) {
    s->sid = sid;
}

Student* makeAndrew(void) {
    Student s;
    setName(&s, "Andrew");
    setStudentID(&s, 12345678);
    return &s;
}

int main(){
    Student s;
    setName(&s, "Andrewasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasfd");
    setStudentID(&s, 12345678);
    printf("%s\n", s.name);
    makeAndrew;
    return 0;
}
