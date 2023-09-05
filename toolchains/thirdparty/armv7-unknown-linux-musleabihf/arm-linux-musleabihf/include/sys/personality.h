#ifndef _PERSONALITY_H
#define _PERSONALITY_H

#ifdef __cplusplus
extern "C" {
#endif

#define ADDR_NO_RANDOMIZE  0x0040000
#define MMAP_PAGE_ZERO     0x0100000
#define ADDR_COMPAT_LAYOUT 0x0200000
#define READ_IMPLIES_EXEC  0x0400000
#define ADDR_LIMIT_32BIT   0x0800000
#define SHORT_INODE        0x1000000
#define WHOLE_SECONDS      0x2000000
#define STICKY_TIMEOUTS    0x4000000
#define ADDR_LIMIT_3GB     0x8000000

#define PER_LINUX 0
#define PER_LINUX_32BIT ADDR_LIMIT_32BIT
#define PER_SVR4 (1 | STICKY_TIMEOUTS | MMAP_PAGE_ZERO)
#define PER_SVR3 (2 | STICKY_TIMEOUTS | SHORT_INODE)
#define PER_SCOSVR3 (3 | STICKY_TIMEOUTS | WHOLE_SECONDS | SHORT_INODE)
#define PER_OSR5 (3 | STICKY_TIMEOUTS | WHOLE_SECONDS)
#define PER_WYSEV386 (4 | STICKY_TIMEOUTS | SHORT_INODE)
#define PER_ISCR4 (5 | STICKY_TIMEOUTS)
#define PER_BSD 6
#define PER_SUNOS (6 | STICKY_TIMEOUTS)
#define PER_XENIX (7 | STICKY_TIMEOUTS | SHORT_INODE)
#define PER_LINUX32 8
#define PER_LINUX32_3GB (8 | ADDR_LIMIT_3GB)
#define PER_IRIX32 (9 | STICKY_TIMEOUTS)
#define PER_IRIXN32 (0xa | STICKY_TIMEOUTS)
#define PER_IRIX64 (0x0b | STICKY_TIMEOUTS)
#define PER_RISCOS 0xc
#define PER_SOLARIS (0xd | STICKY_TIMEOUTS)
#define PER_UW7 (0xe | STICKY_TIMEOUTS | MMAP_PAGE_ZERO)
#define PER_OSF4 0xf
#define PER_HPUX 0x10
#define PER_MASK 0xff

int personality(unsigned long);

#ifdef __cplusplus
}
#endif
#endif
