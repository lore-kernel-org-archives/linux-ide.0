From: Thomas Reitmayr <treitmayr@devbase.at>
Subject: [PATCH] sata_mv: Properly initialize main irq mask
Date: Sat, 24 Jan 2009 20:24:58 +0100
Message-ID: <1232825098.13899.52.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpgw01.world4you.com ([80.243.163.21]:46908 "EHLO
	smtpgw01.world4you.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbZAXUp1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 15:45:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Saeed Bishara <saeed@marvell.com>, Lennert Buytenhek <buytenh@marvell.com>, Martin Michlmayr <tbm@cyrius.com>

Hi,
I noticed that during initialization sata_mv.c assumes that the main
interrupt mask has its default value of 0. The function
mv_platform_probe(..) initializes a shadow irq mask with 0 assuming
that's the value of the controller's register. Now
mv_set_main_irq_mask(..) only writes the controller's register if the
new value differs from the "shadowed" value. This is fatal when trying
to disable all interrupts in mv_init_host(..), i.e. the following
function call does not write anything to the main irq mask register:
  mv_set_main_irq_mask(host, ~0, 0);

The effect I see on my machine (QNAP TS-109 II) with booting via kexec
(with Linux as a 2nd-stage boot loader) is that if the sata_mv module
was still loaded when performing kexec, then the new kernel's sata_mv
module starts up with interrupts enabled. This results in an unhandled
IRQ and breaks the boot process.

The unhandled interrupt itself might also be fixed by Lennert's patch
proposed at http://markmail.org/message/kwvzxstnlsa3s26w which I did not
try yet.
However I still propose to additionally initialize the shadow variable
with the current contents of the main irq mask register to get both in
sync and allow proper disabling the main irq mask. This fixes the
unhandled irq on my machine.


Signed-off-by: Thomas Reitmayr <treitmayr@devbase.at>

--- a/drivers/ata/sata_mv.c	2008-12-25 00:26:37.000000000 +0100
+++ b/drivers/ata/sata_mv.c	2009-01-24 18:48:17.000000000 +0100
@@ -3076,6 +3076,9 @@ static int mv_init_host(struct ata_host 
 		hpriv->main_irq_mask_addr  = mmio + PCI_HC_MAIN_IRQ_MASK_OFS;
 	}
 
+	/* initialize shadow irq mask with register's value */
+	hpriv->main_irq_mask = readl(hpriv->main_irq_mask_addr);
+
 	/* global interrupt mask: 0 == mask everything */
 	mv_set_main_irq_mask(host, ~0, 0);
 
--
Best regards,
Thomas

