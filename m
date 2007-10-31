From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/6] libata: more robust reset failure handling
Date: Wed, 31 Oct 2007 10:17:04 +0900
Message-ID: <11937934272813-git-send-email-htejun@gmail.com>
References: <11937934273607-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.235.223.38] ([222.235.223.38]:1274 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbXJaBdq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 21:33:46 -0400
In-Reply-To: <11937934273607-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Reset failure is a critical error.  It results in disabling the link
requiring user intervention to re-enable it.  Make reset failure
handling more robust such that libata EH doesn't give up too early.

* Temporary glitches during hardreset may lead to classification
  failure when there's no softreset available.  Retry instead of
  giving up.

* Initial softreset or follow up softreset may fail classification.
  Move classification error handling block out of followup softreset
  block such that both cases are handled and retry instead of giving
  up.  Also, on the last try, give ATA class a blind shot.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index e0de689..10af1a8 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2164,25 +2164,32 @@ int ata_eh_reset(struct ata_link *link, int classify,
 					"follow-up softreset required "
 					"but no softreset avaliable\n");
 			rc = -EINVAL;
-			goto out;
+			goto fail;
 		}
 
 		ata_eh_about_to_do(link, NULL, ATA_EH_RESET_MASK);
 		rc = ata_do_reset(link, reset, classes, deadline);
-
-		if (rc == 0 && classify && classes[0] == ATA_DEV_UNKNOWN &&
-		    !(lflags & ATA_LFLAG_ASSUME_CLASS)) {
-			ata_link_printk(link, KERN_ERR,
-					"classification failed\n");
-			rc = -EINVAL;
-			goto out;
-		}
 	}
 
 	/* -EAGAIN can happen if we skipped followup SRST */
 	if (rc && rc != -EAGAIN)
 		goto fail;
 
+	/* was classification successful? */
+	if (classify && classes[0] == ATA_DEV_UNKNOWN &&
+	    !(lflags & ATA_LFLAG_ASSUME_CLASS)) {
+		if (try < max_tries) {
+			ata_link_printk(link, KERN_WARNING,
+					"classification failed\n");
+			rc = -EINVAL;
+			goto fail;
+		}
+
+		ata_link_printk(link, KERN_WARNING,
+				"classfication failed, assuming ATA\n");
+		lflags |= ATA_LFLAG_ASSUME_ATA;
+	}
+
 	ata_link_for_each_dev(dev, link) {
 		/* After the reset, the device state is PIO 0 and the
 		 * controller state is undefined.  Reset also wakes up
-- 
1.5.2.4

