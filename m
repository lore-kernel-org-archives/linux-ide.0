From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] libata: make ata_sff_data_xfer_noirq() work with 32-bit PIO
Date: Thu, 13 Oct 2011 15:04:43 +0200
Message-ID: <201110131504.43311.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57043 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab1JMNUu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 09:20:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] libata: make ata_sff_data_xfer_noirq() work with 32-bit PIO

Always use ata_sff_data_xfer32() in ata_sff_data_xfer_noirq()
so the latter can be also used for host controllers supporting
32-bit PIO operations.

It is a completely safe thing to do because if 32-bit PIO is
not supported or enabled ata_sff_data_xfer32() will fallback
to a standard method.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
earlier references:
https://lkml.org/lkml/2009/11/25/335

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
