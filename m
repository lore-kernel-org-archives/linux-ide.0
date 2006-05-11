From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 18/22] libata: kill old SCR functions and sata_dev_present()
Date: Thu, 11 May 2006 20:59:51 +0900
Message-ID: <11473487913179-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:42942 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751615AbWEKMAG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:06 -0400
Received: by wr-out-0506.google.com with SMTP id i28so112006wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:05 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill now unused scr_{read|write|write_flush}() and sata_dev_present().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

d37cd2268afa9ac9fc3ef918c944646059cf9455
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7b3beea..b719b16 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -939,28 +939,6 @@ static inline u8 ata_irq_ack(struct ata_
 	return status;
 }
 
-static inline u32 scr_read(struct ata_port *ap, unsigned int reg)
-{
-	return ap->ops->scr_read(ap, reg);
-}
-
-static inline void scr_write(struct ata_port *ap, unsigned int reg, u32 val)
-{
-	ap->ops->scr_write(ap, reg, val);
-}
-
-static inline void scr_write_flush(struct ata_port *ap, unsigned int reg,
-				   u32 val)
-{
-	ap->ops->scr_write(ap, reg, val);
-	(void) ap->ops->scr_read(ap, reg);
-}
-
-static inline unsigned int sata_dev_present(struct ata_port *ap)
-{
-	return ((scr_read(ap, SCR_STATUS) & 0xf) == 0x3) ? 1 : 0;
-}
-
 static inline int ata_try_flush_cache(const struct ata_device *dev)
 {
 	return ata_id_wcache_enabled(dev->id) ||
-- 
1.2.4


