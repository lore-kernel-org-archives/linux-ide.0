From: Mark Lord <kernel@teksavvy.com>
Subject: [PATCH] libata-eh don't waste time retrying media errors
Date: Tue, 01 May 2012 20:00:50 -0400
Message-ID: <4FA07932.2090003@teksavvy.com>
References: <4FA043BE.2010009@teksavvy.com> <4FA04714.7050602@teksavvy.com> <20120501215854.GA21677@google.com> <4FA07655.6090506@teksavvy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060402090400070502040009"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:50636 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364Ab2EBAAz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2012 20:00:55 -0400
In-Reply-To: <4FA07655.6090506@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060402090400070502040009
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ATA and SATA drives have had built-in retries for media errors
for as long as they've been commonplace in computers (early 1990s).

When libata stumbles across a bad sector, it can waste minutes
sitting there doing retry after retry before finally giving up
and letting the higher layers deal with it.

This patch removes retries for media errors only.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- linux-3.3.4/drivers/ata/libata-eh.c	2012-04-27 13:17:35.000000000 -0400
+++ linux/drivers/ata/libata-eh.c	2012-05-01 19:53:55.586811975 -0400
@@ -2121,8 +2121,9 @@
 		/* determine whether the command is worth retrying */
 		if (qc->flags & ATA_QCFLAG_IO ||
 		    (!(qc->err_mask & AC_ERR_INVALID) &&
-		     qc->err_mask != AC_ERR_DEV))
-			qc->flags |= ATA_QCFLAG_RETRY;
+		     !(qc->err_mask & AC_ERR_DEV)))
+			if (!(qc->err_mask & AC_ERR_MEDIA))
+				qc->flags |= ATA_QCFLAG_RETRY;

 		/* accumulate error info */
 		ehc->i.dev = qc->dev;

--------------060402090400070502040009
Content-Type: text/x-patch;
 name="02_libata_sata_dont_retry_media_errors.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="02_libata_sata_dont_retry_media_errors.patch"

Prevent libata from retrying bad sectors.
Otherwise a single bad sector gets stuck here for minutes at a time.

--- linux-3.3.4/drivers/ata/libata-eh.c	2012-04-27 13:17:35.000000000 -0400
+++ linux/drivers/ata/libata-eh.c	2012-05-01 19:53:55.586811975 -0400
@@ -2121,8 +2121,9 @@
 		/* determine whether the command is worth retrying */
 		if (qc->flags & ATA_QCFLAG_IO ||
 		    (!(qc->err_mask & AC_ERR_INVALID) &&
-		     qc->err_mask != AC_ERR_DEV))
-			qc->flags |= ATA_QCFLAG_RETRY;
+		     !(qc->err_mask & AC_ERR_DEV)))
+			if (!(qc->err_mask & AC_ERR_MEDIA))
+				qc->flags |= ATA_QCFLAG_RETRY;
 
 		/* accumulate error info */
 		ehc->i.dev = qc->dev;

--------------060402090400070502040009--
