From: Thibaut VARENE <T-Bone@parisc-linux.org>
Subject: [RFC PATCH] pmac ide doesn't properly cleanup hwif when releasing
 controller
Date: Sat, 29 Oct 2005 04:48:52 +0200
Message-ID: <20051029044852.1a518908@Tatooine.r3z0>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sat__29_Oct_2005_04_48_52_+0200_5JSWvrjH4W4=ni_1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5-g19.free.fr ([212.27.42.35]:60060 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751090AbVJ2Crq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Oct 2005 22:47:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: benh@kernel.crashing.org

--Multipart_Sat__29_Oct_2005_04_48_52_+0200_5JSWvrjH4W4=ni_1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I've been debugging some IDE issues on my ppc box lately, and ran into the
following problem:

my machine has a "ghost" ide controller: a controller that has no physical
port and thus nothing hooked to it. The pmac ide driver first claims it,
then *tries* to release it. Unfortunately, it doesn't do that well enough,
because when one adds another (pci) controller to the box, the following
happens:

relevant snippets of dmesg output:

ide2: Found Apple KeyLargo ATA-3 controller, bus ID 1, irq 21
Probing IDE interface ide2...
ide2: Bus empty, interface released.
[...]
AEC6280R: IDE controller at PCI slot 0001:11:03.0
AEC6280R: chipset revision 7
AEC6280R: ROM enabled at 0x800a0000
AEC6280R: 100% native mode on irq 53
ide2: AEC6280R Bus-Master DMA disabled (BIOS)
    ide3: BM-DMA at 0x1008-0x100f, BIOS settings: hdg:pio, hdh:pio
kernel BUG in ide_setup_dma at drivers/ide/ide-dma.c:954!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=2
NIP: C01F1FD4 LR: C01F1FC8 SP: EE475CB0 REGS: ee475c00 TRAP: 0700    Not
tainted
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = efc89270[1562] 'insmod' THREAD: ee474000
Last syscall: 128  CPU: 1
GPR00: 00000000 EE475CB0 EFC89270 00000001 00009032 FFFFFFFF C0480000
C0489FAC
GPR08: 00008000 C03CC0B0 000023D1 C03D0000 C0480000 100196C8 100D0000
100FB468
GPR16: EE475D1A C04A8180 C04A5480 00000035 EE475DB8 00000002 C04A5480
EFFD3438
GPR24: F107A7B5 00000001 C03D0000 C03CC2CC 00000008 C04A6174 EE523000
C04A5C00
NIP [c01f1fd4] ide_setup_dma+0x284/0x5f0
LR [c01f1fc8] ide_setup_dma+0x278/0x5f0
Call trace:
 [f107a320] init_dma_aec62xx+0xa0/0x140 [aec62xx]
 [c01f06c0] ide_pci_setup_ports+0x520/0x700


Trying to debug that oops, it appears that during the initialisation
process, the generic code accesses the hwif which still contains
pmac-related (invalid) pointers, totally irrelevant to the PCI driver.
Thus, the hwif is clobbered and the first time a generic function tries to
access these pointers, the kernel oopses.

The raw "fix" to this is to not release the hwif in ide/ppc/pmac.c:1401.
Indeed, with the attached patch, the card initialization goes (almost)
fine:

AEC6280R: IDE controller at PCI slot 0001:11:03.0
AEC6280R: chipset revision 7
AEC6280R: ROM enabled at 0x800a0000
AEC6280R: 100% native mode on irq 53
    ide3: BM-DMA at 0x1000-0x1007, BIOS settings: hdg:pio, hdh:pio
    ide4: BM-DMA at 0x1008-0x100f, BIOS settings: hdi:pio, hdj:pio

(the "almost" will be detailed in a subsequent mail, it's irrelevant to
the present thread).

I've been investigating the IDE code a bit, and it seems that it generally
assumes that an interface cannot be released once claimed. Cleaning up the
hwif without knowing its previous state in pmac.c is a big and potentially
dangerous job, and there seems to be no generic code interface that would
provide either a way to properly release an hwif or to clean it up.

The rationale behind this is related to the value of MAX_HWIFS, which is
usually pretty low (usually between 2 and 10).

So the question is "what should be done (and how)"?

HTH

T-Bone

PS: please CC me in answers.
--Multipart_Sat__29_Oct_2005_04_48_52_+0200_5JSWvrjH4W4=ni_1
Content-Type: text/plain; name=pmac.c.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=pmac.c.diff

--- linux-2.6.14-rc5.old/drivers/ide/ppc/pmac.c	2005-10-29 02:32:27.000000000 +0200
+++ linux-2.6.14-rc5.new/drivers/ide/ppc/pmac.c	2005-10-29 03:22:48.000000000 +0200
@@ -1401,6 +1401,7 @@
 	/* The code IDE code will have set hwif->present if we have devices attached,
 	 * if we don't, the discard the interface except if we are on a media bay slot
 	 */
+#if 0
 	if (!hwif->present && !pmif->mediabay) {
 		printk(KERN_INFO "ide%d: Bus empty, interface released.\n",
 			hwif->index);
@@ -1411,7 +1412,7 @@
 		hwif->noprobe = 1;
 		return -ENODEV;
 	}
-
+#endif
 	return 0;
 }
 

--Multipart_Sat__29_Oct_2005_04_48_52_+0200_5JSWvrjH4W4=ni_1--
