From: Danesh Petigara <dpetigara@broadcom.com>
Subject: [PATCH v2] drivers: ata: wake port before DMA stop for ALPM
Date: Mon, 11 Jan 2016 13:22:26 -0800
Message-ID: <1452547346-31735-1-git-send-email-dpetigara@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:53127 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933005AbcAKVTn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jan 2016 16:19:43 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org
Cc: f.fainelli@gmail.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Danesh Petigara <dpetigara@broadcom.com>

The AHCI driver code stops and starts port DMA engines at will
without considering the power state of the particular port. The
AHCI specification isn't very clear on how to handle this scenario,
leaving implementation open to interpretation.

Broadcom's STB SATA host controller is unable to handle port DMA
controller restarts when the port in question is in low power mode.
When a port enters partial or slumber mode, its PHY is powered down.
When a controller restart is requested, the controller's internal
state machine expects the PHY to be brought back up by software which
never happens in this case, resulting in failures.

To avoid this situation, logic is added to manually wake up the port
just before its DMA engine is stopped, if the port happens to be in
a low power state. HBA initiated power management ensures that the port
eventually returns to its configured low power state, when the link is
idle (as per the conditions listed in the spec). A new host flag is also
added to ensure this logic is only exercised for hosts with the above
limitation.

Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
Reviewed-by: Markus Mayer <mmayer@broadcom.com>
---
This patch is against ata/for-next branch.

Changes since v1 (https://lkml.org/lkml/2016/1/7/778)
- Moved wakeup flag to AHCI_HFLAG_* space
- Called an updated ahci_set_lpm from ahci_stop_engine to wakeup link
- Made minor changes to commit message

 drivers/ata/ahci.h         |  1 +
 drivers/ata/ahci_brcmstb.c |  1 +
 drivers/ata/libahci.c      | 27 ++++++++++++++++++++++++++-
 include/linux/libata.h     |  1 +
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index a4faa43..a44c75d 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -250,6 +250,7 @@ enum {
 	AHCI_HFLAG_MULTI_MSI		= 0,
 	AHCI_HFLAG_MULTI_MSIX		= 0,
 #endif
+	AHCI_HFLAG_WAKE_BEFORE_STOP	= (1 << 22), /* wake before DMA stop */
 
 	/* ap->flags bits */
 
diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index b36cae2..e87bcec 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -317,6 +317,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 	hpriv->plat_data = priv;
+	hpriv->flags = AHCI_HFLAG_WAKE_BEFORE_STOP;
 
 	brcm_sata_alpm_init(hpriv);
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index eda3cf2..dee56d0 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -593,8 +593,26 @@ EXPORT_SYMBOL_GPL(ahci_start_engine);
 int ahci_stop_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	u32 tmp;
 
+	/*
+	 * On some controllers, stopping a port's DMA engine
+	 * while the port is in ALPM state (partial or slumber)
+	 * results in failures on subsequent DMA engine starts.
+	 * For those controllers, put the port back in active
+	 * state before stopping it's DMA engine.
+	 */
+	if ((hpriv->flags & AHCI_HFLAG_WAKE_BEFORE_STOP) &&
+	    (ap->link.lpm_policy > ATA_LPM_MAX_POWER)) {
+		if (ahci_set_lpm(&ap->link,
+			ATA_LPM_MAX_POWER, ATA_LPM_WAKE_ONLY)) {
+			dev_err(ap->host->dev,
+				"failed to wake up port\n");
+			return -EIO;
+		}
+	}
+
 	tmp = readl(port_mmio + PORT_CMD);
 
 	/* check if the HBA is idle */
@@ -689,6 +707,9 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	void __iomem *port_mmio = ahci_port_base(ap);
 
 	if (policy != ATA_LPM_MAX_POWER) {
+		/* Wakeup flag only applies to the max power policy */
+		hints &= ~ATA_LPM_WAKE_ONLY;
+
 		/*
 		 * Disable interrupts on Phy Ready. This keeps us from
 		 * getting woken up due to spurious phy ready
@@ -704,7 +725,8 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		u32 cmd = readl(port_mmio + PORT_CMD);
 
 		if (policy == ATA_LPM_MAX_POWER || !(hints & ATA_LPM_HIPM)) {
-			cmd &= ~(PORT_CMD_ASP | PORT_CMD_ALPE);
+			if (!(hints & ATA_LPM_WAKE_ONLY))
+				cmd &= ~(PORT_CMD_ASP | PORT_CMD_ALPE);
 			cmd |= PORT_CMD_ICC_ACTIVE;
 
 			writel(cmd, port_mmio + PORT_CMD);
@@ -712,6 +734,9 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 
 			/* wait 10ms to be sure we've come out of LPM state */
 			ata_msleep(ap, 10);
+
+			if (hints & ATA_LPM_WAKE_ONLY)
+				return 0;
 		} else {
 			cmd |= PORT_CMD_ALPE;
 			if (policy == ATA_LPM_MIN_POWER)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 088ed92..f33640e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -525,6 +525,7 @@ enum ata_lpm_policy {
 enum ata_lpm_hints {
 	ATA_LPM_EMPTY		= (1 << 0), /* port empty/probing */
 	ATA_LPM_HIPM		= (1 << 1), /* may use HIPM */
+	ATA_LPM_WAKE_ONLY	= (1 << 2), /* only wake up link */
 };
 
 /* forward declarations */
-- 
1.9.1

