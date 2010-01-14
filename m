From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: retry FS IOs even if it has failed
 with AC_ERR_INVALID
Date: Thu, 14 Jan 2010 16:18:09 +0900
Message-ID: <4B4EC531.2010001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38797 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755164Ab0ANHMb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Jan 2010 02:12:31 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Johannes Stezenbach <js@sig21.net>

libata currently doesn't retry if a command fails with AC_ERR_INVALID
assuming that retrying won't get it any further even if retried.
However, a failure may be classified as invalid through hardware
glitch (incorrect reading of the error register or firmware bug) and
there isn't whole lot to gain by not retrying as actually invalid
commands will be failed immediately.  Also, commands serving FS IOs
are extremely unlikely to be invalid.  Retry FS IOs even if it's
marked invalid.

Transient and incorrect invalid failure was seen while debugging
firmware related issue on Samsung n130 on bko#14314.

  http://bugzilla.kernel.org/show_bug.cgi?id=14314

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Johannes Stezenbach <js@sig21.net>
---
 drivers/ata/libata-eh.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: ata/drivers/ata/libata-eh.c
===================================================================
--- ata.orig/drivers/ata/libata-eh.c
+++ ata/drivers/ata/libata-eh.c
@@ -2028,8 +2028,9 @@ static void ata_eh_link_autopsy(struct a
 			qc->err_mask &= ~(AC_ERR_DEV | AC_ERR_OTHER);
 
 		/* determine whether the command is worth retrying */
-		if (!(qc->err_mask & AC_ERR_INVALID) &&
-		    ((qc->flags & ATA_QCFLAG_IO) || qc->err_mask != AC_ERR_DEV))
+		if (qc->flags & ATA_QCFLAG_IO ||
+		    (!(qc->err_mask & AC_ERR_INVALID) &&
+		     qc->err_mask != AC_ERR_DEV))
 			qc->flags |= ATA_QCFLAG_RETRY;
 
 		/* accumulate error info */
