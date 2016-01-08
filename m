From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/4] drivers: ata: wake port before DMA stop for ALPM
Date: Thu,  7 Jan 2016 16:03:32 -0800
Message-ID: <1452211413-1350-4-git-send-email-f.fainelli@gmail.com>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Danesh Petigara <dpetigara@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-ide@vger.kernel.org

From: Danesh Petigara <dpetigara@broadcom.com>

The AHCI driver code stops and starts port DMA engines at will
without considering the power state of the particular port. The
AHCI specification isn't very clear on how to handle this scenario,
leaving implementation open to interpretation.

Broadcom's STB SATA host controller is unable to handle port DMA
controller restarts when the port in question is in low power mode.
When a port enters partial or slumber mode, it's PHY is powered down.
When a controller restart is requested, the controller's internal
state machine expects the PHY to be brought back up by software which
never happens in this case, resulting in failures.

To avoid this situation, logic is added to manually wake up the port
just before it's DMA engine is stopped, if the port happens to be in
a low power state. HBA initiated power management ensures that the port
eventually returns to it's configured low power state, when the link is
idle (as per the conditions listed in the spec). A new host flag is also
added to ensure this logic is only exercised for hosts with the above
limitation.

Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci.h         |  6 ++++++
 drivers/ata/ahci_brcmstb.c |  1 +
 drivers/ata/libahci.c      | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c  |  1 +
 include/linux/libata.h     |  4 ++++
 5 files changed, 64 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index a4faa438889c..03453e6b7d9d 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -198,6 +198,12 @@ enum {
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 
+	/* PORT SCR STAT bits */
+	PORT_SCR_STAT_IPM_MASK	  = (0xf << 8), /* i/f IPM state mask */
+	PORT_SCR_STAT_IPM_ACTIVE  = (0x1 << 8), /* i/f in active state */
+	PORT_SCR_STAT_IPM_PARTIAL = (0x2 << 8), /* i/f in partial state */
+	PORT_SCR_STAT_IPM_SLUMBER = (0x6 << 8), /* i/f in slumber state */
+
 	/* PORT_FBS bits */
 	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
 	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index f51e3d9ba86e..e518a992e774 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -85,6 +85,7 @@ struct brcm_ahci_priv {
 
 static const struct ata_port_info ahci_brcm_port_info = {
 	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
+	.flags2		= ATA_FLAG2_WAKE_BEFORE_STOP,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &ahci_platform_ops,
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index d61740e78d6d..b6664c579f9a 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -595,6 +595,58 @@ int ahci_stop_engine(struct ata_port *ap)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
 
+	/*
+	 * On some controllers, stopping a port's DMA engine
+	 * while the port is in ALPM state (partial or slumber)
+	 * results in failures on subsequent DMA engine starts.
+	 * For those controllers, put the port back in active
+	 * state before stopping it's DMA engine.
+	 */
+	if (ap->flags2 & ATA_FLAG2_WAKE_BEFORE_STOP) {
+		u32 sts, retries = 10;
+		struct ahci_host_priv *hpriv = ap->host->private_data;
+
+		if (!(hpriv->cap & HOST_CAP_ALPM))
+			goto skip_wake_up;
+
+		tmp = readl(port_mmio + PORT_CMD);
+		if (!(tmp & PORT_CMD_ALPE))
+			goto skip_wake_up;
+
+		sts = readl(port_mmio + PORT_SCR_STAT) &
+			PORT_SCR_STAT_IPM_MASK;
+		if ((sts != PORT_SCR_STAT_IPM_PARTIAL) &&
+		    (sts != PORT_SCR_STAT_IPM_SLUMBER))
+			goto skip_wake_up;
+
+		tmp |= PORT_CMD_ICC_ACTIVE;
+		writel(tmp, port_mmio + PORT_CMD);
+
+		do {
+			/*
+			 * The exit latency for partial state is upto 10usec
+			 * whereas it is upto 10msec for slumber state. Use
+			 * this information to choose appropriate waiting
+			 * calls so the time spent in the loop is minimized.
+			 */
+			if (sts == PORT_SCR_STAT_IPM_PARTIAL)
+				udelay(1);
+			else
+				ata_msleep(ap, 1);
+			sts = readl(port_mmio + PORT_SCR_STAT) &
+				PORT_SCR_STAT_IPM_MASK;
+			if (sts == PORT_SCR_STAT_IPM_ACTIVE)
+				break;
+		} while (--retries);
+
+		if (!retries) {
+			dev_err(ap->host->dev,
+				"failed to wake up port\n");
+			return -EIO;
+		}
+	}
+
+skip_wake_up:
 	tmp = readl(port_mmio + PORT_CMD);
 
 	/* check if the HBA is idle */
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 60e368610c74..c6117e1ad373 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5803,6 +5803,7 @@ struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 		ap->mwdma_mask = pi->mwdma_mask;
 		ap->udma_mask = pi->udma_mask;
 		ap->flags |= pi->flags;
+		ap->flags2 |= pi->flags2;
 		ap->link.flags |= pi->link_flags;
 		ap->ops = pi->port_ops;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 600c1e0626a5..f278ca897274 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -236,6 +236,8 @@ enum {
 
 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
+	/* struct ata_port flags2 */
+	ATA_FLAG2_WAKE_BEFORE_STOP = (1 << 0), /* wake link before DMA stop */
 
 	/* struct ata_port pflags */
 	ATA_PFLAG_EH_PENDING	= (1 << 0), /* EH pending */
@@ -812,6 +814,7 @@ struct ata_port {
 	/* Flags owned by the EH context. Only EH should touch these once the
 	   port is active */
 	unsigned long		flags;	/* ATA_FLAG_xxx */
+	unsigned long		flags2; /* ATA_FLAG2_xxx */
 	/* Flags that change dynamically, protected by ap->lock */
 	unsigned int		pflags; /* ATA_PFLAG_xxx */
 	unsigned int		print_id; /* user visible unique port ID */
@@ -996,6 +999,7 @@ struct ata_port_operations {
 
 struct ata_port_info {
 	unsigned long		flags;
+	unsigned long		flags2;
 	unsigned long		link_flags;
 	unsigned long		pio_mask;
 	unsigned long		mwdma_mask;
-- 
2.1.0
