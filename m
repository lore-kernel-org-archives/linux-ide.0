From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/18] [PATCH] libata-link: implement link->reset_tries
Date: Mon, 16 Oct 2006 07:54:41 +0900
Message-ID: <11609528813292-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:44920 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422927AbWJOWyx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:53 -0400
Received: by py-out-1112.google.com with SMTP id n25so2072150pyg
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:52 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make reset_tries per-link property.  PMP links will use different
value from host links.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    1 +
 drivers/ata/libata-eh.c   |    2 +-
 include/linux/libata.h    |    2 ++
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f5a9ac2..67e08e3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5411,6 +5411,7 @@ static void ata_link_init(struct ata_por
 	link->ap = ap;
 	link->active_tag = ATA_TAG_POISON;
 	link->hw_sata_spd_limit = UINT_MAX;
+	link->reset_tries = ATA_EH_RESET_TRIES;
 
 	ata_link_for_each_dev(dev, link) {
 		dev->link = link;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c75f9b0..9b16bc6 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1522,7 +1522,7 @@ static int ata_eh_reset(struct ata_link 
 {
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int *classes = ehc->classes;
-	int tries = ATA_EH_RESET_TRIES;
+	int tries = link->reset_tries;
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
 	struct ata_device *dev;
 	unsigned int action;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6241891..02e21a7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -537,6 +537,8 @@ struct ata_link {
 	unsigned int		hw_sata_spd_limit;
 	unsigned int		sata_spd_limit;
 
+	int			reset_tries;
+
 	/* record runtime error info, protected by host_set lock */
 	struct ata_eh_info	eh_info;
 	/* EH context */
-- 
1.4.2.3


