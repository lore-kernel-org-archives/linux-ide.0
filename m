From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/21] libata: implement AC_ERR_NCQ
Date: Mon, 16 Jul 2007 14:29:40 +0900
Message-ID: <11845637801052-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:24778 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760509AbXGPF3u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:50 -0400
Received: by rv-out-0910.google.com with SMTP id k20so24268rvb
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:48 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
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
 include/linux/libata.h  |    1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 96b184e..19f9947 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1195,7 +1195,7 @@ static void ata_eh_analyze_ncq_error(struct ata_port *ap)
 	/* we've got the perpetrator, condemn it */
 	qc = __ata_qc_from_tag(ap, tag);
 	memcpy(&qc->result_tf, &tf, sizeof(tf));
-	qc->err_mask |= AC_ERR_DEV;
+	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
 
@@ -1616,7 +1616,7 @@ static void ata_eh_report(struct ata_port *ap)
 			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
 			"tag %d cdb 0x%x data %u %s\n         "
 			"res %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
-			"Emask 0x%x (%s)\n",
+			"Emask 0x%x (%s)%s\n",
 			cmd->command, cmd->feature, cmd->nsect,
 			cmd->lbal, cmd->lbam, cmd->lbah,
 			cmd->hob_feature, cmd->hob_nsect,
@@ -1627,7 +1627,8 @@ static void ata_eh_report(struct ata_port *ap)
 			res->lbal, res->lbam, res->lbah,
 			res->hob_feature, res->hob_nsect,
 			res->hob_lbal, res->hob_lbam, res->hob_lbah,
-			res->device, qc->err_mask, ata_err_string(qc->err_mask));
+			res->device, qc->err_mask, ata_err_string(qc->err_mask),
+			qc->err_mask & AC_ERR_NCQ ? " <F>" : "");
 	}
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 94b37d1..cb18171 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -323,6 +323,7 @@ enum ata_completion_errors {
 	AC_ERR_INVALID		= (1 << 7), /* invalid argument */
 	AC_ERR_OTHER		= (1 << 8), /* unknown */
 	AC_ERR_NODEV_HINT	= (1 << 9), /* polling device detection hint */
+	AC_ERR_NCQ		= (1 << 10), /* marker for offending NCQ qc */
 };
 
 /* forward declarations */
-- 
1.5.0.3


