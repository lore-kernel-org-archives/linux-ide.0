From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH] ata: Fix build error in sata_highbank
Date: Fri, 28 Sep 2012 12:23:37 -0500
Message-ID: <1348853017-9205-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, Mark Langsdorf <mark.langsdorf@calxeda.com>
List-Id: linux-ide@vger.kernel.org

From: Mark Langsdorf <Mark Langsdorf>

Allow sata_highbank to build even if no other users of libahci.o are built.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
---
 drivers/ata/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 8b384f1..9329daf 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
 obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
-obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o
+obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
 
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
-- 
1.7.10.4
