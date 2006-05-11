From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/10] libata-pm: update ata_eh_reset() for PM
Date: Fri, 12 May 2006 01:43:42 +0900
Message-ID: <11473658224027-git-send-email-htejun@gmail.com>
References: <11473658222012-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:19952 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030342AbWEKQn6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:43:58 -0400
Received: by py-out-1112.google.com with SMTP id f28so308104pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:43:58 -0700 (PDT)
In-Reply-To: <11473658222012-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

PM always requires SRST to be enabled.  Also, hardreset reports
classification code from the first device when PM is attached.  Update
ata_eh_reset() such that followup softreset is performed if the
controller is PM capable.

---

 drivers/scsi/libata-eh.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

dc71d3ff3a4334c93936e0a1320afd973c6f1312
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index d62a529..3ad8c01 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1420,13 +1420,16 @@ static int ata_do_reset(struct ata_link 
 	return 0;
 }
 
-static int ata_eh_followup_srst_needed(int rc, int classify,
+static int ata_eh_followup_srst_needed(struct ata_port *ap,
+				       int rc, int classify,
 				       const unsigned int *classes)
 {
 	if (rc == -EAGAIN)
 		return 1;
 	if (rc != 0)
 		return 0;
+	if (ap->flags & ATA_FLAG_PM)
+		return 1;
 	if (classify && classes[0] == ATA_DEV_UNKNOWN)
 		return 1;
 	return 0;
@@ -1436,10 +1439,11 @@ int ata_eh_reset(struct ata_link *link, 
 		 ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 		 ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
+	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int *classes = ehc->classes;
 	int tries = link->reset_tries;
-	int verbose = !(link->ap->flags & ATA_FLAG_LOADING);
+	int verbose = !(ap->flags & ATA_FLAG_LOADING);
 	unsigned int action;
 	ata_reset_fn_t reset;
 	int did_followup_srst, rc;
@@ -1493,7 +1497,7 @@ int ata_eh_reset(struct ata_link *link, 
 
 	did_followup_srst = 0;
 	if (reset == hardreset &&
-	    ata_eh_followup_srst_needed(rc, classify, classes)) {
+	    ata_eh_followup_srst_needed(ap, rc, classify, classes)) {
 		/* okay, let's do follow-up softreset */
 		did_followup_srst = 1;
 		reset = softreset;
-- 
1.2.4


