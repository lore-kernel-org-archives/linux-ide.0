From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 58/86] pata_pdc2027x: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:09:18 +0100
Message-ID: <20091125170918.5446.7331.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933508AbZKYRKD@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_pdc2027x: add 32-bit PIO support

There shouldn't be any problems with it as IDE pdc202xx_new host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_pdc2027x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_pdc2027x.c
===================================================================
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -133,7 +133,7 @@ static struct scsi_host_template pdc2027
 };
 
 static struct ata_port_operations pdc2027x_pata100_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 	.check_atapi_dma	= pdc2027x_check_atapi_dma,
 	.cable_detect		= pdc2027x_cable_detect,
 	.prereset		= pdc2027x_prereset,
