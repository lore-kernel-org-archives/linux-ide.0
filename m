From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_inic162x: disable LBA48 devices
Date: Fri, 29 Jun 2007 11:33:08 +0900
Message-ID: <46846F64.7000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:48637 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127AbXF2CdO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 22:33:14 -0400
Received: by nz-out-0506.google.com with SMTP id s18so312160nze
        for <linux-ide@vger.kernel.org>; Thu, 28 Jun 2007 19:33:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>, greg.freemyer@gmail.com

sata_inic162x can't do LBA48 properly yet and is likely to corrupt
data on drives larger than LBA28 limit.  Disable LBA48 devices during
device configuration.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_inic162x.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: work/drivers/ata/sata_inic162x.c
===================================================================
--- work.orig/drivers/ata/sata_inic162x.c
+++ work/drivers/ata/sata_inic162x.c
@@ -496,6 +496,13 @@ static void inic_dev_config(struct ata_d
 	/* inic can only handle upto LBA28 max sectors */
 	if (dev->max_sectors > ATA_MAX_SECTORS)
 		dev->max_sectors = ATA_MAX_SECTORS;
+
+	if (dev->n_sectors >= 1 << 28) {
+		ata_dev_printk(dev, KERN_ERR,
+	"ERROR: This driver doesn't support LBA48 yet and may cause\n"
+	"                data corruption on such devices.  Disabling.\n");
+		ata_dev_disable(dev);
+	}
 }
 
 static void init_port(struct ata_port *ap)
