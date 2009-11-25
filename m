From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 43/86] pata_it821x: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:07:26 +0100
Message-ID: <20091125170726.5446.18826.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932734AbZKYRIN@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_it821x: add 32-bit PIO support

There shouldn't be any problems with it as IDE it821x host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_it821x.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: b/drivers/ata/pata_it821x.c
===================================================================
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -738,7 +738,7 @@ static int it821x_port_start(struct ata_
 	struct it821x_dev *itdev;
 	u8 conf;
 
-	int ret = ata_sff_port_start(ap);
+	int ret = ata_sff_port_start32(ap);
 	if (ret < 0)
 		return ret;
 
@@ -801,7 +801,7 @@ static struct scsi_host_template it821x_
 };
 
 static struct ata_port_operations it821x_smart_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 
 	.check_atapi_dma= it821x_check_atapi_dma,
 	.qc_issue	= it821x_smart_qc_issue,
@@ -815,7 +815,7 @@ static struct ata_port_operations it821x
 };
 
 static struct ata_port_operations it821x_passthru_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 
 	.check_atapi_dma= it821x_check_atapi_dma,
 	.sff_dev_select	= it821x_passthru_dev_select,
@@ -831,7 +831,7 @@ static struct ata_port_operations it821x
 };
 
 static struct ata_port_operations it821x_rdc_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 
 	.check_atapi_dma= it821x_check_atapi_dma,
 	.sff_dev_select	= it821x_passthru_dev_select,
