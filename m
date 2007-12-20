From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 05/63] ide-cd: add missing 'ireason' masking to cdrom_write_intr()
Date: Thu, 20 Dec 2007 01:55:17 +0100
Message-ID: <200712200155.17499.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:11752 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbXLTBeG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:06 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389251ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:05 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Mask 'ireason' variable with 0x3 so the valid interrupt reason value
is passed to cdrom_write_check_ireason() for checking.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1820,7 +1820,7 @@ static ide_startstop_t cdrom_write_intr(
 	}
 
 	/* Read the interrupt reason and the transfer length. */
-	ireason = HWIF(drive)->INB(IDE_IREASON_REG);
+	ireason = HWIF(drive)->INB(IDE_IREASON_REG) & 0x3;
 	lowcyl  = HWIF(drive)->INB(IDE_BCOUNTL_REG);
 	highcyl = HWIF(drive)->INB(IDE_BCOUNTH_REG);
 
