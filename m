From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: stop being overjealous about non-IO commands
Date: Fri, 26 Oct 2007 16:12:41 +0900
Message-ID: <20071026071241.GM11853@htj.dyndns.org>
References: <20071026065359.GL11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:17208 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758432AbXJZHOD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 03:14:03 -0400
Received: by rv-out-0910.google.com with SMTP id k20so709656rvb
        for <linux-ide@vger.kernel.org>; Fri, 26 Oct 2007 00:14:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071026065359.GL11853@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: ballen@gravity.phys.uwm.edu

libata EH always revalidated device and retried failed command after
error except for ATAPI CCs.  This is unnecessary and hinders with
users issuing direct commands.  This patch makes the following
changes.

* Make sata_sil24 not request ATA_EH_REVALIDATE on device errors.
  sil24 is the only driver which does this.  All others let libata EH
  core code decide.

* Don't request revalidation after device error of non-IO command.
  Revalidation doesn't really help anybody.  As ATA_EH_REVALIDATE
  isn't set by default, there's no reason to clear it after sense data
  is read.  Kill ATA_EH_REVALIDATE clearing code while at it.

* Don't retry non-IO command after device error.  Device has rejected
  the command.  There's no point in retrying.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c  |   16 +++++++++++-----
 drivers/ata/sata_sil24.c |    6 +++---
 2 files changed, 14 insertions(+), 8 deletions(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -1800,10 +1800,8 @@ static void ata_eh_link_autopsy(struct a
 			qc->err_mask &= ~AC_ERR_OTHER;
 
 		/* SENSE_VALID trumps dev/unknown error and revalidation */
-		if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
+		if (qc->flags & ATA_QCFLAG_SENSE_VALID)
 			qc->err_mask &= ~(AC_ERR_DEV | AC_ERR_OTHER);
-			ehc->i.action &= ~ATA_EH_REVALIDATE;
-		}
 
 		/* accumulate error info */
 		ehc->i.dev = qc->dev;
@@ -1816,7 +1814,8 @@ static void ata_eh_link_autopsy(struct a
 	if (ap->pflags & ATA_PFLAG_FROZEN ||
 	    all_err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT))
 		ehc->i.action |= ATA_EH_SOFTRESET;
-	else if (all_err_mask)
+	else if ((is_io && all_err_mask) ||
+		 (!is_io && (all_err_mask & ~AC_ERR_DEV)))
 		ehc->i.action |= ATA_EH_REVALIDATE;
 
 	/* if we have offending qcs and the associated failed device */
@@ -2674,8 +2673,15 @@ void ata_eh_finish(struct ata_port *ap)
 			/* FIXME: Once EH migration is complete,
 			 * generate sense data in this function,
 			 * considering both err_mask and tf.
+			 *
+			 * There's no point in retrying invalid
+			 * (detected by libata) and non-IO device
+			 * errors (rejected by device).  Finish them
+			 * immediately.
 			 */
-			if (qc->err_mask & AC_ERR_INVALID)
+			if ((qc->err_mask & AC_ERR_INVALID) ||
+			    (!(qc->flags & ATA_QCFLAG_IO) &&
+			     qc->err_mask == AC_ERR_DEV))
 				ata_eh_qc_complete(qc);
 			else
 				ata_eh_qc_retry(qc);
Index: work/drivers/ata/sata_sil24.c
===================================================================
--- work.orig/drivers/ata/sata_sil24.c
+++ work/drivers/ata/sata_sil24.c
@@ -265,11 +265,11 @@ static struct sil24_cerr_info {
 	unsigned int err_mask, action;
 	const char *desc;
 } sil24_cerr_db[] = {
-	[0]			= { AC_ERR_DEV, ATA_EH_REVALIDATE,
+	[0]			= { AC_ERR_DEV, 0,
 				    "device error" },
-	[PORT_CERR_DEV]		= { AC_ERR_DEV, ATA_EH_REVALIDATE,
+	[PORT_CERR_DEV]		= { AC_ERR_DEV, 0,
 				    "device error via D2H FIS" },
-	[PORT_CERR_SDB]		= { AC_ERR_DEV, ATA_EH_REVALIDATE,
+	[PORT_CERR_SDB]		= { AC_ERR_DEV, 0,
 				    "device error via SDB FIS" },
 	[PORT_CERR_DATA]	= { AC_ERR_ATA_BUS, ATA_EH_SOFTRESET,
 				    "error in data FIS" },
