From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/12] libata: implement AC_ERR_NCQ
Date: Sun, 1 Jul 2007 18:53:37 +0900
Message-ID: <11832836172598-git-send-email-htejun@gmail.com>
References: <118328361627-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:30760 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbXGAJxm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 05:53:42 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1876599wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 02:53:41 -0700 (PDT)
In-Reply-To: <118328361627-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

When an NCQ command fails, all commands in flight are aborted and the
offending one is reported using log page 10h.  Depending on controller
characteristics and LLD implementation, all commands may appear as
having a device error due to shared TF status making it hard to
determine what's actually going on.

This patch adds AC_ERR_NCQ, marks the command reported by log page 10h
with it and print extra "<F>" after the error report for the command
to help distinguishing the offending command.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    7 ++++---
 include/linux/libata.h  |    3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 744665a..8d8961f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1130,7 +1130,7 @@ static void ata_eh_analyze_ncq_error(struct ata_port *ap)
 	/* we've got the perpetrator, condemn it */
 	qc = __ata_qc_from_tag(ap, tag);
 	memcpy(&qc->result_tf, &tf, sizeof(tf));
-	qc->err_mask |= AC_ERR_DEV;
+	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
 
@@ -1551,7 +1551,7 @@ static void ata_eh_report(struct ata_port *ap)
 			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
 			"tag %d cdb 0x%x data %u %s\n         "
 			"res %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
-			"Emask 0x%x (%s)\n",
+			"Emask 0x%x (%s)%s\n",
 			cmd->command, cmd->feature, cmd->nsect,
 			cmd->lbal, cmd->lbam, cmd->lbah,
 			cmd->hob_feature, cmd->hob_nsect,
@@ -1562,7 +1562,8 @@ static void ata_eh_report(struct ata_port *ap)
 			res->lbal, res->lbam, res->lbah,
 			res->hob_feature, res->hob_nsect,
 			res->hob_lbal, res->hob_lbam, res->hob_lbah,
-			res->device, qc->err_mask, ata_err_string(qc->err_mask));
+			res->device, qc->err_mask, ata_err_string(qc->err_mask),
+			qc->err_mask & AC_ERR_NCQ ? " <F>" : "");
 	}
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8d3e391..c2cad0f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -322,7 +322,8 @@ enum ata_completion_errors {
 	AC_ERR_SYSTEM		= (1 << 6), /* system error */
 	AC_ERR_INVALID		= (1 << 7), /* invalid argument */
 	AC_ERR_OTHER		= (1 << 8), /* unknown */
-	AC_ERR_NODEV_HINT	= (1 << 9), /* polling device detection hint */
+	AC_ERR_NCQ		= (1 << 9), /* marker for offending NCQ qc */
+	AC_ERR_NODEV_HINT	= (1 << 10), /* polling device detection hint */
 };
 
 /* forward declarations */
-- 
1.5.0.3


