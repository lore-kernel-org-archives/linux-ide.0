Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964DDDC1
	for <linux-ide@vger.kernel.org>; Thu,  2 Jan 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835044; cv=none; b=Dy9wwAxnCKS6RJZ67So8RPZUHSPf8BlJZ/gqn8TxWSop7gx6HvyFJ6fHLYfRguBF8v4KsPxV4iNdK9a9xbiQKCjNDsZWeDIa6cTjUqi60V52jSF14oKxcFBKuJx/zFyDFXhsjq2IvLHiPTn+xjaATFn585rc5VvGL6BhzKJARsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835044; c=relaxed/simple;
	bh=QlvYaktKE6qwn5T5t5iBQz7Qot5XXmbzlTkcZxQi/0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKdYacA3gCuXkOqt/fB98hhdPODTHpj1XCCPsY5cpiSoHsRRUzIo9IYN2ZRJ6y8HxBmp3YgWe9A4b1ZlQlD1Q7SnbWPPKZtE/TVXLA//CISHryANzCk+sXBhnrOR+rJKvJBQrxSYiTs5QVZJL7/f1Xns3jtSKtJdtyUdzlxLknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Htezz8aT; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Htezz8aT"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dcf63155b0so51147416d6.1
        for <linux-ide@vger.kernel.org>; Thu, 02 Jan 2025 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735835040; x=1736439840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK20QD5/8GWuU4vHrUNAZKhZNcGSxQijsJWKq250hw0=;
        b=Htezz8aTwWSc2uWPOxdBb4QG94TwMXAogMwJwsFIG9qdXya5xETu3q9TLVGXxGEkFn
         115SEN2SsAUYD/XEdW06s5zYBlfvcwnMRB+oqYOV1bAhXDEOoXmUjwKCaNTKVqTI3oYF
         Xg2NnlZZAdgiu8XGkMLXP4H7msGqM90+EGR6p5pzNcuouPtrIxoDreWN5PGrX/F6WgoY
         k9vSx85MgIAycWBCzJBHDXlJe10wS8ylRpHsjP48sPxqKEl/KdS2JzREMdvq8JTxfMdK
         XZRABFyiPKL6thUIliUdGaYDBRX3bT1WE6EMoQ9me6KMZ9U+HUqfYPwKXMHqAIolnV0a
         vDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735835040; x=1736439840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK20QD5/8GWuU4vHrUNAZKhZNcGSxQijsJWKq250hw0=;
        b=cayUWNWLOWK+ftGZTg9u3VbkYmxlnblgssPYCb9BnG98UN1OgQ8BGPB/fhdU+7bszT
         PKRzIJ18lW6BZzRwq4/sNzMgRyLGwwFxyu/hdAqhR5aap94JYSeS7aIAlWZDB9TfzMmZ
         DDzqiVhDv7BRWla0mEFP5oNVZudr1rteNl2gD/+yDCjk7uYAA6lyg24NMJjnMa9gGxQX
         zuJY9lB32VUSypcNMMUQemvMN5URhMkeX7r8EME3PPVk/NEmFseIFMiGPDbo22IqbBHG
         t6vQDGKcMoj9cgSDq/Zm1A7ssXNFVKo4ugO8eobSwV3nGu6hGx0a88tvjbkhlF7eBmXw
         F1cg==
X-Forwarded-Encrypted: i=1; AJvYcCWRSPgGdVp8bolYxNCAq0j1hP9xgo/Nh9NG1njDYKU3ZoHleqbRsYMYP67OWjReBrb/QhiHTCsUejE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAMpt0KFnL2mEWD5fs/Sk1WsYymYcanA2rtdyAbfMVwBPnSRY
	umBz5div4pmRvgo4GGyBi4UwT/7NVihPtWdPQ+umaJCyBCvY4tSH9cqboL8tGgxSHjuKmumWyUb
	nN9TcyqDeU5EGchLJpqeE6Q1j9jOmleD2
X-Gm-Gg: ASbGnctzjhHvUph/iaXJezmLles4WOUCbSbrj5y2MK8ym17YuuwqFCEydiiFerFDcxy
	ZXTN5Wrj8SGB8fhTOqzpz+mj0yc/7UPxg79mcA+dn
X-Google-Smtp-Source: AGHT+IHptRGU/zr9jvaLAWmOub7M9eVcMM8hhOr/8ABVHM3KW0684P29EZCPHcQz6y9j8LHltXkvlnQcZMkVnhnzSZI=
X-Received: by 2002:a05:6214:29cc:b0:6d8:9f61:de81 with SMTP id
 6a1803df08f44-6dd2334b744mr756423966d6.24.1735835040175; Thu, 02 Jan 2025
 08:24:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com>
 <Z3ZtFDgs61oDMMB9@ryzen>
In-Reply-To: <Z3ZtFDgs61oDMMB9@ryzen>
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Thu, 2 Jan 2025 11:23:49 -0500
Message-ID: <CA+-ZZ_jrKVws_mQ8MyqRJGSktgVt9wbB7xWrmBvGzCeFhvT0-w@mail.gmail.com>
Subject: Re: out-of-bounds write in the function ata_pio_sector
To: Niklas Cassel <cassel@kernel.org>
Cc: damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 5:40=E2=80=AFAM Niklas Cassel <cassel@kernel.org> wr=
ote:
>
> Hello reveliofuzzing,
>
> On Wed, Jan 01, 2025 at 09:17:02PM -0500, reveliofuzzing wrote:
> > Hi there,
> >
> > We found an out-of-bounds write in the function ata_pio_sector, which c=
an cause
> > the kernel to crash. We would like to report it for your reference.
> >
> > ## Problem in ata_pio_sector
> > ata_pio_sector uses the following code to decide which page to use for =
the I/O:
> > page =3D sg_page(qc->cursg);
> > offset =3D qc->cursg->offset + qc->cursg_ofs;
> >
> > /* get the current page and offset */
> > page =3D nth_page(page, (offset >> PAGE_SHIFT));
> > offset %=3D PAGE_SIZE;
> > but we found that `offset` could be as high as 0x5000---qc->cursg_ofs=
=3D=3D0x5000,
> > qc->cursg->offset =3D=3D 0x0, making `page` point to a higher-position =
page that
> > belongs to other threads.
> >
> > ## Example crash
> > This out-of-bound write can cause the kernel to crash at arbitrary plac=
es,
> > depending on when the corrupted page is accessed by the other thread.
> >
> > We found this problem can happen in Linux kernel 6.1~6.12. Here is one =
crash in
> > Linux kernel 6.1:
>
> Thank you for reporting!
>
> I assume that you haven't tested kernels earlier than 6.1?
Unfortunately, we haven't tested older kernels.

>
> (Looking at the driver, there was no major change between 6.0 and 6.1,
> so this bug has probably been there for a long time.)
>
>
> Could you please share your reproducer and your kernel config as well?

Below we report our setup for linux kernel 6.12:

- General steps to reproduce the bug
1. Launch the VM
2. Copy the reproducer (compiled binary) into the VM
3. Run it with the root user
4. Wait for the bug to happen (generally takes less than 3 minutes)

- QEMU command (QEMU emulator version 4.2.1 (Debian 1:4.2-3ubuntu6.30))
qemu-system-x86_64 -m 2G -smp 2 -kernel /linux-6.12/bzImage \
    -append "console=3DttyS0 root=3D/dev/sda earlyprintk=3Dserial net.ifnam=
es=3D0" \
    -drive file=3D./bullseye.img,format=3Draw \
    -net user,host=3D10.0.2.10,hostfwd=3Dtcp:127.0.0.1:10021-:22 \
    -net nic,model=3De1000 \
    -enable-kvm \
    -nographic \
    -pidfile vm.pid \
    2>&1 | tee vm.log

- VM image
It is created using Syzkaller's script:
https://github.com/google/syzkaller/blob/master/tools/create-image.sh

- bzImage
        - kernel: 6.12
        - GCC: Ubuntu 9.4.0-1ubuntu1~20.04.2
        - config:
https://drive.google.com/file/d/1ZfeXgVadChVJtIGx5zMhBqHnmlomP3Hf/view?usp=
=3Dsharing
        - compiled bzimage:
https://drive.google.com/file/d/1MJf0WQ9_eztvuBcaBwCGC-rb7VBQtuac/view?usp=
=3Dsharing

- reproducer
        - compiled binary:
https://drive.google.com/file/d/1Q9prtQKi5LVrOwrFJ162eXzTwTnDUq5X/view?usp=
=3Dsharing
        - C program:
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <sched.h>
#include <setjmp.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/capability.h>

static unsigned long long procid;

static __thread int clone_ongoing;
static __thread int skip_segv;
static __thread jmp_buf segv_env;

static void segv_handler(int sig, siginfo_t* info, void* ctx)
{
        if (__atomic_load_n(&clone_ongoing, __ATOMIC_RELAXED) !=3D 0) {
                exit(sig);
        }
        uintptr_t addr =3D (uintptr_t)info->si_addr;
        const uintptr_t prog_start =3D 1 << 20;
        const uintptr_t prog_end =3D 100 << 20;
        int skip =3D __atomic_load_n(&skip_segv, __ATOMIC_RELAXED) !=3D 0;
        int valid =3D addr < prog_start || addr > prog_end;
        if (skip && valid) {
                _longjmp(segv_env, 1);
        }
        exit(sig);
}

static void install_segv_handler(void)
{
        struct sigaction sa;
        memset(&sa, 0, sizeof(sa));
        sa.sa_handler =3D SIG_IGN;
        syscall(SYS_rt_sigaction, 0x20, &sa, NULL, 8);
        syscall(SYS_rt_sigaction, 0x21, &sa, NULL, 8);
        memset(&sa, 0, sizeof(sa));
        sa.sa_sigaction =3D segv_handler;
        sa.sa_flags =3D SA_NODEFER | SA_SIGINFO;
        sigaction(SIGSEGV, &sa, NULL);
        sigaction(SIGBUS, &sa, NULL);
}

#define NONFAILING(...) ({ int ok =3D 1; __atomic_fetch_add(&skip_segv,
1, __ATOMIC_SEQ_CST); if (_setjmp(segv_env) =3D=3D 0) { __VA_ARGS__; }
else ok =3D 0; __atomic_fetch_sub(&skip_segv, 1, __ATOMIC_SEQ_CST); ok;
})

static void sleep_ms(uint64_t ms)
{
        usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
        struct timespec ts;
        if (clock_gettime(CLOCK_MONOTONIC, &ts))
        exit(1);
        return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...)
{
        char buf[1024];
        va_list args;
        va_start(args, what);
        vsnprintf(buf, sizeof(buf), what, args);
        va_end(args);
        buf[sizeof(buf) - 1] =3D 0;
        int len =3D strlen(buf);
        int fd =3D open(file, O_WRONLY | O_CLOEXEC);
        if (fd =3D=3D -1)
                return false;
        if (write(fd, buf, len) !=3D len) {
                int err =3D errno;
                close(fd);
                errno =3D err;
                return false;
        }
        close(fd);
        return true;
}

static long syz_open_dev(volatile long a0, volatile long a1, volatile long =
a2)
{
        if (a0 =3D=3D 0xc || a0 =3D=3D 0xb) {
                char buf[128];
                sprintf(buf, "/dev/%s/%d:%d", a0 =3D=3D 0xc ? "char" :
"block", (uint8_t)a1, (uint8_t)a2);
                return open(buf, O_RDWR, 0);
        } else {
                char buf[1024];
                char* hash;
                strncpy(buf, (char*)a0, sizeof(buf) - 1);
                buf[sizeof(buf) - 1] =3D 0;
                while ((hash =3D strchr(buf, '#'))) {
                        *hash =3D '0' + (char)(a1 % 10);
                        a1 /=3D 10;
                }
                return open(buf, a2, 0);
        }
}

static void setup_binderfs();
static void setup_fusectl();
static void sandbox_common_mount_tmpfs(void)
{
        write_file("/proc/sys/fs/mount-max", "100000");
        if (mkdir("./syz-tmp", 0777))
        exit(1);
        if (mount("", "./syz-tmp", "tmpfs", 0, NULL))
        exit(1);
        if (mkdir("./syz-tmp/newroot", 0777))
        exit(1);
        if (mkdir("./syz-tmp/newroot/dev", 0700))
        exit(1);
        unsigned bind_mount_flags =3D MS_BIND | MS_REC | MS_PRIVATE;
        if (mount("/dev", "./syz-tmp/newroot/dev", NULL,
bind_mount_flags, NULL))
        exit(1);
        if (mkdir("./syz-tmp/newroot/proc", 0700))
        exit(1);
        if (mount("syz-proc", "./syz-tmp/newroot/proc", "proc", 0, NULL))
        exit(1);
        if (mkdir("./syz-tmp/newroot/selinux", 0700))
        exit(1);
        const char* selinux_path =3D "./syz-tmp/newroot/selinux";
        if (mount("/selinux", selinux_path, NULL, bind_mount_flags, NULL)) =
{
                if (errno !=3D ENOENT)
        exit(1);
                if (mount("/sys/fs/selinux", selinux_path, NULL,
bind_mount_flags, NULL) && errno !=3D ENOENT)
        exit(1);
        }
        if (mkdir("./syz-tmp/newroot/sys", 0700))
        exit(1);
        if (mount("/sys", "./syz-tmp/newroot/sys", 0, bind_mount_flags, NUL=
L))
        exit(1);
        if (mount("/sys/kernel/debug",
"./syz-tmp/newroot/sys/kernel/debug", NULL, bind_mount_flags, NULL) &&
errno !=3D ENOENT)
        exit(1);
        if (mount("/sys/fs/smackfs",
"./syz-tmp/newroot/sys/fs/smackfs", NULL, bind_mount_flags, NULL) &&
errno !=3D ENOENT)
        exit(1);
        if (mount("/proc/sys/fs/binfmt_misc",
"./syz-tmp/newroot/proc/sys/fs/binfmt_misc", NULL, bind_mount_flags,
NULL) && errno !=3D ENOENT)
        exit(1);
        if (mkdir("./syz-tmp/pivot", 0777))
        exit(1);
        if (syscall(SYS_pivot_root, "./syz-tmp", "./syz-tmp/pivot")) {
                if (chdir("./syz-tmp"))
        exit(1);
        } else {
                if (chdir("/"))
        exit(1);
                if (umount2("./pivot", MNT_DETACH))
        exit(1);
        }
        if (chroot("./newroot"))
        exit(1);
        if (chdir("/"))
        exit(1);
        setup_binderfs();
        setup_fusectl();
}

static void setup_fusectl()
{
        if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
        }
}

static void setup_binderfs()
{
        if (mkdir("/dev/binderfs", 0777)) {
        }
        if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
        }
        if (symlink("/dev/binderfs", "./binderfs")) {
        }
}

static void loop();

static void sandbox_common()
{
        prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
        if (getppid() =3D=3D 1)
        exit(1);
        struct rlimit rlim;
        rlim.rlim_cur =3D rlim.rlim_max =3D (200 << 20);
        setrlimit(RLIMIT_AS, &rlim);
        rlim.rlim_cur =3D rlim.rlim_max =3D 32 << 20;
        setrlimit(RLIMIT_MEMLOCK, &rlim);
        rlim.rlim_cur =3D rlim.rlim_max =3D 136 << 20;
        setrlimit(RLIMIT_FSIZE, &rlim);
        rlim.rlim_cur =3D rlim.rlim_max =3D 1 << 20;
        setrlimit(RLIMIT_STACK, &rlim);
        rlim.rlim_cur =3D rlim.rlim_max =3D 128 << 20;
        setrlimit(RLIMIT_CORE, &rlim);
        rlim.rlim_cur =3D rlim.rlim_max =3D 256;
        setrlimit(RLIMIT_NOFILE, &rlim);
        if (unshare(CLONE_NEWNS)) {
        }
        if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
        }
        if (unshare(CLONE_NEWIPC)) {
        }
        if (unshare(0x02000000)) {
        }
        if (unshare(CLONE_NEWUTS)) {
        }
        if (unshare(CLONE_SYSVSEM)) {
        }
        typedef struct {
                const char* name;
                const char* value;
        } sysctl_t;
        static const sysctl_t sysctls[] =3D {
            {"/proc/sys/kernel/shmmax", "16777216"},
            {"/proc/sys/kernel/shmall", "536870912"},
            {"/proc/sys/kernel/shmmni", "1024"},
            {"/proc/sys/kernel/msgmax", "8192"},
            {"/proc/sys/kernel/msgmni", "1024"},
            {"/proc/sys/kernel/msgmnb", "1024"},
            {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
        };
        unsigned i;
        for (i =3D 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
                write_file(sysctls[i].name, sysctls[i].value);
}

static int wait_for_loop(int pid)
{
        if (pid < 0)
        exit(1);
        int status =3D 0;
        while (waitpid(-1, &status, __WALL) !=3D pid) {
        }
        return WEXITSTATUS(status);
}

static void drop_caps(void)
{
        struct __user_cap_header_struct cap_hdr =3D {};
        struct __user_cap_data_struct cap_data[2] =3D {};
        cap_hdr.version =3D _LINUX_CAPABILITY_VERSION_3;
        cap_hdr.pid =3D getpid();
        if (syscall(SYS_capget, &cap_hdr, &cap_data))
        exit(1);
        const int drop =3D (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
        cap_data[0].effective &=3D ~drop;
        cap_data[0].permitted &=3D ~drop;
        cap_data[0].inheritable &=3D ~drop;
        if (syscall(SYS_capset, &cap_hdr, &cap_data))
        exit(1);
}

static int do_sandbox_none(void)
{
        if (unshare(CLONE_NEWPID)) {
        }
        int pid =3D fork();
        if (pid !=3D 0)
                return wait_for_loop(pid);
        sandbox_common();
        drop_caps();
        if (unshare(CLONE_NEWNET)) {
        }
        write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
        sandbox_common_mount_tmpfs();
        loop();
        exit(1);
}

static void kill_and_wait(int pid, int* status)
{
        kill(-pid, SIGKILL);
        kill(pid, SIGKILL);
        for (int i =3D 0; i < 100; i++) {
                if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
                        return;
                usleep(1000);
        }
        DIR* dir =3D opendir("/sys/fs/fuse/connections");
        if (dir) {
                for (;;) {
                        struct dirent* ent =3D readdir(dir);
                        if (!ent)
                                break;
                        if (strcmp(ent->d_name, ".") =3D=3D 0 ||
strcmp(ent->d_name, "..") =3D=3D 0)
                                continue;
                        char abort[300];
                        snprintf(abort, sizeof(abort),
"/sys/fs/fuse/connections/%s/abort", ent->d_name);
                        int fd =3D open(abort, O_WRONLY);
                        if (fd =3D=3D -1) {
                                continue;
                        }
                        if (write(fd, abort, 1) < 0) {
                        }
                        close(fd);
                }
                closedir(dir);
        } else {
        }
        while (waitpid(-1, status, __WALL) !=3D pid) {
        }
}

static void setup_test()
{
        prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
        setpgrp();
        write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
        int iter =3D 0;
        for (;; iter++) {
                int pid =3D fork();
                if (pid < 0)
        exit(1);
                if (pid =3D=3D 0) {
                        setup_test();
                        execute_one();
                        exit(0);
                }
                int status =3D 0;
                uint64_t start =3D current_time_ms();
                for (;;) {
                        sleep_ms(10);
                        if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=
=3D pid)
                                break;
                        if (current_time_ms() - start < 5000)
                                continue;
                        kill_and_wait(pid, &status);
                        break;
                }
        }
}

uint64_t r[1] =3D {0xffffffffffffffff};

void execute_one(void)
{
        intptr_t res =3D 0;
        if (write(1, "executing program\n", sizeof("executing
program\n") - 1)) {}
        NONFAILING(memcpy((void*)0x20000000, "/dev/sg#\000", 9));
        res =3D -1;
        NONFAILING(res =3D syz_open_dev(/*dev=3D*/0x20000000, /*id=3D*/0,
/*flags=3D*/0));
        if (res !=3D -1)
                r[0] =3D res;
        NONFAILING(memcpy((void*)0x20000040,
"\x00\x00\x00\x00\x42\x0d\x00\x00\x85\x0a\xaa", 11));
        NONFAILING(sprintf((char*)0x2000004b, "0x%016llx", (long long)r[0])=
);
        syscall(__NR_ioctl, /*fd=3D*/r[0], /*cmd=3D*/1, /*arg=3D*/0x2000004=
0ul);

}
int main(void)
{
        syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul,
/*prot=3D*/0ul, /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul,
/*fd=3D*/-1, /*offset=3D*/0ul);
        syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,
/*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/7ul,
/*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=3D*/-1,
/*offset=3D*/0ul);
        syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul,
/*prot=3D*/0ul, /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul,
/*fd=3D*/-1, /*offset=3D*/0ul);
        const char* reason;
        (void)reason;
        install_segv_handler();
        for (procid =3D 0; procid < 4; procid++) {
               if (fork() =3D=3D 0) {
                        do_sandbox_none();
                }
        }
        sleep(1000000);
        return 0;
}

>
>
> Kind regards,
> Niklas
