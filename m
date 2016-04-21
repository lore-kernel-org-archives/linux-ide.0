From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 16/23] ata: sata_dwc_460ex: add __iomem to register base pointer
Date: Thu, 21 Apr 2016 21:15:37 +0300
Message-ID: <1461262544-115408-17-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30739 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbcDUSP4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Apr 2016 14:15:56 -0400
In-Reply-To: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>

From: Mans Rullgard <mans@mansr.com>

The pointer to the mmio register base is missing the __iomem
annotation.  Fix this.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 0eca56f2..42248b2 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -145,7 +145,7 @@ struct sata_dwc_device {
 	struct ata_probe_ent	*pe;		/* ptr to probe-ent */
 	struct ata_host		*host;
 	u8 __iomem		*reg_base;
-	struct sata_dwc_regs	*sata_dwc_regs;	/* DW Synopsys SATA specific */
+	struct sata_dwc_regs __iomem *sata_dwc_regs;	/* DW SATA specific */
 	u32			sactive_issued;
 	u32			sactive_queued;
 	struct phy		*phy;
-- 
2.8.0.rc3

