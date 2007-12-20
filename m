From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 59/63] ide-cd: call blk_dump_rq_flags() on "missing data" in cdrom_rw_intr()
Date: Thu, 20 Dec 2007 02:37:16 +0100
Message-ID: <200712200237.16566.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:12581 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758957AbXLTBfD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:35:03 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389392ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:35:02 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1301,10 +1301,12 @@ static ide_startstop_t cdrom_rw_intr(ide
 				 */
 				cdrom_buffer_sectors(drive, rq->sector,
 						     thislen >> 9);
-			else
+			else {
 				printk(KERN_ERR "%s: %s: confused, missing "
 						"data\n",
 						drive->name, __FUNCTION__);
+				blk_dump_rq_flags(rq, "cdrom_rw_intr, write");
+			}
 			break;
 		}
 
