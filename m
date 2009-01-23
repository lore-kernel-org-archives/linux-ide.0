From: Mark Lord <liml@rtr.ca>
Subject: sata_mv: basic PIO-only ATAPI support?
Date: Fri, 23 Jan 2009 12:23:46 -0500
Message-ID: <4979FD22.8040407@rtr.ca>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca> <49750774.1070005@rtr.ca> <49773FD1.3040101@rtr.ca> <4977C5A5.8070202@gmail.com> <49780167.1060208@rtr.ca> <497801F9.2070009@rtr.ca> <4978028D.3020501@gmail.com> <4979FC55.1000904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:59088 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608AbZAWRXr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jan 2009 12:23:47 -0500
In-Reply-To: <4979FC55.1000904@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

(resending, with different email address for Alan).

Tejun / Alan,

I'm now venturing into the labyrinth that is presented
when one tries to combine a nice FIS-based controller/driver
with old school BMDMA for ATAPI only.

To preserve my own sanity, I'm opting for basic PIO-only
support for ATAPI to begin with.  Then I'll add the DMA functions
to speed things up afterward.

This patch (below) seems to work 100% okay for me here,
apart from the sata_mv chipset errata warnings it generates
(another thing I hope to tidy up soon-ish).

Question: is this the "right" way to force PIO-only,
or is there a better mechanism that I'm missing.

It just seems.. too easy this way.  :)

Thanks.

* * *

Add basic ATAPI support to sata_mv using PIO + polling.
DMA support will be added later.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-23 11:20:57.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-23 12:02:20.000000000 -0500
@@ -120,7 +120,7 @@
 	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
 
 	MV_COMMON_FLAGS		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
+				  ATA_FLAG_MMIO |
 				  ATA_FLAG_PIO_POLLING,
 
 	MV_6XXX_FLAGS		= MV_FLAG_IRQ_COALESCE,
@@ -502,6 +502,7 @@
 static void mv_eh_freeze(struct ata_port *ap);
 static void mv_eh_thaw(struct ata_port *ap);
 static void mv6_dev_config(struct ata_device *dev);
+static void mv_dev_config(struct ata_device *dev);
 
 static void mv5_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 			   unsigned int port);
@@ -576,6 +577,7 @@
 	.error_handler		= ata_std_error_handler, /* avoid SFF EH */
 	.post_internal_cmd	= ATA_OP_NULL,
 
+	.dev_config             = mv_dev_config,
 	.scr_read		= mv5_scr_read,
 	.scr_write		= mv5_scr_write,
 
@@ -597,7 +599,7 @@
 
 static struct ata_port_operations mv_iie_ops = {
 	.inherits		= &mv6_ops,
-	.dev_config		= ATA_OP_NULL,
+	.dev_config             = mv_dev_config,
 	.qc_prep		= mv_qc_prep_iie,
 };
 
@@ -1082,6 +1084,21 @@
 		return -EINVAL;
 }
 
+static void mv_dev_config(struct ata_device *adev)
+{
+	/*
+	 * Support ATAPI devices via PIO-only for now.
+	 * DMA support is planned for later.
+	 */
+	if (adev->class == ATA_DEV_ATAPI) {
+		adev->xfer_shift = ATA_SHIFT_PIO;
+		adev->flags |= ATA_DFLAG_PIO;
+		ata_dev_printk(adev, KERN_INFO, DRV_NAME
+				": ATAPI DMA not yet implemented;"
+				" using (slow) PIO for now\n");
+	}
+}
+
 static void mv6_dev_config(struct ata_device *adev)
 {
 	/*
@@ -1097,6 +1114,7 @@
 				"NCQ disabled for command-based switching\n");
 		}
 	}
+	mv_dev_config(adev);
 }
 
 static int mv_qc_defer(struct ata_queued_cmd *qc)
