From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 30/86] pata_hpt366: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:05:52 +0100
Message-ID: <20091125170552.5446.8900.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932186AbZKYRGj@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_hpt366: add 32-bit PIO support

There shouldn't be any problems with it as IDE hpt366 host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_hpt366.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_hpt366.c
===================================================================
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -283,7 +283,7 @@ static struct scsi_host_template hpt36x_
  */
 
 static struct ata_port_operations hpt366_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 	.cable_detect	= hpt36x_cable_detect,
 	.mode_filter	= hpt366_filter,
 	.set_piomode	= hpt366_set_piomode,
