From: Mark Lord <kernel@teksavvy.com>
Subject: [PATCH] libata-eh don't waste time retrying media errors (v3)
Date: Wed, 02 May 2012 15:22:52 -0400
Message-ID: <4FA1898C.5070108@teksavvy.com>
References: <4FA043BE.2010009@teksavvy.com> <4FA04714.7050602@teksavvy.com> <20120501215854.GA21677@google.com> <4FA07655.6090506@teksavvy.com> <4FA07932.2090003@teksavvy.com> <4FA0A3F7.7000401@teksavvy.com> <20120502155414.GB21677@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060509050007070806090505"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:48045 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab2EBTWx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2012 15:22:53 -0400
In-Reply-To: <20120502155414.GB21677@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060509050007070806090505
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ATA and SATA drives have had built-in retries for media errors
for as long as they've been commonplace in computers (early 1990s).

When libata stumbles across a bad sector, it can waste minutes
sitting there doing retry after retry before finally giving up
and letting the higher layers deal with it.

This patch removes retries for media errors only.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
version 3: try to improve readability.

--- old/drivers/ata/libata-eh.c	2012-04-27 13:17:35.000000000 -0400
+++ linux/drivers/ata/libata-eh.c	2012-05-02 15:20:19.946827031 -0400
@@ -2046,6 +2046,26 @@
 }

 /**
+ *	ata_eh_worth_retry - analyze error and decide whether to retry
+ *	@qc: qc to possibly retry
+ *
+ *	Look at the cause of the error and decide if a retry
+ * 	might be useful or not.  We don't want to retry media errors
+ *	because the drive itself has probably already taken 10-30 seconds
+ *	doing its own internal retries before reporting the failure.
+ */
+static inline int ata_eh_worth_retry(struct ata_queued_cmd *qc)
+{
+	if (qc->flags & AC_ERR_MEDIA)
+		return 0;	/* don't retry media errors */
+	if (qc->flags & ATA_QCFLAG_IO)
+		return 1;	/* otherwise retry anything from fs stack */
+	if (qc->err_mask & AC_ERR_INVALID)
+		return 0;	/* don't retry these */
+	return qc->err_mask != AC_ERR_DEV;  /* retry if not dev error */
+}
+
+/**
  *	ata_eh_link_autopsy - analyze error and determine recovery action
  *	@link: host link to perform autopsy on
  *
@@ -2119,9 +2139,7 @@
 			qc->err_mask &= ~(AC_ERR_DEV | AC_ERR_OTHER);

 		/* determine whether the command is worth retrying */
-		if (qc->flags & ATA_QCFLAG_IO ||
-		    (!(qc->err_mask & AC_ERR_INVALID) &&
-		     qc->err_mask != AC_ERR_DEV))
+		if (ata_eh_worth_retry(qc))
 			qc->flags |= ATA_QCFLAG_RETRY;

 		/* accumulate error info */

--------------060509050007070806090505
Content-Type: text/x-patch;
 name="02_libata_sata_dont_retry_media_errors.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="02_libata_sata_dont_retry_media_errors.patch"

--- old/drivers/ata/libata-eh.c	2012-04-27 13:17:35.000000000 -0400
+++ linux/drivers/ata/libata-eh.c	2012-05-02 15:20:19.946827031 -0400
@@ -2046,6 +2046,26 @@
 }
 
 /**
+ *	ata_eh_worth_retry - analyze error and decide whether to retry
+ *	@qc: qc to possibly retry
+ *
+ *	Look at the cause of the error and decide if a retry
+ * 	might be useful or not.  We don't want to retry media errors
+ *	because the drive itself has probably already taken 10-30 seconds
+ *	doing its own internal retries before reporting the failure.
+ */
+static inline int ata_eh_worth_retry(struct ata_queued_cmd *qc)
+{
+	if (qc->flags & AC_ERR_MEDIA)
+		return 0;	/* don't retry media errors */
+	if (qc->flags & ATA_QCFLAG_IO)
+		return 1;	/* otherwise retry anything from fs stack */
+	if (qc->err_mask & AC_ERR_INVALID)
+		return 0;	/* don't retry these */
+	return qc->err_mask != AC_ERR_DEV;  /* retry if not dev error */
+}
+
+/**
  *	ata_eh_link_autopsy - analyze error and determine recovery action
  *	@link: host link to perform autopsy on
  *
@@ -2119,9 +2139,7 @@
 			qc->err_mask &= ~(AC_ERR_DEV | AC_ERR_OTHER);
 
 		/* determine whether the command is worth retrying */
-		if (qc->flags & ATA_QCFLAG_IO ||
-		    (!(qc->err_mask & AC_ERR_INVALID) &&
-		     qc->err_mask != AC_ERR_DEV))
+		if (ata_eh_worth_retry(qc))
 			qc->flags |= ATA_QCFLAG_RETRY;
 
 		/* accumulate error info */

--------------060509050007070806090505--
