From: Shane Huang <shane.huang@amd.com>
Subject: [PATCH v2] ahci: implement aggressive SATA device sleep support
Date: Fri, 24 Aug 2012 06:31:11 +0800
Message-ID: <1345761072-2123-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:16749
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754206Ab2HWOcN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Aug 2012 10:32:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Shane Huang <shane.huang@amd.com>

Device Sleep is a feature as described in AHCI 1.3.1 Technical Proposal.
This feature enables an HBA and SATA storage device to enter the DevSleep
interface state, enabling lower power SATA-based systems.

Aggressive Device Sleep enables the HBA to assert the DEVSLP signal as
soon as there are no commands outstanding to the device and the port
specific Device Sleep idle timer has expired. This enables autonomous
entry into the DevSleep interface state without waiting for software
in power sensitive systems.

This patch enables Aggressive Device Sleep only if both host controller
and device support it.

Tested on AMD reference board together with Device Sleep supported device
sample.

Signed-off-by: Shane Huang <shane.huang@amd.com>
Reviewed-by: Aaron Lu <aaron.lwe@gmail.com>
---
Changes from the last version(v1):
* Refine the description and add test information.
* No need to disable DevSlp again if it was already disabled.
* No need to call ata_dev_set_feature() in each DevSlp enablement,
  move it to ata_dev_configure().
* Get MDAT from Identify Device Data Log of the device, if the value
  is zero, then use the nominal value 10ms.
* Get DETO from Identify Device Data Log of the device, if the value
  is zero, then use the nominal value 20ms.

 drivers/ata/ahci.h        |   14 +++++++++
 drivers/ata/libahci.c     |   74 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata-core.c |   29 +++++++++++++++---
 drivers/ata/libata-eh.c   |    4 +--
 drivers/ata/libata.h      |    2 ++
 include/linux/ata.h       |    3 ++
 include/linux/libata.h    |    4 +++
 7 files changed, 122 insertions(+), 8 deletions(-)

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
index f9eaa82..eddc789 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -76,6 +76,7 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static int ahci_pmp_qc_defer(struct ata_queued_cmd *qc);
 static void ahci_freeze(struct ata_port *ap);
 static void ahci_thaw(struct ata_port *ap);
+static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep);
 static void ahci_enable_fbs(struct ata_port *ap);
 static void ahci_disable_fbs(struct ata_port *ap);
 static void ahci_pmp_attach(struct ata_port *ap);
@@ -193,6 +194,10 @@ module_param(ahci_em_messages, int, 0444);
 MODULE_PARM_DESC(ahci_em_messages,
 	"AHCI Enclosure Management Message control (0 = off, 1 = on)");
 
+int devslp_idle_timeout = 1000;	/* device sleep idle timeout in ms */
+module_param(devslp_idle_timeout, int, 0644);
+MODULE_PARM_DESC(devslp_idle_timeout, "device sleep idle timeout");
+
 static void ahci_enable_ahci(void __iomem *mmio)
 {
 	int i;
@@ -702,6 +707,16 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
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
 
@@ -1889,6 +1904,59 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 		ahci_kick_engine(ap);
 }
 
+static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
+{
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 devslp, dm, dito, mdat, deto;
+	int rc;
+
+	devslp = readl(port_mmio + PORT_DEVSLP);
+	if (!(devslp & PORT_DEVSLP_DSP)) {
+		dev_err(ap->host->dev, "port does not support device sleep\n");
+		return;
+	}
+
+	/* disable device sleep */
+	if (!sleep) {
+		if (devslp & PORT_DEVSLP_ADSE)
+			writel(devslp & ~PORT_DEVSLP_ADSE,
+			       port_mmio + PORT_DEVSLP);
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
+
+	/* If the value in MDAT is zero, then use 10 ms as the value of MDAT */
+	mdat = (ap->link.device->sata_settings[0x30]) & 0x1f;
+	if (!mdat)
+		mdat = 10;
+
+	/* If the value in DETO is zero, then use 20 ms as the value of DETO */
+	deto = ap->link.device->sata_settings[0x31];
+	if (!deto)
+		deto = 20;
+
+	devslp |= ((dito << PORT_DEVSLP_DITO_OFFSET) |
+		   (mdat << PORT_DEVSLP_MDAT_OFFSET) |
+		   (deto << PORT_DEVSLP_DETO_OFFSET) |
+		   PORT_DEVSLP_ADSE);
+	writel(devslp, port_mmio + PORT_DEVSLP);
+
+	ahci_start_engine(ap);
+}
+
 static void ahci_enable_fbs(struct ata_port *ap)
 {
 	struct ahci_port_priv *pp = ap->private_data;
@@ -2163,7 +2231,8 @@ void ahci_print_info(struct ata_host *host, const char *scc_s)
 		"flags: "
 		"%s%s%s%s%s%s%s"
 		"%s%s%s%s%s%s%s"
-		"%s%s%s%s%s%s\n"
+		"%s%s%s%s%s%s%s"
+		"%s%s\n"
 		,
 
 		cap & HOST_CAP_64 ? "64bit " : "",
@@ -2183,6 +2252,9 @@ void ahci_print_info(struct ata_host *host, const char *scc_s)
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
index fadd586..9754b53 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2155,6 +2155,7 @@ int ata_dev_configure(struct ata_device *dev)
 	int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
 	const u16 *id = dev->id;
 	unsigned long xfer_mask;
+	unsigned int err_mask;
 	char revbuf[7];		/* XYZ-99\0 */
 	char fwrevbuf[ATA_ID_FW_REV_LEN+1];
 	char modelbuf[ATA_ID_PROD_LEN+1];
@@ -2323,6 +2324,26 @@ int ata_dev_configure(struct ata_device *dev)
 			}
 		}
 
+		if (ata_id_has_devslp(dev->id)) {
+			err_mask = ata_dev_set_feature(dev,
+						       SETFEATURES_SATA_ENABLE,
+						       SATA_DEVSLP);
+			if (err_mask)
+				ata_dev_err(dev,
+					    "failed to enable DEVSLP (err_mask=0x%x)\n",
+					    err_mask);
+			else {
+				dev->flags |= ATA_DFLAG_DEVSLP;
+				err_mask = ata_read_log_page(dev,
+						ATA_LOG_SATA_SETTINGS,
+						dev->sata_settings,
+						1);
+				if (err_mask)
+					ata_dev_warn(dev,
+						     "failed to get Identify Device Data\n");
+			}
+		}
+
 		dev->cdb_len = 16;
 	}
 
@@ -2351,8 +2372,6 @@ int ata_dev_configure(struct ata_device *dev)
 		    (ap->flags & ATA_FLAG_AN) && ata_id_has_atapi_AN(id) &&
 		    (!sata_pmp_attached(ap) ||
 		     sata_scr_read(&ap->link, SCR_NOTIFICATION, &sntf) == 0)) {
-			unsigned int err_mask;
-
 			/* issue SET feature command to turn this on */
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_ENABLE, SATA_AN);
@@ -3598,7 +3617,7 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	switch (policy) {
 	case ATA_LPM_MAX_POWER:
 		/* disable all LPM transitions */
-		scontrol |= (0x3 << 8);
+		scontrol |= (0x7 << 8);
 		/* initiate transition to active state */
 		if (spm_wakeup) {
 			scontrol |= (0x4 << 12);
@@ -3608,12 +3627,12 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
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
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7d4535e..ed0a120 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1499,8 +1499,8 @@ static const char *ata_err_string(unsigned int err_mask)
  *	RETURNS:
  *	0 on success, AC_ERR_* mask otherwise.
  */
-static unsigned int ata_read_log_page(struct ata_device *dev,
-				      u8 page, void *buf, unsigned int sectors)
+unsigned int ata_read_log_page(struct ata_device *dev,
+			       u8 page, void *buf, unsigned int sectors)
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 50e4dff..be14f1e 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -165,6 +165,8 @@ extern void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 			       unsigned int action);
 extern void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 			unsigned int action);
+extern unsigned int ata_read_log_page(struct ata_device *dev,
+				      u8 page, void *buf, unsigned int sectors);
 extern void ata_eh_autopsy(struct ata_port *ap);
 const char *ata_get_cmd_descript(u8 command);
 extern void ata_eh_report(struct ata_port *ap);
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 5713d3a..931bf08 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -292,6 +292,7 @@ enum {
 
 	/* READ_LOG_EXT pages */
 	ATA_LOG_SATA_NCQ	= 0x10,
+	ATA_LOG_SATA_SETTINGS	= 0x38,
 
 	/* READ/WRITE LONG (obsolete) */
 	ATA_CMD_READ_LONG	= 0x22,
@@ -345,6 +346,7 @@ enum {
 	SATA_FPDMA_IN_ORDER	= 0x04,	/* FPDMA in-order data delivery */
 	SATA_AN			= 0x05,	/* Asynchronous Notification */
 	SATA_SSP		= 0x06,	/* Software Settings Preservation */
+	SATA_DEVSLP		= 0x09,	/* Device Sleep */
 
 	/* feature values for SET_MAX */
 	ATA_SET_MAX_ADDR	= 0x00,
@@ -579,6 +581,7 @@ static inline int ata_is_data(u8 prot)
 
 #define ata_id_cdb_intr(id)	(((id)[ATA_ID_CONFIG] & 0x60) == 0x20)
 #define ata_id_has_da(id)	((id)[77] & (1 << 4))
+#define ata_id_has_devslp(id)	((id)[78] & (1 << 8))
 
 static inline bool ata_id_has_hipm(const u16 *id)
 {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 64f90e1..464e67c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -162,6 +162,7 @@ enum {
 	ATA_DFLAG_DETACHED	= (1 << 25),
 
 	ATA_DFLAG_DA		= (1 << 26), /* device supports Device Attention */
+	ATA_DFLAG_DEVSLP	= (1 << 27), /* device supports Device Sleep */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -649,6 +650,9 @@ struct ata_device {
 		u32		gscr[SATA_PMP_GSCR_DWORDS]; /* PMP GSCR block */
 	};
 
+	/* Identify Device Data Log (30h), SATA Settings (page 08h) */
+	u8			sata_settings[ATA_SECT_SIZE];
+
 	/* error history */
 	int			spdn_cnt;
 	/* ering is CLEAR_END, read comment above CLEAR_END */
-- 
1.7.9.5


