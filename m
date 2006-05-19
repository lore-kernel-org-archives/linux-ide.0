From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/14] libata-hp-prep: implement followup softreset handling
Date: Fri, 19 May 2006 06:16:41 -0700 (PDT)
Message-ID: <11480445851340-git-send-email-htejun@gmail.com>
References: <11480445833568-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:19937 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932249AbWESNQm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:16:42 -0400
Received: by py-out-1112.google.com with SMTP id z59so920074pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:16:42 -0700 (PDT)
In-Reply-To: <11480445833568-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

In some cases, hardreset must be followed by SRST.

* some controllers can't classify with hardreset
* some controllers can't wait for !BSY after hardreset (LLDD should
  explicitly request followup softreset by returning -EAGAIN)
* (later) PM needs SRST w/ PMP==15 to operate after hardreset

To handle above cases, this patch implements follow-up softreset.
After a hardreset, ata_eh_reset() checks whether any of above
conditions are met and do a follow-up softreset if necessary.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   58 +++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 52 insertions(+), 6 deletions(-)

ce8c79e15ae26381f0e32b532a594c2f86037065
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 4ec50d4..c76fab0 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1281,16 +1281,28 @@ static void ata_eh_report(struct ata_por
 	}
 }
 
-static int ata_eh_reset(struct ata_port *ap,
+static int ata_eh_followup_srst_needed(int rc, int classify,
+				       const unsigned int *classes)
+{
+	if (rc == -EAGAIN)
+		return 1;
+	if (rc != 0)
+		return 0;
+	if (classify && classes[0] == ATA_DEV_UNKNOWN)
+		return 1;
+	return 0;
+}
+
+static int ata_eh_reset(struct ata_port *ap, int classify,
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
-	unsigned int classes[ATA_MAX_DEVICES];
+	unsigned int *classes = ehc->classes;
 	int tries = ATA_EH_RESET_TRIES;
 	unsigned int action;
 	ata_reset_fn_t reset;
-	int i, rc;
+	int i, did_followup_srst, rc;
 
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
@@ -1344,10 +1356,44 @@ static int ata_eh_reset(struct ata_port 
 
 	rc = ata_do_reset(ap, reset, classes);
 
+	did_followup_srst = 0;
+	if (reset == hardreset &&
+	    ata_eh_followup_srst_needed(rc, classify, classes)) {
+		/* okay, let's do follow-up softreset */
+		did_followup_srst = 1;
+		reset = softreset;
+
+		if (!reset) {
+			ata_port_printk(ap, KERN_ERR,
+					"follow-up softreset required "
+					"but no softreset avaliable\n");
+			return -EINVAL;
+		}
+
+		ata_eh_about_to_do(ap, ATA_EH_RESET_MASK);
+		rc = ata_do_reset(ap, reset, classes);
+
+		if (rc == 0 && classify &&
+		    classes[0] == ATA_DEV_UNKNOWN) {
+			ata_port_printk(ap, KERN_ERR,
+					"classification failed\n");
+			return -EINVAL;
+		}
+	}
+
 	if (rc && --tries) {
+		const char *type;
+
+		if (reset == softreset) {
+			if (did_followup_srst)
+				type = "follow-up soft";
+			else
+				type = "soft";
+		} else
+			type = "hard";
+
 		ata_port_printk(ap, KERN_WARNING,
-				"%sreset failed, retrying in 5 secs\n",
-				reset == softreset ? "soft" : "hard");
+				"%sreset failed, retrying in 5 secs\n", type);
 		ssleep(5);
 
 		if (reset == hardreset)
@@ -1465,7 +1511,7 @@ static int ata_eh_recover(struct ata_por
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
 		ata_eh_freeze_port(ap);
 
-		rc = ata_eh_reset(ap, prereset, softreset, hardreset,
+		rc = ata_eh_reset(ap, 0, prereset, softreset, hardreset,
 				  postreset);
 		if (rc) {
 			ata_port_printk(ap, KERN_ERR,
-- 
1.3.2

