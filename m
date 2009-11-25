From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 32/86] pata_hpt3x2n: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:06:07 +0100
Message-ID: <20091125170607.5446.33065.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932404AbZKYRWy@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_hpt3x2n: add 32-bit PIO support

There shouldn't be any problems with it as IDE hpt366 host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_hpt3x2n.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_hpt3x2n.c
===================================================================
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -335,7 +335,7 @@ static struct scsi_host_template hpt3x2n
  */
 
 static struct ata_port_operations hpt3x2n_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 
 	.bmdma_stop	= hpt3x2n_bmdma_stop,
 	.qc_issue	= hpt3x2n_qc_issue,
