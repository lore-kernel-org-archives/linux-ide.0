From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 08/86] pata_atiixp: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:03:15 +0100
Message-ID: <20091125170315.5446.61323.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759013AbZKYRD5@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_atiixp: add 32-bit PIO support

There shouldn't be any problems with it as IDE atiixp host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_atiixp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_atiixp.c
===================================================================
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -206,7 +206,7 @@ static struct scsi_host_template atiixp_
 };
 
 static struct ata_port_operations atiixp_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 
 	.qc_prep 	= ata_sff_dumb_qc_prep,
 	.bmdma_start 	= atiixp_bmdma_start,
