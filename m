From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 15/18] [PATCH] libata-link: update ata_dev_configure() to deal with PMP links
Date: Mon, 16 Oct 2006 07:54:42 +0900
Message-ID: <11609528822325-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:44920 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422936AbWJOWy5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:57 -0400
Received: by py-out-1112.google.com with SMTP id n25so2072150pyg
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:57 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_dev_configure() to deal with PMP links.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0ef6ab0..98ed9fd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1363,10 +1363,13 @@ static void ata_set_port_max_cmd_len(str
 {
 	if (ap->scsi_host) {
 		unsigned int len = 0;
-		struct ata_device *dev;
+		struct ata_link *link;
 
-		ata_link_for_each_dev(dev, &ap->link)
-			len = max(len, dev->cdb_len);
+		ata_port_for_each_link(link, ap) {
+			struct ata_device *dev;
+			ata_link_for_each_dev(dev, link)
+				len = max(len, dev->cdb_len);
+		}
 
 		ap->scsi_host->max_cmd_len = len;
 	}
-- 
1.4.2.3


