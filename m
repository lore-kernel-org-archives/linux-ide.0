From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH RESEND] ahci: implement aggressive SATA device sleep support
Date: Wed, 8 Aug 2012 01:44:36 +0800
Message-ID: <1344361476-2154-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:51243
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751170Ab2HGJpU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2012 05:45:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Shane Huang <shane.huang@amd.com>

Device Sleep is a feature as described in AHCI 1.3.1 Technical Proposal.
This feature enables an HBA and SATA storage device to enter the DevSleep
interface state, enabling lower power SATA-based systems.

Signed-off-by: Shane Huang <shane.huang@amd.com>
---
 drivers/ata/ahci.h        |   14 +++++++++
 drivers/ata/libahci.c     |   71 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata-core.c |    9 ++++--
 include/linux/ata.h       |    2 ++
 include/linux/libata.h    |    1 +
 5 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index c2594dd..7b6fcf7 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -115,6 +115,9 @@ enum {
 	HOST_CAP2_BOH		= (1 << 0),  /* BIOS/OS handoff supported */
 	HOST_CAP2_NVMHCI	= (1 << 1),  /* NVMHCI supported */
 	HOST_CAP2_APST		= (1 << 2),  /* Automatic partial to slumber */
+	HOST_CAP2_SDS		= (1 << 3),  /* Support device sleep */
+	HOST_CAP2_SADM		= (1 << 4),  /* Support aggressive DevSlp */
+	HOST_CAP2_DESO		= (1 << 5),  /* DevSlp from slumber only */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -133,6 +136,7 @@ enum {
 	PORT_SCR_ACT		= 0x34, /* SATA phy register: SActive */
 	PORT_SCR_NTF		= 0x3c, /* SATA phy register: SNotification */
 	PORT_FBS		= 0x40, /* FIS-based Switching */
+	PORT_DEVSLP		= 0x44, /* device sleep */
 
 	/* PORT_IRQ_{STAT,MASK} bits */
 	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
@@ -186,6 +190,7 @@ enum {
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 
+	/* PORT_FBS bits */
 	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
 	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
 	PORT_FBS_DEV_OFFSET	= 8,  /* FBS device to issue offset */
@@ -194,6 +199,15 @@ enum {
 	PORT_FBS_DEC		= (1 << 1), /* FBS device error clear */
 	PORT_FBS_EN		= (1 << 0), /* Enable FBS */
 
+	/* PORT_DEVSLP bits */
+	PORT_DEVSLP_DM_OFFSET	= 25,             /* DITO multiplier offset */
+	PORT_DEVSLP_DM_MASK	= (0xf << 25),    /* DITO multiplier mask */
+	PORT_DEVSLP_DITO_OFFSET	= 15,             /* DITO offset */
+	PORT_DEVSLP_MDAT_OFFSET	= 10,             /* Minimum assertion time */
+	PORT_DEVSLP_DETO_OFFSET	= 2,              /* DevSlp exit timeout */
+	PORT_DEVSLP_DSP		= (1 << 1),       /* DevSlp present */
+	PORT_DEVSLP_ADSE	= (1 << 0),       /* Aggressive DevSlp enable */
+
 	/* hpriv->flags bits */
 
 #define AHCI_HFLAGS(flags)		.private_data	= (void *)(flags)
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index f9eaa82..69b6617 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -45,6 +45,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 #include "ahci.h"
+#include "libata.h"
 
 static int ahci_skip_host_reset;
 int ahci_ignore_sss;
@@ -76,6 +77,7 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static int ahci_pmp_qc_defer(struct ata_queued_cmd *qc);
 static void ahci_freeze(struct ata_port *ap);
 static void ahci_thaw(struct ata_port *ap);
+static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep);
 static void ahci_enable_fbs(struct ata_port *ap);
 static void ahci_disable_fbs(struct ata_port *ap);
 static void ahci_pmp_attach(struct ata_port *ap);
@@ -193,6 +195,10 @@ module_param(ahci_em_messages, int, 0444);
 MODULE_PARM_DESC(ahci_em_messages,
 	"AHCI Enclosure Management Message control (0 = off, 1 = on)");
 
+int devslp_idle_timeout = 1000;	/* device sleep idle timeout in ms */
+module_param(devslp_idle_timeout, int, 0644);
+MODULE_PARM_DESC(devslp_idle_timeout, "device sleep idle timeout");
+
 static void ahci_enable_ahci(void __iomem *mmio)
 {
 	int i;
@@ -702,6 +708,16 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		}
 	}
 
+	/* set aggressive device sleep */
+	if ((hpriv->cap2 & HOST_CAP2_SDS) &&
+	    (hpriv->cap2 & HOST_CAP2_SADM) &&
+	    (link->device->flags & ATA_DFLAG_DEVSLP)) {
+		if (policy == ATA_LPM_MIN_POWER)
+			ahci_set_aggressive_devslp(ap, true);
+		else
+			ahci_set_aggressive_devslp(ap, false);
+	}
+
 	if (policy == ATA_LPM_MAX_POWER) {
 		sata_link_scr_lpm(link, policy, false);
 
@@ -1889,6 +1905,55 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 		ahci_kick_engine(ap);
 }
 
+static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
+{
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 devslp, dm, dito;
+	int rc;
+	unsigned int err_mask;
+
+	devslp = readl(port_mmio + PORT_DEVSLP);
+	if (!(devslp & PORT_DEVSLP_DSP)) {
+		dev_err(ap->host->dev, "port does not support device sleep\n");
+		return;
+	}
+
+	/* disable device sleep */
+	if (!sleep) {
+		writel(devslp & ~PORT_DEVSLP_ADSE, port_mmio + PORT_DEVSLP);
+		return;
+	}
+
+	/* device sleep was already enabled */
+	if (devslp & PORT_DEVSLP_ADSE)
+		return;
+
+	/* set DITO, MDAT, DETO and enable DevSlp, need to stop engine first */
+	rc = ahci_stop_engine(ap);
+	if (rc)
+		return;
+
+	dm = (devslp & PORT_DEVSLP_DM_MASK) >> PORT_DEVSLP_DM_OFFSET;
+	dito = devslp_idle_timeout / (dm + 1);
+	if (dito > 0x3ff)
+		dito = 0x3ff;
+	devslp |= ((dito << PORT_DEVSLP_DITO_OFFSET) |
+		   (10 << PORT_DEVSLP_MDAT_OFFSET) |
+		   (20 << PORT_DEVSLP_DETO_OFFSET) |
+		   PORT_DEVSLP_ADSE);
+	writel(devslp, port_mmio + PORT_DEVSLP);
+
+	ahci_start_engine(ap);
+
+	/* enable device sleep feature for the drive */
+	err_mask = ata_dev_set_feature(ap->link.device,
+				       SETFEATURES_SATA_ENABLE,
+				       SATA_DEVSLP);
+	if (err_mask && err_mask != AC_ERR_DEV)
+		ata_dev_warn(ap->link.device,
+			     "failed to enable DEVSLP, Emask 0x%x\n", err_mask);
+}
+
 static void ahci_enable_fbs(struct ata_port *ap)
 {
 	struct ahci_port_priv *pp = ap->private_data;
@@ -2163,7 +2228,8 @@ void ahci_print_info(struct ata_host *host, const char *scc_s)
 		"flags: "
 		"%s%s%s%s%s%s%s"
 		"%s%s%s%s%s%s%s"
-		"%s%s%s%s%s%s\n"
+		"%s%s%s%s%s%s%s"
+		"%s%s\n"
 		,
 
 		cap & HOST_CAP_64 ? "64bit " : "",
@@ -2183,6 +2249,9 @@ void ahci_print_info(struct ata_host *host, const char *scc_s)
 		cap & HOST_CAP_CCC ? "ccc " : "",
 		cap & HOST_CAP_EMS ? "ems " : "",
 		cap & HOST_CAP_SXS ? "sxs " : "",
+		cap2 & HOST_CAP2_DESO ? "deso " : "",
+		cap2 & HOST_CAP2_SADM ? "sadm " : "",
+		cap2 & HOST_CAP2_SDS ? "sds " : "",
 		cap2 & HOST_CAP2_APST ? "apst " : "",
 		cap2 & HOST_CAP2_NVMHCI ? "nvmp " : "",
 		cap2 & HOST_CAP2_BOH ? "boh " : ""
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fadd586..9d5de59 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2323,6 +2323,9 @@ int ata_dev_configure(struct ata_device *dev)
 			}
 		}
 
+		if (ata_id_has_devslp(dev->id))
+			dev->flags |= ATA_DFLAG_DEVSLP;
+
 		dev->cdb_len = 16;
 	}
 
@@ -3598,7 +3601,7 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	switch (policy) {
 	case ATA_LPM_MAX_POWER:
 		/* disable all LPM transitions */
-		scontrol |= (0x3 << 8);
+		scontrol |= (0x7 << 8);
 		/* initiate transition to active state */
 		if (spm_wakeup) {
 			scontrol |= (0x4 << 12);
@@ -3608,12 +3611,12 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	case ATA_LPM_MED_POWER:
 		/* allow LPM to PARTIAL */
 		scontrol &= ~(0x1 << 8);
-		scontrol |= (0x2 << 8);
+		scontrol |= (0x6 << 8);
 		break;
 	case ATA_LPM_MIN_POWER:
 		if (ata_link_nr_enabled(link) > 0)
 			/* no restrictions on LPM transitions */
-			scontrol &= ~(0x3 << 8);
+			scontrol &= ~(0x7 << 8);
 		else {
 			/* empty port, power off */
 			scontrol &= ~0xf;
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 5713d3a..68e8c95 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -345,6 +345,7 @@ enum {
 	SATA_FPDMA_IN_ORDER	= 0x04,	/* FPDMA in-order data delivery */
 	SATA_AN			= 0x05,	/* Asynchronous Notification */
 	SATA_SSP		= 0x06,	/* Software Settings Preservation */
+	SATA_DEVSLP		= 0x09,	/* Device Sleep */
 
 	/* feature values for SET_MAX */
 	ATA_SET_MAX_ADDR	= 0x00,
@@ -579,6 +580,7 @@ static inline int ata_is_data(u8 prot)
 
 #define ata_id_cdb_intr(id)	(((id)[ATA_ID_CONFIG] & 0x60) == 0x20)
 #define ata_id_has_da(id)	((id)[77] & (1 << 4))
+#define ata_id_has_devslp(id)	((id)[78] & (1 << 8))
 
 static inline bool ata_id_has_hipm(const u16 *id)
 {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 64f90e1..174c3ea 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -162,6 +162,7 @@ enum {
 	ATA_DFLAG_DETACHED	= (1 << 25),
 
 	ATA_DFLAG_DA		= (1 << 26), /* device supports Device Attention */
+	ATA_DFLAG_DEVSLP	= (1 << 27), /* device supports Device Sleep */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
-- 
1.7.9.5


