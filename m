From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 31/86] pata_hpt37x: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:06:00 +0100
Message-ID: <20091125170600.5446.70691.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932264AbZKYRGr@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_hpt37x: add 32-bit PIO support

There shouldn't be any problems with it as IDE hpt366 host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_hpt37x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_hpt37x.c
===================================================================
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -579,7 +579,7 @@ static struct scsi_host_template hpt37x_
  */
 
 static struct ata_port_operations hpt370_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 
 	.bmdma_stop	= hpt370_bmdma_stop,
 
@@ -604,7 +604,7 @@ static struct ata_port_operations hpt370
  */
 
 static struct ata_port_operations hpt372_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 
 	.bmdma_stop	= hpt37x_bmdma_stop,
 
