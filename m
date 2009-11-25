From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 77/86] pata_sis: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:11:39 +0100
Message-ID: <20091125171139.5446.21161.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934742AbZKYRMZ@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_sis: add 32-bit PIO support

There shouldn't be any problems with it as IDE sis5513 host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_sis.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_sis.c
===================================================================
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -504,14 +504,14 @@ static struct scsi_host_template sis_sht
 };
 
 static struct ata_port_operations sis_133_for_sata_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 	.set_piomode		= sis_133_set_piomode,
 	.set_dmamode		= sis_133_set_dmamode,
 	.cable_detect		= sis_133_cable_detect,
 };
 
 static struct ata_port_operations sis_base_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 	.prereset		= sis_pre_reset,
 };
 
