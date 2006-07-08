From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix autopsy ehc->i.action and ehc->i.dev handling
Date: Sat, 8 Jul 2006 20:17:26 +0900
Message-ID: <20060708111726.GC2592@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:12643 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964780AbWGHLQf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 07:16:35 -0400
Received: by nz-out-0102.google.com with SMTP id z3so1162855nzf
        for <linux-ide@vger.kernel.org>; Sat, 08 Jul 2006 04:16:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Commit 0662c58b3265f52f708a6d59476bc7862b01f9c0 updated
ata_eh_autopsy() to OR determined action to ehc->i.action to preserve
action mask set directly into ehc->i.action by nested functions.  This
broke action mask clearing on SENSE_VALID case causing revalidation
and EH complete message on successful ATAPI CC.

This patch removes two local variables - action and failed_dev - which
cache ehc->i.action and ehc->i.dev respectively, and make the function
directly modify ehc->i.* fields to remove aliasing issues.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch is against

  upstream (309bade002e9226781c2d7a015340d0089e399b5)

And available in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=autopsy-fix
  git://htj.dyndns.org/libata-tj autopsy-fix

hp-poll patchset is also updated accordingly and available at

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=hp-poll
  git://htj.dyndns.org/libata-tj hp-poll

 drivers/scsi/libata-eh.c |   29 ++++++++++++-----------------
 1 files changed, 12 insertions(+), 17 deletions(-)

9cdc7b725f215534bc7b492393baf13d7f8210de
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 4b6aa30..36a801c 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1276,8 +1276,6 @@ static int ata_eh_speed_down(struct ata_
 static void ata_eh_autopsy(struct ata_port *ap)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
-	unsigned int action = ehc->i.action;
-	struct ata_device *failed_dev = NULL;
 	unsigned int all_err_mask = 0;
 	int tag, is_io = 0;
 	u32 serror;
@@ -1294,7 +1292,7 @@ static void ata_eh_autopsy(struct ata_po
 		ehc->i.serror |= serror;
 		ata_eh_analyze_serror(ap);
 	} else if (rc != -EOPNOTSUPP)
-		action |= ATA_EH_HARDRESET;
+		ehc->i.action |= ATA_EH_HARDRESET;
 
 	/* analyze NCQ failure */
 	ata_eh_analyze_ncq_error(ap);
@@ -1315,7 +1313,7 @@ static void ata_eh_autopsy(struct ata_po
 		qc->err_mask |= ehc->i.err_mask;
 
 		/* analyze TF */
-		action |= ata_eh_analyze_tf(qc, &qc->result_tf);
+		ehc->i.action |= ata_eh_analyze_tf(qc, &qc->result_tf);
 
 		/* DEV errors are probably spurious in case of ATA_BUS error */
 		if (qc->err_mask & AC_ERR_ATA_BUS)
@@ -1329,11 +1327,11 @@ static void ata_eh_autopsy(struct ata_po
 		/* SENSE_VALID trumps dev/unknown error and revalidation */
 		if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
 			qc->err_mask &= ~(AC_ERR_DEV | AC_ERR_OTHER);
-			action &= ~ATA_EH_REVALIDATE;
+			ehc->i.action &= ~ATA_EH_REVALIDATE;
 		}
 
 		/* accumulate error info */
-		failed_dev = qc->dev;
+		ehc->i.dev = qc->dev;
 		all_err_mask |= qc->err_mask;
 		if (qc->flags & ATA_QCFLAG_IO)
 			is_io = 1;
@@ -1342,25 +1340,22 @@ static void ata_eh_autopsy(struct ata_po
 	/* enforce default EH actions */
 	if (ap->pflags & ATA_PFLAG_FROZEN ||
 	    all_err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT))
-		action |= ATA_EH_SOFTRESET;
+		ehc->i.action |= ATA_EH_SOFTRESET;
 	else if (all_err_mask)
-		action |= ATA_EH_REVALIDATE;
+		ehc->i.action |= ATA_EH_REVALIDATE;
 
 	/* if we have offending qcs and the associated failed device */
-	if (failed_dev) {
+	if (ehc->i.dev) {
 		/* speed down */
-		action |= ata_eh_speed_down(failed_dev, is_io, all_err_mask);
+		ehc->i.action |= ata_eh_speed_down(ehc->i.dev, is_io,
+						   all_err_mask);
 
 		/* perform per-dev EH action only on the offending device */
-		ehc->i.dev_action[failed_dev->devno] |=
-			action & ATA_EH_PERDEV_MASK;
-		action &= ~ATA_EH_PERDEV_MASK;
+		ehc->i.dev_action[ehc->i.dev->devno] |=
+			ehc->i.action & ATA_EH_PERDEV_MASK;
+		ehc->i.action &= ~ATA_EH_PERDEV_MASK;
 	}
 
-	/* record autopsy result */
-	ehc->i.dev = failed_dev;
-	ehc->i.action |= action;
-
 	DPRINTK("EXIT\n");
 }
 
-- 
1.3.2


