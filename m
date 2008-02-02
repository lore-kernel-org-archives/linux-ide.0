From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-scsi: remove needless SELECT_DRIVE() call
Date: Sat, 2 Feb 2008 19:06:33 +0100
Message-ID: <200802021906.33277.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.242]:63281 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933510AbYBBSZH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 13:25:07 -0500
Received: by ag-out-0708.google.com with SMTP id 35so298072aga.10
        for <linux-ide@vger.kernel.org>; Sat, 02 Feb 2008 10:25:06 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


SELECT_DRIVE() is called by IDE core code in start_request() before device
driver's ->do_request method.  In ide-scsi case ->do_request is implemented
by idescsi_do_request() which is also the only user of idescsi_issue_pc().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
goes before "ide: unexport SELECT_DRIVE()" patch in IDE quilt tree

 drivers/scsi/ide-scsi.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -588,8 +588,6 @@ static ide_startstop_t idescsi_issue_pc 
 		hwif->sg_mapped = 0;
 	}
 
-	SELECT_DRIVE(drive);
-
 	ide_pktcmd_tf_load(drive, IDE_TFLAG_NO_SELECT_MASK, bcount, dma);
 
 	if (dma)
