From: Richard Kang <turquesa@malgn.com>
Subject: Re: qc timeout on a marvell 88F6282 board
Date: Thu, 07 Jul 2011 12:00:22 +0900
Message-ID: <4E152146.60909@malgn.com>
References: <4E0AEAB1.4090106@malgn.com>	<CAMAG_ef0y=Jg=8eQSWj_e8kwGAtFwJXsvPATiL1fkq57kVzubA@mail.gmail.com>	<4E12CAD1.3030302@malgn.com>	<CAMAG_efStJsEeZrdf-eSq89aHrji3t5+RYO+arrUYiAQpn7LgQ@mail.gmail.com>	<4E14040F.9030503@malgn.com>	<CAMAG_efiyOdFCs4TAe0NusQ7yxLFg6gyajqSX51a965jEPioJw@mail.gmail.com> <CAMAG_edjasMffHA2tozzBEUWf27BPvjF_=fOL_N9oktTyTradQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [125.7.223.35] ([125.7.223.35]:64611 "EHLO mail.malgn.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752916Ab1GGDA1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Jul 2011 23:00:27 -0400
In-Reply-To: <CAMAG_edjasMffHA2tozzBEUWf27BPvjF_=fOL_N9oktTyTradQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed bishara <saeed.bishara@gmail.com>
Cc: linux-ide@vger.kernel.org

2011-07-06 =EC=98=A4=ED=9B=84 5:16, saeed bishara =EC=93=B4 =EA=B8=80:
> On Wed, Jul 6, 2011 at 11:07 AM, saeed bishara<saeed.bishara@gmail.co=
m>  wrote:
>> Richard,
>>
>>   this board is supported by mainline kernel, can you try latest
>> version (3.0-rcX)?
> in order to do that, you need to build the kernel with "make
> kirkwood_defconfig",
> then do the following from u-boot:
> Marvell>>  setenv mainlineLinux yes
> Marvell>>  setenv arcNumber 1680
> Marvell>>  saveenv
> Marvell>>  reset
>
Dear saeed,

I tried to build the kernel with "make kirkwood_defconfig".
But, during "make uImage", some errors occurred.

Is it impossible to excute your (u-boot) commands with kernel image by=20
"make mv_kw_defconfig" ?

Thank you.
-----------------------------------------------------------------------=
-------------------------------------
scripts/kconfig/conf -s arch/arm/Kconfig
   CHK     include/linux/version.h
   UPD     include/linux/version.h
   Generating include/asm-arm/mach-types.h
   CHK     include/linux/utsrelease.h
   UPD     include/linux/utsrelease.h
   SYMLINK include/asm -> include/asm-arm
   CC      kernel/bounds.s
   GEN     include/linux/bounds.h
   CC      arch/arm/kernel/asm-offsets.s
   GEN     include/asm/asm-offsets.h
   CALL    scripts/checksyscalls.sh
<stdin>:1351:2: warning: #warning syscall migrate_pages not implemented
<stdin>:1407:2: warning: #warning syscall pselect6 not implemented
<stdin>:1411:2: warning: #warning syscall ppoll not implemented
<stdin>:1451:2: warning: #warning syscall epoll_pwait not implemented
   CC      scripts/mod/empty.o
   HOSTCC  scripts/mod/mk_elfconfig
   MKELF   scripts/mod/elfconfig.h
   HOSTCC  scripts/mod/file2alias.o
   HOSTCC  scripts/mod/modpost.o
scripts/mod/modpost.c: In function =E2=80=98get_markers=E2=80=99:
scripts/mod/modpost.c:1562:12: warning: ignoring return value of=20
=E2=80=98asprintf=E2=80=99, declared with attribute warn_unused_result
scripts/mod/modpost.c: In function =E2=80=98add_marker=E2=80=99:
scripts/mod/modpost.c:1982:10: warning: ignoring return value of=20
=E2=80=98asprintf=E2=80=99, declared with attribute warn_unused_result
   HOSTCC  scripts/mod/sumversion.o
   HOSTLD  scripts/mod/modpost
   HOSTCC  scripts/kallsyms
scripts/kallsyms.c: In function =E2=80=98read_symbol=E2=80=99:
scripts/kallsyms.c:112:9: warning: ignoring return value of =E2=80=98fg=
ets=E2=80=99,=20
declared with attribute warn_unused_result
   HOSTCC  scripts/conmakehash
   CC      init/main.o
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   CC      init/do_mounts.o
   LD      init/mounts.o
   CC      init/noinitramfs.o
   CC      init/calibrate.o
   LD      init/built-in.o
   LD      usr/built-in.o
   CC      arch/arm/kernel/compat.o
   CC      arch/arm/kernel/elf.o
   AS      arch/arm/kernel/entry-armv.o
   AS      arch/arm/kernel/entry-common.o
   CC      arch/arm/kernel/irq.o
   CC      arch/arm/kernel/process.o
   CC      arch/arm/kernel/ptrace.o
   CC      arch/arm/kernel/setup.o
   CC      arch/arm/kernel/signal.o
   CC      arch/arm/kernel/sys_arm.o
   CC      arch/arm/kernel/stacktrace.o
   CC      arch/arm/kernel/time.o
   CC      arch/arm/kernel/traps.o
   CC      arch/arm/kernel/armksyms.o
   CC      arch/arm/kernel/module.o
   CC      arch/arm/kernel/bios32.o
   CC      arch/arm/kernel/isa.o
   CC      arch/arm/kernel/kprobes.o
   CC      arch/arm/kernel/kprobes-decode.o
   CC      arch/arm/kernel/unwind.o
   CC      arch/arm/kernel/io.o
   AS      arch/arm/kernel/debug.o
   LD      arch/arm/kernel/built-in.o
   AS      arch/arm/kernel/head.o
   CC      arch/arm/kernel/init_task.o
   LDS     arch/arm/kernel/vmlinux.lds
   CC      arch/arm/mm/dma-mapping.o
   CC      arch/arm/mm/extable.o
   CC      arch/arm/mm/fault.o
   CC      arch/arm/mm/init.o
   CC      arch/arm/mm/iomap.o
   CC      arch/arm/mm/fault-armv.o
   CC      arch/arm/mm/flush.o
   CC      arch/arm/mm/ioremap.o
   CC      arch/arm/mm/mmap.o
   CC      arch/arm/mm/pgd.o
   CC      arch/arm/mm/mmu.o
arch/arm/mm/mmu.c: In function 'sanity_check_meminfo':
arch/arm/mm/mmu.c:690: warning: unused variable 'highmem'
   CC      arch/arm/mm/proc-syms.o
   CC      arch/arm/mm/alignment.o
   AS      arch/arm/mm/abort-ev5t.o
   CC      arch/arm/mm/copypage-feroceon.o
/tmp/ccyqzNzD.s: Assembler messages:
/tmp/ccyqzNzD.s:38: Error: selected processor does not support `pld=20
[lr,#32]'
/tmp/ccyqzNzD.s:39: Error: selected processor does not support `pld=20
[lr,#64]'
/tmp/ccyqzNzD.s:40: Error: selected processor does not support `pld=20
[lr,#96]'
/tmp/ccyqzNzD.s:41: Error: selected processor does not support `pld=20
[lr,#128]'
/tmp/ccyqzNzD.s:42: Error: selected processor does not support `pld=20
[lr,#160]'
/tmp/ccyqzNzD.s:43: Error: selected processor does not support `pld=20
[lr,#192]'
/tmp/ccyqzNzD.s:44: Error: selected processor does not support `pld=20
[lr,#224]'
make[1]: *** [arch/arm/mm/copypage-feroceon.o] Error 1
make: *** [arch/arm/mm] Error 2
-----------------------------------------------------------------------=
-------------------------------------
