From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/11] libata: separate out __ata_ehi_hotplugged()
Date: Mon, 3 Jul 2006 16:07:26 +0900
Message-ID: <11519104462280-git-send-email-htejun@gmail.com>
References: <11519104451998-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:59460 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750911AbWGCHGt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jul 2006 03:06:49 -0400
Received: by wx-out-0102.google.com with SMTP id t10so500111wxc
        for <linux-ide@vger.kernel.org>; Mon, 03 Jul 2006 00:06:49 -0700 (PDT)
In-Reply-To: <11519104451998-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out __ata_ehi_hotplugged() from ata_ehi_hotplugged().  The
underscored version doesn't set AC_ERR_ATA_BUS.  This will be used for
resume which is a hotplug event but not an ATA bus error.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

05c3b3361ede81cdf6e1331af21baa44f593be9b
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 36938ae..2aa1398 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -843,7 +843,7 @@ #define ata_ehi_clear_desc(ehi) do { \
 	(ehi)->desc_len = 0; \
 } while (0)
 
-static inline void ata_ehi_hotplugged(struct ata_eh_info *ehi)
+static inline void __ata_ehi_hotplugged(struct ata_eh_info *ehi)
 {
 	if (ehi->flags & ATA_EHI_HOTPLUGGED)
 		return;
@@ -851,11 +851,16 @@ static inline void ata_ehi_hotplugged(st
 	ehi->flags |= ATA_EHI_HOTPLUGGED | ATA_EHI_RESUME_LINK;
 	ehi->hotplug_timestamp = jiffies;
 
-	ehi->err_mask |= AC_ERR_ATA_BUS;
 	ehi->action |= ATA_EH_SOFTRESET;
 	ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
 }
 
+static inline void ata_ehi_hotplugged(struct ata_eh_info *ehi)
+{
+	__ata_ehi_hotplugged(ehi);
+	ehi->err_mask |= AC_ERR_ATA_BUS;
+}
+
 /*
  * qc helpers
  */
-- 
1.3.2


