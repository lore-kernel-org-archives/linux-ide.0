From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 79/86] pata_triflex: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:11:55 +0100
Message-ID: <20091125171155.5446.41850.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753527AbZKYRMm@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_triflex: add 32-bit PIO support

There shouldn't be any problems with it as IDE triflex host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_triflex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_triflex.c
===================================================================
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -179,7 +179,7 @@ static struct scsi_host_template triflex
 };
 
 static struct ata_port_operations triflex_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 	.bmdma_start 	= triflex_bmdma_start,
 	.bmdma_stop	= triflex_bmdma_stop,
 	.cable_detect	= ata_cable_40wire,
