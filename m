From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata: pata_pdc2027x minor fix
Date: Thu, 10 Nov 2005 14:04:22 +0800
Message-ID: <4372E2E6.6000605@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:57252 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751108AbVKJGEo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Nov 2005 01:04:44 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jAA64Yco025301
	for <linux-ide@vger.kernel.org>; Thu, 10 Nov 2005 01:04:34 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jAA64TxP021584
	for <linux-ide@vger.kernel.org>; Wed, 9 Nov 2005 23:04:29 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jAA64Xxq012706
	for <linux-ide@vger.kernel.org>; Wed, 9 Nov 2005 23:04:34 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Jeff,

  Minor fix for pata_pdc2027x to compile with recent changes, etc.

Changes:
  - eliminate use of drivers/scsi/scsi.h compatibility header
  - use dev_printk() where appropriate
  - add MODULE_VERSION(DRV_VERSION);

Patch against the libata-dev pata-drivers branch 
(4879116e78e14200b1fda18ebb948a415bf2b124).

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

=======

--- linux/drivers/scsi/pata_pdc2027x.c	2005-11-10 13:24:07.000000000 +0800
+++ linux-build/drivers/scsi/pata_pdc2027x.c	2005-11-10 13:25:42.000000000 +0800
@@ -28,13 +28,15 @@
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
-#include "scsi.h"
+#include <linux/device.h>
+#include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.72"
+#define DRV_VERSION	"0.73"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -125,7 +127,7 @@ static struct pci_driver pdc2027x_pci_dr
 	.remove			= __devexit_p(pdc2027x_remove_one),
 };
 
-static Scsi_Host_Template pdc2027x_sht = {
+static struct scsi_host_template pdc2027x_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
 	.ioctl			= ata_scsi_ioctl,
@@ -229,6 +231,7 @@ static struct ata_port_info pdc2027x_por
 MODULE_AUTHOR("Andre Hedrick, Frank Tiernan, Albert Lee");
 MODULE_DESCRIPTION("libata driver module for Promise PDC20268 to PDC20277");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
 MODULE_DEVICE_TABLE(pci, pdc2027x_pci_tbl);
 
 /**
@@ -690,7 +693,7 @@ static int pdc_hardware_init(struct pci_
 	if (pll_clock < 0) /* counter overflow? Try again. */
 		pll_clock = pdc_detect_pll_input_clock(pe);
 
-	printk(KERN_INFO DRV_NAME ": PLL input clock %ld kHz\n", pll_clock/1000);
+	dev_printk(KERN_INFO, &pdev->dev, "PLL input clock %ld kHz\n", pll_clock/1000);
 
 	/* Adjust PLL control register */
 	pdc_adjust_pll(pe, pll_clock, board_idx);
@@ -742,7 +745,7 @@ static int __devinit pdc2027x_init_one(s
 	int rc;
 
 	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
 	rc = pci_enable_device(pdev);
 	if (rc)


