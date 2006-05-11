From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/14] libata-hp-prep: implement followup softreset handling
Date: Fri, 12 May 2006 00:02:35 +0900
Message-ID: <11473597553871-git-send-email-htejun@gmail.com>
References: <11473597542442-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:65058 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751834AbWEKPCq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:02:46 -0400
Received: by wr-out-0506.google.com with SMTP id i12so385619wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:02:46 -0700 (PDT)
In-Reply-To: <11473597542442-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

In some cases, hardreset must be followed by SRST.

* some controllers can't classify with hardreset
* some controllers can't wait for !BSY after hardreset (LLDD should
  explicitly request followup softreset by returning -EAGAIN)
* (later) PM needs SRST w/ PMP==15 to operate after hardreset

To handle above cases, this patch implements follow-up softreset.
After a hardreset, ata_eh_reset() checks whether any of above
conditions are met and do a follow-up softreset if necessary.

---

 drivers/scsi/libata-eh.c |   58 +++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 52 insertions(+), 6 deletions(-)

413da5b8b08f955db5665d06a497ab7170469363
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index ee046c1..9dfaa66 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1284,16 +1284,28 @@ static void ata_eh_report(struct ata_por
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
 	 * prereset() may examine it to determine what kind of
@@ -1339,10 +1351,44 @@ static int ata_eh_reset(struct ata_port 
 
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
@@ -1460,7 +1506,7 @@ static int ata_eh_recover(struct ata_por
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
 		ata_eh_freeze_port(ap);
 
-		rc = ata_eh_reset(ap, prereset, softreset, hardreset,
+		rc = ata_eh_reset(ap, 0, prereset, softreset, hardreset,
 				  postreset);
 		if (rc) {
 			ata_port_printk(ap, KERN_ERR,
-- 
1.2.4


