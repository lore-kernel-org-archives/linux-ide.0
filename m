From: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: PIIX5 Doesn't work on IA64 (2.6.0-test9)
Date: Fri, 21 Nov 2003 09:35:27 +1100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <16317.16815.981658.437235@wombat.disy.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Received: From wombat.disy.cse.unsw.edu.au ([129.94.239.42])
	(for <linux-ide@vger.kernel.org>)
	(for <linux-kernel@vger.kernel.org>)
	(for <linux-ia64@vger.kernel.org>) By note With Smtp ;
	Fri, 21 Nov 2003 09:35:28 +1100
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,
	The PIIX5 IDE controller on I2000 IA64 boxen using the 460GX
chipset will hang on startup if an ordinary harddrive is plugged into
it (it seems to workj for the LSI120 and the CDROM drives).

This is because the 460GX chipset contains a PCI expanssion bridge
that works like the 450NX PXB, and has the same PCI ID (but a later
revision).  The PIIX driver, to work around interactions between PIIX4
and the 450NX PXB, tries to disable DMA.

Unfortunately, the way it tries to disable DMA doesn't work, and the
higher layers think that DMA is still on, and so timeout waiting for
DMA, and then hang on bootup.

A simple workaround is to tighten the check for the buggy chipset, as
in the attached patch.  However, someone with more time (and who
actually *understands* the IDE subsystem) needs to fix the real bug as
well.

===== piix.c 1.20 vs edited =====
--- 1.20/drivers/ide/pci/piix.c	Wed Oct 22 09:27:24 2003
+++ edited/piix.c	Fri Nov 21 09:28:43 2003
@@ -768,8 +768,8 @@
 		/* Only on the original revision: IDE DMA can hang */
 		if(rev == 0x00)
 			no_piix_dma = 1;
-		/* On all revisions PXB bus lock must be disabled for IDE */
-		else if(cfg & (1<<14))
+		/* On all revisions below 5 PXB bus lock must be disabled for IDE */
+		else if(cfg & (1<<14) && rev < 5)
 			no_piix_dma = 2;
 	}
 	if(no_piix_dma)
