From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 46/63] ide-cd: call blk_dump_rq_flags() on "missing data" in cdrom_newpc_intr()
Date: Thu, 20 Dec 2007 02:27:51 +0100
Message-ID: <200712200227.51519.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:11731 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758911AbXLTBeu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:50 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389245ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1343,7 +1343,11 @@ static ide_startstop_t cdrom_newpc_intr(
 		}
 
 		if (!ptr) {
-			printk(KERN_ERR "%s: confused, missing data\n", drive->name);
+			printk(KERN_ERR "%s: confused, missing data\n",
+					drive->name);
+			blk_dump_rq_flags(rq, rq_data_dir(rq)
+					      ? "cdrom_newpc_intr, write"
+					      : "cdrom_newpc_intr, read");
 			break;
 		}
 
