From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/12] libata-pmp: update ata_eh_reset() for PMP
Date: Sat, 8 Jul 2006 14:58:07 +0900
Message-ID: <11523382872738-git-send-email-htejun@gmail.com>
References: <11523382873130-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:8053 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964803AbWGHF5S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:57:18 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484772wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:57:17 -0700 (PDT)
In-Reply-To: <11523382873130-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

PMP always requires SRST to be enabled.  Also, hardreset reports
classification code from the first device when PMP is attached.
Update ata_eh_reset() such that followup softreset is performed if the
controller is PMP capable.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

2cf75f99537b7ef01bacb8c1f946b1bd2f7ba975
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 122226b..0a6f17e 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1552,13 +1552,16 @@ static int ata_do_reset(struct ata_link 
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
+	if (ap->flags & ATA_FLAG_PMP)
+		return 1;
 	if (classify && classes[0] == ATA_DEV_UNKNOWN)
 		return 1;
 	return 0;
@@ -1633,7 +1636,7 @@ int ata_eh_reset(struct ata_link *link, 
 
 	did_followup_srst = 0;
 	if (reset == hardreset &&
-	    ata_eh_followup_srst_needed(rc, classify, classes)) {
+	    ata_eh_followup_srst_needed(link->ap, rc, classify, classes)) {
 		/* okay, let's do follow-up softreset */
 		did_followup_srst = 1;
 		reset = softreset;
-- 
1.3.2


