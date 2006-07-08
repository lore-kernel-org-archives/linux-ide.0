From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/17] libata-link: update ata_dev_configure() to deal with PMP links
Date: Sat, 8 Jul 2006 14:45:38 +0900
Message-ID: <11523375382704-git-send-email-htejun@gmail.com>
References: <11523375353473-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:41839 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964780AbWGHFow (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:44:52 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484119wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:44:51 -0700 (PDT)
In-Reply-To: <11523375353473-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_dev_configure() to deal with PMP links.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

6ed21e82bcfd8f7aa256f072fee6332682a4671f
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0cf2661..3604fce 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1330,14 +1330,20 @@ static void ata_dev_config_ncq(struct at
 
 static void ata_set_port_max_cmd_len(struct ata_port *ap)
 {
-	struct ata_device *dev;
+	struct ata_link *link;
+
+	if (!ap->host)
+		return;
+
+	ap->host->max_cmd_len = 0;
 
-	if (ap->host) {
-		ap->host->max_cmd_len = 0;
-		ata_link_for_each_dev(dev, &ap->link)
+	ata_port_for_each_link(link, ap) {
+		struct ata_device *dev;
+		ata_link_for_each_dev(dev, link) {
 			ap->host->max_cmd_len = max_t(unsigned int,
 						      ap->host->max_cmd_len,
 						      dev->cdb_len);
+		}
 	}
 }
 
-- 
1.3.2


