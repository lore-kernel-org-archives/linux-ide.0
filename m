From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] ata: ahci_brcm: Avoid clobbering SATA_TOP_CTRL_BUS_CTRL
Date: Fri, 22 Dec 2017 11:43:08 -0800
Message-ID: <20171222194331.6330-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

We are doing a blind write to SATA_TOP_CTRL_BUS_CTRL to set the system
endian, but in doing so, we are also overwriting other bits, such as the
SATA_SCB_BURST_SIZE and SATA_FIFO_SIZE bits, which impact performance.
Do a read/modify/write so we keep the default values.

While we are at it, we also greatly simplify the logic and just leave
the NSP specific bit settings, instead of having a completely different
sequence.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Tejun, this is against your "for-next" branch, thank you!


 drivers/ata/ahci_brcm.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 5936d1679bf3..ad3b8826ec79 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -70,6 +70,13 @@
 	(DATA_ENDIAN << DMADESC_ENDIAN_SHIFT) |		\
 	(MMIO_ENDIAN << MMIO_ENDIAN_SHIFT))
 
+#define BUS_CTRL_ENDIAN_NSP_CONF			\
+	(0x02 << DMADATA_ENDIAN_SHIFT | 0x02 << DMADESC_ENDIAN_SHIFT)
+
+#define BUS_CTRL_ENDIAN_CONF_MASK			\
+	(0x3 << MMIO_ENDIAN_SHIFT | 0x3 << DMADESC_ENDIAN_SHIFT |	\
+	 0x3 << DMADATA_ENDIAN_SHIFT | 0x3 << PIODATA_ENDIAN_SHIFT)
+
 enum brcm_ahci_version {
 	BRCM_SATA_BCM7425 = 1,
 	BRCM_SATA_BCM7445,
@@ -250,18 +257,16 @@ static u32 brcm_ahci_get_portmask(struct platform_device *pdev,
 static void brcm_sata_init(struct brcm_ahci_priv *priv)
 {
 	void __iomem *ctrl = priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL;
+	u32 data;
 
 	/* Configure endianness */
-	if (priv->version ==  BRCM_SATA_NSP) {
-		u32 data = brcm_sata_readreg(ctrl);
-
-		data &= ~((0x03 << DMADATA_ENDIAN_SHIFT) |
-			(0x03 << DMADESC_ENDIAN_SHIFT));
-		data |= (0x02 << DMADATA_ENDIAN_SHIFT) |
-			(0x02 << DMADESC_ENDIAN_SHIFT);
-		brcm_sata_writereg(data, ctrl);
-	} else
-		brcm_sata_writereg(BUS_CTRL_ENDIAN_CONF, ctrl);
+	data = brcm_sata_readreg(ctrl);
+	data &= ~BUS_CTRL_ENDIAN_CONF_MASK;
+	if (priv->version == BRCM_SATA_NSP)
+		data |= BUS_CTRL_ENDIAN_NSP_CONF;
+	else
+		data |= BUS_CTRL_ENDIAN_CONF;
+	brcm_sata_writereg(data, ctrl);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.15.0
