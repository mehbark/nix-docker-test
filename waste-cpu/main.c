#define black_box(val) \
    __asm__ __volatile__("" : : "g"(val) : "memory")

int main(void) {
    for (;;) black_box(413);
}
