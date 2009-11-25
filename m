From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 03/86] pata_artop: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:02:39 +0100
Message-ID: <20091125170239.5446.26287.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758930AbZKYRDX@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_artop: add 32-bit PIO support

There shouldn't be any problems with it as IDE aec62xx host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_artop.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_artop.c
===================================================================
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -312,7 +312,7 @@ static struct scsi_host_template artop_s
 };
 
 static struct ata_port_operations artop6210_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= artop6210_set_piomode,
 	.set_dmamode		= artop6210_set_dmamode,
@@ -321,7 +321,7 @@ static struct ata_port_operations artop6
 };
 
 static struct ata_port_operations artop6260_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 	.cable_detect		= artop6260_cable_detect,
 	.set_piomode		= artop6260_set_piomode,
 	.set_dmamode		= artop6260_set_dmamode,
