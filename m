From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 68/86] pata_sc1200: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:10:32 +0100
Message-ID: <20091125171032.5446.61591.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933618AbZKYRLX@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_sc1200: add 32-bit PIO support

There shouldn't be any problems with it as IDE sc1200 host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_sc1200.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_sc1200.c
===================================================================
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -208,7 +208,7 @@ static struct scsi_host_template sc1200_
 };
 
 static struct ata_port_operations sc1200_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 	.qc_prep 	= ata_sff_dumb_qc_prep,
 	.qc_issue	= sc1200_qc_issue,
 	.qc_defer	= sc1200_qc_defer,
