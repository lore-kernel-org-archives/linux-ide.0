From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/4] pata_atp867x: clarifications in timings calculations and cable detection
Date: Wed, 7 Oct 2009 00:27:03 +0200
Message-ID: <200910070027.04071.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:57767 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933442AbZJFW1u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2009 18:27:50 -0400
Received: by bwz6 with SMTP id 6so3689755bwz.37
        for <linux-ide@vger.kernel.org>; Tue, 06 Oct 2009 15:27:12 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "John Lee (Jung-Ik)" <jilee@google.com>, linux-ide@vger.kernel.org

From: John(Jung-Ik) Lee <jilee@google.com>
Subject: [PATCH] pata_atp867x: clarifications in timings calculations and cable detection

Signed-off-by: John(Jung-Ik) Lee <jilee@google.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_atp867x.c |   52 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 14 deletions(-)

Index: b/drivers/ata/pata_atp867x.c
===================================================================
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -149,8 +149,10 @@ static void atp867x_set_dmamode(struct a
 	iowrite8(b, dp->dma_mode);
 }
 
-static int atp867x_get_active_clocks_shifted(unsigned int clk)
+static int atp867x_get_active_clocks_shifted(struct ata_port *ap,
+	unsigned int clk)
 {
+	struct atp867x_priv *dp = ap->private_data;
 	unsigned char clocks = clk;
 
 	switch (clocks) {
@@ -159,15 +161,25 @@ static int atp867x_get_active_clocks_shi
 		break;
 	case 1 ... 7:
 		break;
-	case 8 ... 12:
+	case 9 ... 12:
 		clocks = 7;
 		break;
 	default:
 		printk(KERN_WARNING "ATP867X: active %dclk is invalid. "
 			"Using default 8clk.\n", clk);
-		clocks = 0;	/* 8 clk */
-		break;
+	case 8:	/* default 8 clk */
+		clocks = 0;
+		goto active_clock_shift_done;
 	}
+
+	/*
+	 * Doc 6.6.9: increase the clock value by 1 for safer PIO speed
+	 * on 66MHz bus
+	 */
+	if (dp->pci66mhz && clocks < 7)
+		clocks++;
+
+active_clock_shift_done:
 	return clocks << ATP867X_IO_PIOSPD_ACTIVE_SHIFT;
 }
 
@@ -181,20 +193,19 @@ static int atp867x_get_recover_clocks_sh
 		break;
 	case 1 ... 11:
 		break;
-	case 12:
-		clocks = 0;
-		break;
 	case 13: case 14:
-		--clocks;
+		--clocks;	/* by the spec */
 		break;
 	case 15:
 		break;
 	default:
 		printk(KERN_WARNING "ATP867X: recover %dclk is invalid. "
-			"Using default 15clk.\n", clk);
-		clocks = 0;	/* 12 clk */
+			"Using default 12clk.\n", clk);
+	case 12:	/* default 12 clk */
+		clocks = 0;
 		break;
 	}
+
 	return clocks << ATP867X_IO_PIOSPD_RECOVER_SHIFT;
 }
 
@@ -223,10 +234,8 @@ static void atp867x_set_piomode(struct a
 		b = (b & ~ATP867X_IO_DMAMODE_MSTR_MASK);
 	iowrite8(b, dp->dma_mode);
 
-	b = atp867x_get_active_clocks_shifted(t.active) |
+	b = atp867x_get_active_clocks_shifted(ap, t.active) |
 		atp867x_get_recover_clocks_shifted(t.recover);
-	if (dp->pci66mhz)
-		b += 0x10;
 
 	if (adev->devno & 1)
 		iowrite8(b, dp->slave_piospd);
@@ -239,9 +248,24 @@ static void atp867x_set_piomode(struct a
 	iowrite8(b, dp->eightb_piospd);
 }
 
+static int atp867x_cable_override(struct pci_dev *pdev)
+{
+	if (pdev->subsystem_vendor == PCI_VENDOR_ID_ARTOP &&
+		(pdev->subsystem_device == PCI_DEVICE_ID_ARTOP_ATP867A ||
+		 pdev->subsystem_device == PCI_DEVICE_ID_ARTOP_ATP867B)) {
+		return 1;
+	}
+	return 0;
+}
+
 static int atp867x_cable_detect(struct ata_port *ap)
 {
-	return ATA_CBL_PATA40_SHORT;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
+	if (atp867x_cable_override(pdev))
+		return ATA_CBL_PATA40_SHORT;
+
+	return ATA_CBL_PATA_UNK;
 }
 
 static struct scsi_host_template atp867x_sht = {
