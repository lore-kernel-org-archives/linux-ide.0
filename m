From: Huacai Chen <chenhuacai@gmail.com>
Subject: [PATCH V2 11/16] ata: Use 32-bit DMA in AHCI for Loongson-3.
Date: Tue, 19 Jun 2012 14:50:19 +0800
Message-ID: <1340088624-25550-12-git-send-email-chenhc@lemote.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54770 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094Ab2FSG5L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jun 2012 02:57:11 -0400
Received: by pbbrp8 with SMTP id rp8so9254403pbb.19
        for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2012 23:57:11 -0700 (PDT)
In-Reply-To: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>, Zhangjin Wu <wuzhangjin@gmail.com>, Huacai Chen <chenhc@lemote.com>, Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>, linux-ide@vger.kernel.org

This is a workaround because Loongson-3 has a hardware bug that it
doesn't support DMA address above 4GB.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/ahci.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ebaf67e..3e3cfd8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -183,7 +183,12 @@ static const struct ata_port_info ahci_port_info[] = {
 	},
 	[board_ahci_sb700] =	/* for SB700 and SB800 */
 	{
+#ifndef CONFIG_CPU_LOONGSON3
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
+#else
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
+						AHCI_HFLAG_32BIT_ONLY),
+#endif
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
-- 
1.7.7.3

