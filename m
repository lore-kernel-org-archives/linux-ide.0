From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/14] libata-link: implement link->reset_tries
Date: Fri, 12 May 2006 01:30:23 +0900
Message-ID: <1147365023773-git-send-email-htejun@gmail.com>
References: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:39563 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751698AbWEKQae (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:34 -0400
Received: by wr-out-0506.google.com with SMTP id i12so405462wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:34 -0700 (PDT)
In-Reply-To: <11473650221713-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make reset_tries per-link property.  PM links will use different value
from host links.

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |    2 +-
 include/linux/libata.h     |    2 ++
 3 files changed, 4 insertions(+), 1 deletions(-)

c7399562f682d7f2684a5f8fa95fc74583907031
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index de0f56f..11405a4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5116,6 +5116,7 @@ static void ata_link_init(struct ata_por
 	link->pmp = pmp;
 	link->active_tag = ATA_TAG_POISON;
 	link->hw_sata_spd_limit = UINT_MAX;
+	link->reset_tries = ATA_EH_RESET_TRIES;
 
 	ata_link_for_each_dev(dev, link) {
 		dev->link = link;
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 06e6523..97a1b4d 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1375,7 +1375,7 @@ static int ata_eh_reset(struct ata_link 
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int *classes = ehc->classes;
-	int tries = ATA_EH_RESET_TRIES;
+	int tries = link->reset_tries;
 	int verbose = !(link->ap->flags & ATA_FLAG_LOADING);
 	unsigned int action;
 	ata_reset_fn_t reset;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 61fddbf..8feaf04 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -479,6 +479,8 @@ struct ata_link {
 	unsigned int		hw_sata_spd_limit;
 	unsigned int		sata_spd_limit;
 
+	int			reset_tries;
+
 	/* record runtime error info, protected by host_set lock */
 	struct ata_eh_info	eh_info;
 	/* EH context */
-- 
1.2.4


