From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/14] libata-link: update ata_dev_configure() to deal with PM links
Date: Fri, 12 May 2006 01:30:23 +0900
Message-ID: <1147365023184-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:37003 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751860AbWEKQae (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:34 -0400
Received: by wr-out-0506.google.com with SMTP id i12so405467wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:34 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_dev_configure() to deal with PM links.

---

 drivers/scsi/libata-core.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

17a1cd83a17e3c44a2732ff2e77320f79b8565cd
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 740e831..32ea394 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1314,7 +1314,7 @@ int ata_dev_configure(struct ata_device 
 {
 	struct ata_port *ap = dev->link->ap;
 	const u16 *id = dev->id;
-	struct ata_device *tdev;
+	struct ata_link *tlink;
 	unsigned int xfer_mask;
 	int rc;
 
@@ -1437,10 +1437,13 @@ int ata_dev_configure(struct ata_device 
 	}
 
 	ap->host->max_cmd_len = 0;
-	ata_link_for_each_dev(tdev, dev->link) {
-		ap->host->max_cmd_len = max_t(unsigned int,
-					      ap->host->max_cmd_len,
-					      tdev->cdb_len);
+	ata_port_for_each_link(tlink, ap) {
+		struct ata_device *tdev;
+		ata_link_for_each_dev(tdev, tlink) {
+			ap->host->max_cmd_len = max_t(unsigned int,
+						      ap->host->max_cmd_len,
+						      tdev->cdb_len);
+		}
 	}
 
 	/* limit bridge transfers to udma5, 200 sectors */
-- 
1.2.4


