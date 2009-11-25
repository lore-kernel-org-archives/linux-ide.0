From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 80/86] libata: make ata_sff_data_xfer_noirq() work with 32-bit PIO
Date: Wed, 25 Nov 2009 18:12:04 +0100
Message-ID: <20091125171204.5446.97471.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52976 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934782AbZKYRMm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:12:42 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] libata: make ata_sff_data_xfer_noirq() work with 32-bit PIO

Always use ata_sff_data_xfer32() in ata_sff_data_xfer_noirq()
so the latter can be also used for host controllers supporting
32-bit PIO operations.

[ It is safe since if 32-bit PIO is not supported or enabled
  ata_sff_data_xfer32() will fallback to a standard method. ]

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/libata-sff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/libata-sff.c
===================================================================
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -838,7 +838,7 @@ unsigned int ata_sff_data_xfer_noirq(str
 	unsigned int consumed;
 
 	local_irq_save(flags);
-	consumed = ata_sff_data_xfer(dev, buf, buflen, rw);
+	consumed = ata_sff_data_xfer32(dev, buf, buflen, rw);
 	local_irq_restore(flags);
 
 	return consumed;
