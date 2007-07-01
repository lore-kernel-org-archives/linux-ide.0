From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/12] libata: reorganize ata_ehi_hotplugged()
Date: Sun, 1 Jul 2007 18:53:38 +0900
Message-ID: <11832836181048-git-send-email-htejun@gmail.com>
References: <118328361627-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:29288 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513AbXGAJxq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 05:53:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1876601wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 02:53:46 -0700 (PDT)
In-Reply-To: <118328361627-git-send-email-htejun@gmail.com>
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
index 05670b5..09af7a4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -921,16 +921,17 @@ extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 	(ehi)->desc_len = 0; \
 } while (0)
 
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


