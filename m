From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 60/86] pata_pdc202xx_old: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:09:33 +0100
Message-ID: <20091125170933.5446.67311.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:28343 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759337AbZKYRKM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:10:12 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_pdc202xx_old: add 32-bit PIO support

There shouldn't be any problems with it as IDE pdc202xx_old host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_pdc202xx_old.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_pdc202xx_old.c
===================================================================
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -240,7 +240,7 @@ static int pdc2026x_port_start(struct at
 		u8 burst = ioread8(bmdma + 0x1f);
 		iowrite8(burst | 0x01, bmdma + 0x1f);
 	}
-	return ata_sff_port_start(ap);
+	return ata_sff_port_start32(ap);
 }
 
 /**
@@ -266,7 +266,7 @@ static struct scsi_host_template pdc202x
 };
 
 static struct ata_port_operations pdc2024x_port_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= pdc202xx_set_piomode,
