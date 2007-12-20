From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 09/63] ide-cd: fix 'ireason' reporting in cdrom_pc_intr()
Date: Thu, 20 Dec 2007 01:58:32 +0100
Message-ID: <200712200158.32631.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:12071 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756318AbXLTBeK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389250ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:09 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Mask 'ireason' variable so only the valid interrupt reason bits
will be reported on "drive appears confused" error.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1440,7 +1440,7 @@ static ide_startstop_t cdrom_pc_intr (id
 		return ide_stopped;
 
 	/* Read the interrupt reason and the transfer length. */
-	ireason = HWIF(drive)->INB(IDE_IREASON_REG);
+	ireason = HWIF(drive)->INB(IDE_IREASON_REG) & 0x3;
 	lowcyl  = HWIF(drive)->INB(IDE_BCOUNTL_REG);
 	highcyl = HWIF(drive)->INB(IDE_BCOUNTH_REG);
 
@@ -1481,7 +1481,7 @@ static ide_startstop_t cdrom_pc_intr (id
 	if (thislen > len) thislen = len;
 
 	/* The drive wants to be written to. */
-	if ((ireason & 3) == 0) {
+	if (ireason == 0) {
 		if (!rq->data) {
 			blk_dump_rq_flags(rq, "cdrom_pc_intr, write");
 			goto confused;
@@ -1503,7 +1503,7 @@ static ide_startstop_t cdrom_pc_intr (id
 	}
 
 	/* Same drill for reading. */
-	else if ((ireason & 3) == 2) {
+	else if (ireason == 2) {
 		if (!rq->data) {
 			blk_dump_rq_flags(rq, "cdrom_pc_intr, read");
 			goto confused;
