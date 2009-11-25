From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 25/86] pata_cs5530: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:05:18 +0100
Message-ID: <20091125170518.5446.92173.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:28023 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759199AbZKYRFz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:05:55 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cs5530: add 32-bit PIO support

There shouldn't be any problems with it as IDE cs5530 host driver
has been allowing 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cs5530.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_cs5530.c
===================================================================
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -165,7 +165,7 @@ static struct scsi_host_template cs5530_
 };
 
 static struct ata_port_operations cs5530_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 
 	.qc_prep 	= ata_sff_dumb_qc_prep,
 	.qc_issue	= cs5530_qc_issue,
