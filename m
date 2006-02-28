From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/6] libata: seperate out ata_class_present()
Date: Wed, 1 Mar 2006 01:25:38 +0900
Message-ID: <11411439381562-git-send-email-htejun@gmail.com>
References: <11411439383398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.207]:59888 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751873AbWB1QZw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 11:25:52 -0500
Received: by wproxy.gmail.com with SMTP id i28so1131788wra
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 08:25:51 -0800 (PST)
In-Reply-To: <11411439383398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, jfs@keytradebank.com, 0602@eq.cz, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Seperate out ata_class_present() from ata_dev_present().  This is
useful because new reset mechanism deals with classes[] directly.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

d5044307293c38dd897722d170dcffecb069660f
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 66b6847..22e86cb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -645,10 +645,14 @@ static inline unsigned int ata_tag_valid
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
 }
 
+static inline unsigned int ata_class_present(unsigned int class)
+{
+	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI;
+}
+
 static inline unsigned int ata_dev_present(const struct ata_device *dev)
 {
-	return ((dev->class == ATA_DEV_ATA) ||
-		(dev->class == ATA_DEV_ATAPI));
+	return ata_class_present(dev->class);
 }
 
 static inline u8 ata_chk_status(struct ata_port *ap)
-- 
1.2.1


