From: "Joel Soete" <soete.joel@tiscali.be>
Subject: RE: [parisc-linux] Re: a fix for NS87415 on C3K broken
Date: Thu, 23 Sep 2004 18:21:38 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4152E6450000004C@mail-3-bnl.tiscali.it>
References: <41501936000007AF@mail-7-bnl.tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-3-bnl.tiscali.it ([213.205.33.223]:16221 "EHLO
	mail-3-bnl.tiscali.it") by vger.kernel.org with ESMTP
	id S266481AbUIWQVm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Sep 2004 12:21:42 -0400
In-Reply-To: <41501936000007AF@mail-7-bnl.tiscali.it>
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@parisc-linux.org>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, parisc-linux@parisc-linux.org

Hello Grant,

Sorry for auto-reply but an update:

[...]]
> > BTW, I've prepared a patch which moves IDE knowledge
> > out of superio.c driver and into drivers/ide/pci/ns87415.c.
> > I've not submitted it yet because I haven't successfully tested it
> > and it still contains debug printk's.
> > It builds and anyone curious is welcome to look at it:
> >     ftp://ftp.parisc-linux.org/patches/diff-2.6.9-rc2-ns87415_sucky=
io_cleanup-01
> >
> I will also try it :)
>=20
I apply Matthew's patch and it boot fine :)

I also launch a loop to build the kernel and seems to works fine (5 or =
6
build already :) ; but could not be significant :( ).

But when I try to use the ide-cdrom the system carsh with such oops:
Backtrace:
 [<000000001017e0d8>] drain_array_locked+0x98/0x148
 [<000000001017e2c4>] cache_reap+0x13c/0x2b0
 [<000000001015e574>] worker_thread+0x284/0x330
 [<0000000010164714>] kthread+0x12c/0x138
 [<000000001010647c>] ret_from_kernel_thread+0x24/0x38


Kernel Fault: Code=3D15 regs=3D0000000010b4c600 (Addr=3D0000000390cc9ce=
4)

     YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
PSW: 00001000000001000000000000001110 Not tainted
r00-03  0000000000000000 0000000010433c80 000000001017d3f0 00000000104e=
9830
r04-07  00000000106c2680 00000000106c2690 0000000000000011 000000001061=
c420
r08-11  0000000000000018 00000000106c26b0 0000000010aea010 000000000020=
0000
r12-15  0000000000100000 000000003b9ac800 0000000000000000 00000000f040=
0004
r16-19  00000000f00008c4 00000000f000017c 00000000f0000174 0000000390cc=
9cbc
r20-23  ffffffffe01f8123 0000000010975628 0000000000000000 000000003f6e=
c800
r24-27  0000000000001fe0 000000001fe07edd 00000000000000cc 000000001061=
c420
r28-31  00000000e01f8123 0000000000007edd 0000000010b4c600 000000000000=
8000
sr0-3   0000000000309800 0000000000000000 0000000000000000 000000000030=
9800
sr4-7   0000000000000000 0000000000000000 0000000000000000 000000000000=
0000

IASQ: 0000000000000000 0000000000000000 IAOQ: 000000001017d420 00000000=
1017d424
 IIR: 6a750050    ISR: 0000000000000000  IOR: 0000000390cc9ce4
 CPU:        0   CR30: 0000000010b4c000 CR31: 00000000105dc000
 ORIG_R28: 0000000010175f54
 IAOQ[0]: free_block+0xf8/0x1b8
 IAOQ[1]: free_block+0xfc/0x1b8
 RP(r2): free_block+0xc8/0x1b8
Kernel panic - not syncing: Kernel Fault

Sometime just after the mount of cdrom; sometime when I launch some ls =
-l
/cdrom or a find /cdrom ?

I tried to revert your patch and the crash seems to hapen at another pl=
ace:
Backtrace:
 [<0000000010399934>] alloc_skb+0x6c/0x130
 [<00000000103986a0>] sock_alloc_send_pskb+0x180/0x300
 [<0000000010398848>] sock_alloc_send_skb+0x28/0x40
 [<00000000103c4168>] ip_append_data+0x6b8/0xa70
 [<00000000103eb138>] udp_sendmsg+0x188/0x758
 [<00000000103f5b5c>] inet_sendmsg+0x6c/0xb0
 [<0000000010394288>] sock_sendmsg+0xc8/0x108
 [<000000001041ff2c>] svc_sendto+0x2c4/0x2d8
 [<00000000104206f4>] svc_udp_sendto+0x2c/0x70
 [<0000000010422300>] svc_send+0x198/0x210
 [<000000001041ee54>] svc_process+0x2e4/0x8f8
 [<0000000010238be8>] nfsd+0x268/0x4e8
 [<000000001010647c>] ret_from_kernel_thread+0x24/0x38


Kernel Fault: Code=3D15 regs=3D000000001e204f00 (Addr=3D0000000191b0911=
8)

     YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
PSW: 00001000000001001111111100001110 Not tainted
r00-03  0000000000000000 0000000010433b38 0000000010399934 000000001061=
c400
r04-07  000000000800000f 0000000000000600 000000001061c400 000000001f14=
2a68
r08-11  0000000000000000 00000000000005fb 000000001e204b08 000000001f14=
2b78
r12-15  0000000000000008 000000001ec10680 0000000000000000 000000000000=
0014
r16-19  00000000000005dc 000000001061c400 0000000000000008 0000000191b0=
9108
r20-23  0000000030203009 0000000010af10c0 0000000000000000 000000000000=
0001
r24-27  0000000000000000 00000000000000d0 00000000106c2b00 000000001061=
c400
r28-31  000000001eb166c0 000000001e204e70 000000001e204f00 000000000000=
0001
sr0-3   000000000031c000 0000000000000000 0000000000000000 000000000031=
c000
sr4-7   0000000000000000 0000000000000000 0000000000000000 000000000000=
0000

IASQ: 0000000000000000 0000000000000000 IAOQ: 000000001017da18 00000000=
1017da1c
 IIR: 527c0020    ISR: 0000000000000000  IOR: 0000000191b09118
 CPU:        0   CR30: 000000001e204000 CR31: 00000000105dc000
 ORIG_R28: 00000000103b12f0
 IAOQ[0]: __kmalloc+0xb0/0xd8
 IAOQ[1]: __kmalloc+0xb4/0xd8
 RP(r2): alloc_skb+0x6c/0x130
Kernel panic - not syncing: Kernel Fault

I do the same test with 2.6.8.1-pa7 and all seems ok.

I just noticed this following warning at the compile time:
hppa64-linux-gcc -Wp,-MD,drivers/ide/.ide-iops.o.d -nostdinc -iwithpref=
ix
include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraph=
s
-fno-strict-aliasing -fno-common -O2 -fomit-frame-pointer  -pipe -mno-s=
pace-regs
-mfast-indirect-calls -ffunction-sections -march=3D2.0 -mschedule=3D800=
0 -Idrivers/ide
  -DKBUILD_BASENAME=3Dide_iops -DKBUILD_MODNAME=3Dide_core -c -o driver=
s/ide/ide-iops.o
drivers/ide/ide-iops.c
drivers/ide/ide-iops.c: In function `ide_mm_insw':
drivers/ide/ide-iops.c:125: warning: passing arg 1 of `__ide_mm_insw' m=
akes
integer from pointer without a cast
drivers/ide/ide-iops.c: In function `ide_mm_insl':
drivers/ide/ide-iops.c:135: warning: passing arg 1 of `__ide_mm_insl' m=
akes
integer from pointer without a cast
drivers/ide/ide-iops.c: In function `ide_mm_outsw':
drivers/ide/ide-iops.c:155: warning: passing arg 1 of `__ide_mm_outsw' =
makes
integer from pointer without a cast
drivers/ide/ide-iops.c: In function `ide_mm_outsl':
drivers/ide/ide-iops.c:165: warning: passing arg 1 of `__ide_mm_outsl' =
makes
integer from pointer without a cast

but don't think it had any matter related to the crash.

Sorry not enough time to investigate more right now but if somebody can
drive me to the right way, all idea are wellcome ;)

TIA,
    Joel


-----------------------------------------------------------------------=
----
Tiscali ADSL GO, 29,50 Euro/mois pendant toute une ann=E9e, profitez-en=
=2E..
http://reg.tiscali.be/adsl/welcome.asp?lg=3DFR




