From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/7] libata: implement ata_dev_absent()
Date: Sun, 2 Apr 2006 17:54:46 +0900
Message-ID: <11439680861163-git-send-email-htejun@gmail.com>
References: <11439680863256-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:9506 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932217AbWDBIyw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 04:54:52 -0400
Received: by zproxy.gmail.com with SMTP id o37so1438216nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 00:54:51 -0800 (PST)
In-Reply-To: <11439680863256-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

For the time being we cannot use ata_dev_present() as it was renamed
to ata_dev_enabled() but we still need presence test.  Implement
negation of the test.  Conveniently, the negated result is needed in
more places.  This is suggested by Jeff Garzik.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

21da2f0caf63d617a633a97635ab5d1ca5a407b1
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c6883ba..0f8e372 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -682,6 +682,11 @@ static inline unsigned int ata_class_dis
 	return class == ATA_DEV_ATA_UNSUP || class == ATA_DEV_ATAPI_UNSUP;
 }
 
+static inline unsigned int ata_class_absent(unsigned int class)
+{
+	return !ata_class_enabled(class) && !ata_class_disabled(class);
+}
+
 static inline unsigned int ata_dev_enabled(const struct ata_device *dev)
 {
 	return ata_class_enabled(dev->class);
@@ -692,6 +697,11 @@ static inline unsigned int ata_dev_disab
 	return ata_class_disabled(dev->class);
 }
 
+static inline unsigned int ata_dev_absent(const struct ata_device *dev)
+{
+	return ata_class_absent(dev->class);
+}
+
 static inline u8 ata_chk_status(struct ata_port *ap)
 {
 	return ap->ops->check_status(ap);
-- 
1.2.4


