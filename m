From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: implement and use ATA_QCFLAG_QUIET
Date: Fri, 26 Oct 2007 16:19:26 +0900
Message-ID: <20071026071926.GN11853@htj.dyndns.org>
References: <20071026065359.GL11853@htj.dyndns.org> <20071026071241.GM11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:25918 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764078AbXJZHTh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 03:19:37 -0400
Received: by rv-out-0910.google.com with SMTP id k20so710850rvb
        for <linux-ide@vger.kernel.org>; Fri, 26 Oct 2007 00:19:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071026071241.GM11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: ballen@gravity.phys.uwm.edu

Implement ATA_QCFLAG_QUIET which indicates that there's no need to
report if the command fails with AC_ERR_DEV and set it for passthrough
commands.

Combined with previous changes, this now makes device errors for all
direct commands reported directly to the issuer without going through
EH actions and reporting.

Note that EH is still invoked after non-IO device errors to determine
the nature of the error and resume command execution (some controller
requires special care after error to continue).  It just performs
default maintenance after error, examines what's going on, realizes
that it's none of its business and reports the command failure without
logging any error messages.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c   |    4 +++-
 drivers/ata/libata-scsi.c |    4 ++--
 include/linux/libata.h    |    1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -1878,7 +1878,9 @@ static void ata_eh_link_report(struct at
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
 
-		if (!(qc->flags & ATA_QCFLAG_FAILED) || qc->dev->link != link)
+		if (!(qc->flags & ATA_QCFLAG_FAILED) || qc->dev->link != link ||
+		    ((qc->flags & ATA_QCFLAG_QUIET) &&
+		     qc->err_mask == AC_ERR_DEV))
 			continue;
 		if (qc->flags & ATA_QCFLAG_SENSE_VALID && !qc->err_mask)
 			continue;
Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -2699,8 +2699,8 @@ static unsigned int ata_scsi_pass_thru(s
 	 */
 	qc->nbytes = scsi_bufflen(scmd);
 
-	/* request result TF */
-	qc->flags |= ATA_QCFLAG_RESULT_TF;
+	/* request result TF and be quiet about device error */
+	qc->flags |= ATA_QCFLAG_RESULT_TF | ATA_QCFLAG_QUIET;
 
 	return 0;
 
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -218,6 +218,7 @@ enum {
 	ATA_QCFLAG_IO		= (1 << 3), /* standard IO command */
 	ATA_QCFLAG_RESULT_TF	= (1 << 4), /* result TF requested */
 	ATA_QCFLAG_CLEAR_EXCL	= (1 << 5), /* clear excl_link on completion */
+	ATA_QCFLAG_QUIET	= (1 << 6), /* don't report device error */
 
 	ATA_QCFLAG_FAILED	= (1 << 16), /* cmd failed and is owned by EH */
 	ATA_QCFLAG_SENSE_VALID	= (1 << 17), /* sense data valid */
