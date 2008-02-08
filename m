From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_ninja32: setup changes
Date: Fri, 8 Feb 2008 15:25:10 +0000
Message-ID: <20080208152510.06d9af0a@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44581 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750874AbYBHPcO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 10:32:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Forcibly set more of the configuration at init time. This seems to fix at
least one problem reported. We don't know what most of these bits do, but
we do know what windows stuffs there.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-mm1/drivers/ata/pata_ninja32.c linux-2.6.24-mm1/drivers/ata/pata_ninja32.c
--- linux.vanilla-2.6.24-mm1/drivers/ata/pata_ninja32.c	2008-02-06 14:14:39.000000000 +0000
+++ linux-2.6.24-mm1/drivers/ata/pata_ninja32.c	2008-02-06 14:31:57.000000000 +0000
@@ -17,6 +17,7 @@
  *	Base + 0x00 IRQ Status
  *	Base + 0x01 IRQ control
  *	Base + 0x02 Chipset control
+ *	Base + 0x03 Unknown
  *	Base + 0x04 VDMA and reset control + wait bits
  *	Base + 0x08 BMIMBA
  *	Base + 0x0C DMA Length
@@ -174,8 +175,12 @@
 	ata_std_ports(&ap->ioaddr);
 
 	iowrite8(0x05, base + 0x01);	/* Enable interrupt lines */
-	iowrite8(0xB3, base + 0x02);	/* Burst, ?? setup */
-	iowrite8(0x00, base + 0x04);	/* WAIT0 ? */
+	iowrite8(0xBE, base + 0x02);	/* Burst, ?? setup */
+	iowrite8(0x01, base + 0x03);	/* Unknown */
+	iowrite8(0x20, base + 0x04);	/* WAIT0 */
+	iowrite8(0x8f, base + 0x05);	/* Unknown */
+	iowrite8(0xa4, base + 0x1c);	/* Unknown */
+	iowrite8(0x83, base + 0x1d);	/* BMDMA control: WAIT0 */
 	/* FIXME: Should we disable them at remove ? */
 	return ata_host_activate(host, dev->irq, ata_interrupt,
 				 IRQF_SHARED, &ninja32_sht);
