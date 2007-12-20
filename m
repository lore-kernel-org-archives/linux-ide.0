From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 08/63] ide-cd: fix error message in cdrom_pc_intr()
Date: Thu, 20 Dec 2007 01:57:46 +0100
Message-ID: <200712200157.46753.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:11731 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717AbXLTBeJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:09 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389245ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:08 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1505,7 +1505,7 @@ static ide_startstop_t cdrom_pc_intr (id
 	/* Same drill for reading. */
 	else if ((ireason & 3) == 2) {
 		if (!rq->data) {
-			blk_dump_rq_flags(rq, "cdrom_pc_intr, write");
+			blk_dump_rq_flags(rq, "cdrom_pc_intr, read");
 			goto confused;
 		}
 		/* Transfer the data. */
