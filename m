From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 75/86] pata_sl82c105: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:11:24 +0100
Message-ID: <20091125171124.5446.28864.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:39574 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759396AbZKYRMD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:12:03 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_sl82c105: add 32-bit PIO support

There shouldn't be any problems with it as IDE sl82c105 host driver
has been using 32-bit PIO operations for years.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_sl82c105.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_sl82c105.c
===================================================================
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -232,7 +232,7 @@ static struct scsi_host_template sl82c10
 };
 
 static struct ata_port_operations sl82c105_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 	.qc_defer	= sl82c105_qc_defer,
 	.bmdma_start 	= sl82c105_bmdma_start,
 	.bmdma_stop	= sl82c105_bmdma_stop,
