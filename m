From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 44/86] pata_jmicron: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:07:33 +0100
Message-ID: <20091125170733.5446.10355.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932899AbZKYRI2@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_jmicron: add 32-bit PIO support

There shouldn't be any problems with it as IDE jmicron host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_jmicron.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_jmicron.c
===================================================================
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -112,7 +112,7 @@ static struct scsi_host_template jmicron
 };
 
 static struct ata_port_operations jmicron_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 	.prereset		= jmicron_pre_reset,
 };
 
