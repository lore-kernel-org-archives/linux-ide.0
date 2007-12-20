From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/63] ide-cd: fix "missing data" handling in cdrom_pc_intr()
Date: Thu, 20 Dec 2007 02:01:31 +0100
Message-ID: <200712200201.31860.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:11604 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757247AbXLTBeN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:13 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389244ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:12 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


If drive still wants to transfer the data we need to pad the transfer
instead of just finishing the request.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1500,9 +1500,11 @@ static ide_startstop_t cdrom_pc_intr (id
 
 	if (xferfunc) {
 		if (!rq->data) {
+			printk(KERN_ERR "%s: confused, missing data\n",
+					drive->name);
 			blk_dump_rq_flags(rq, write ? "cdrom_pc_intr, write"
 						    : "cdrom_pc_intr, read");
-			goto confused;
+			goto pad;
 		}
 		/* Transfer the data. */
 		xferfunc(drive, rq->data, thislen);
@@ -1515,7 +1517,6 @@ static ide_startstop_t cdrom_pc_intr (id
 		if (write && blk_sense_request(rq))
 			rq->sense_len += thislen;
 	} else {
-confused:
 		printk (KERN_ERR "%s: cdrom_pc_intr: The drive "
 			"appears confused (ireason = 0x%02x). "
 			"Trying to recover by ending request.\n",
@@ -1524,7 +1525,7 @@ confused:
 		cdrom_end_request(drive, 0);
 		return ide_stopped;
 	}
-
+pad:
 	/*
 	 * If we haven't moved enough data to satisfy the drive,
 	 * add some padding.
