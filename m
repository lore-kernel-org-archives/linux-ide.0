From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 54/86] pata_ns87415: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:08:48 +0100
Message-ID: <20091125170848.5446.51732.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933214AbZKYRJe@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_ns87415: add 32-bit PIO support

There shouldn't be any problems with it as IDE ns87415 host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_ns87415.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_ns87415.c
===================================================================
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -300,7 +300,7 @@ static u8 ns87560_bmdma_status(struct at
 #endif		/* 87560 SuperIO Support */
 
 static struct ata_port_operations ns87415_pata_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 
 	.check_atapi_dma	= ns87415_check_atapi_dma,
 	.bmdma_setup		= ns87415_bmdma_setup,
