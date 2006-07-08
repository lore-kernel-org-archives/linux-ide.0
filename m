From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/17] libata-link: implement link->reset_tries
Date: Sat, 8 Jul 2006 14:45:37 +0900
Message-ID: <11523375372603-git-send-email-htejun@gmail.com>
References: <11523375353473-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:42863 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932519AbWGHFos (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:44:48 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484118wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:44:48 -0700 (PDT)
In-Reply-To: <11523375353473-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make reset_tries per-link property.  PMP links will use different
value from host links.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |    2 +-
 include/linux/libata.h     |    2 ++
 3 files changed, 4 insertions(+), 1 deletions(-)

1987fc0ec41d15c84201e07980cf55c2ccb06b4f
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9a8c73e..95488ea 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5341,6 +5341,7 @@ static void ata_link_init(struct ata_por
 	link->ap = ap;
 	link->active_tag = ATA_TAG_POISON;
 	link->hw_sata_spd_limit = UINT_MAX;
+	link->reset_tries = ATA_EH_RESET_TRIES;
 
 	ata_link_for_each_dev(dev, link) {
 		dev->link = link;
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index d574486..db6e132 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1508,7 +1508,7 @@ static int ata_eh_reset(struct ata_link 
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int *classes = ehc->classes;
-	int tries = ATA_EH_RESET_TRIES;
+	int tries = link->reset_tries;
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
 	struct ata_device *dev;
 	unsigned int action;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 506f72d..b24f21d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -506,6 +506,8 @@ struct ata_link {
 	unsigned int		hw_sata_spd_limit;
 	unsigned int		sata_spd_limit;
 
+	int			reset_tries;
+
 	/* record runtime error info, protected by host_set lock */
 	struct ata_eh_info	eh_info;
 	/* EH context */
-- 
1.3.2


