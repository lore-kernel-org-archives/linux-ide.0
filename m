From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 18/21] libata: reorganize ata_ehi_hotplugged()
Date: Mon, 16 Jul 2007 14:29:40 +0900
Message-ID: <11845637801387-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:11852 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760968AbXGPF3x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:53 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736626nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:53 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

__ata_ehi_hotplugged() now has no users.  Regorganize
ata_ehi_hotplugged() such that a new function ata_ehi_schedule_probe()
deals with scheduling probing.  ata_ehi_hotplugged() calls it and
additionally marks hotplug specific flags.  ata_ehi_schedule_probe()
will be used laster.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/libata.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 16ebdf1..74800ad 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -915,16 +915,17 @@ extern void __ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...);
 extern void ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...);
 extern void ata_ehi_clear_desc(struct ata_eh_info *ehi);
 
-static inline void __ata_ehi_hotplugged(struct ata_eh_info *ehi)
+static inline void ata_ehi_schedule_probe(struct ata_eh_info *ehi)
 {
-	ehi->flags |= ATA_EHI_HOTPLUGGED | ATA_EHI_RESUME_LINK;
+	ehi->flags |= ATA_EHI_RESUME_LINK;
 	ehi->action |= ATA_EH_SOFTRESET;
 	ehi->probe_mask |= (1 << ATA_MAX_DEVICES) - 1;
 }
 
 static inline void ata_ehi_hotplugged(struct ata_eh_info *ehi)
 {
-	__ata_ehi_hotplugged(ehi);
+	ata_ehi_schedule_probe(ehi);
+	ehi->flags |= ATA_EHI_HOTPLUGGED;
 	ehi->err_mask |= AC_ERR_ATA_BUS;
 }
 
-- 
1.5.0.3


