From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 16/23] ata: sata_dwc_460ex: add __iomem to register base pointer
Date: Tue, 26 Apr 2016 12:03:17 +0300
Message-ID: <1461661404-1952-17-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>
List-Id: linux-ide@vger.kernel.org

From: Mans Rullgard <mans@mansr.com>

The pointer to the mmio register base is missing the __iomem
annotation.  Fix this.

Tested-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 90e3e14..25e00f2 100644
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
