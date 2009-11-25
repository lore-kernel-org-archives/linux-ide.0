From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 34/86] pata_it8213: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:06:21 +0100
Message-ID: <20091125170621.5446.10720.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932402AbZKYRHK@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_it8213: add 32-bit PIO support

There shouldn't be any problems with it as IDE it8213 host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_it8213.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_it8213.c
===================================================================
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -235,7 +235,7 @@ static struct scsi_host_template it8213_
 
 
 static struct ata_port_operations it8213_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 	.cable_detect		= it8213_cable_detect,
 	.set_piomode		= it8213_set_piomode,
 	.set_dmamode		= it8213_set_dmamode,
