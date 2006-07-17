From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/12] ahci: implement link powersave
Date: Mon, 17 Jul 2006 15:52:32 +0900
Message-ID: <11531191523232-git-send-email-htejun@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:20072 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932337AbWGQGvy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:54 -0400
Received: by py-out-1112.google.com with SMTP id x31so3883137pye
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:20 -0700 (PDT)
In-Reply-To: <11531191512028-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement link powersave.  AHCI can initiate transition to powersave
mode but doesn't use standard SControl SPM field.  It uses ICC field
in PORT_CMD register.  As PHY RDY changed interrupt can trigger during
dynamic link powersave, it needs to be turned off while dynamic
powersave is active.  All other can be taken care of by standard
helpers.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

14143d016b88395ffcec7be07ffa99d652a3353d
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 77e7202..b5fe19a 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -92,6 +92,8 @@ enum {
 	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */
 
 	/* HOST_CAP bits */
+	HOST_CAP_PARTIAL	= (1 << 13), /* Partial state support */
+	HOST_CAP_SLUMBER	= (1 << 14), /* Slumber state support */
 	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
 	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
 	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
@@ -158,6 +160,7 @@ enum {
 	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
+	PORT_CMD_ICC_MASK	= (0xf << 28),
 
 	/* hpriv->flags bits */
 	AHCI_FLAG_MSI		= (1 << 0),
@@ -212,6 +215,7 @@ static void ahci_freeze(struct ata_port 
 static void ahci_thaw(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
+static void ahci_set_powersave(struct ata_port *ap, int ps_state);
 static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
@@ -257,6 +261,8 @@ static const struct ata_port_operations 
 	.error_handler		= ahci_error_handler,
 	.post_internal_cmd	= ahci_post_internal_cmd,
 
+	.set_powersave		= ahci_set_powersave,
+
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
 };
@@ -913,6 +919,9 @@ static void ahci_host_intr(struct ata_po
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
+	if (ata_ps_dynamic(ap->ps_state))
+		status &= ~PORT_IRQ_PHYRDY;
+
 	if (unlikely(status & PORT_IRQ_ERROR)) {
 		ahci_error_intr(ap, status);
 		return;
@@ -1077,6 +1086,60 @@ static void ahci_post_internal_cmd(struc
 	}
 }
 
+static void ahci_update_sctl_spm(struct ata_port *ap, u8 sctl_spm,
+				 int may_push_sctl)
+{
+	static const u32 icc_map[] = {
+		[0x1]	= PORT_CMD_ICC_PARTIAL,
+		[0x2]	= PORT_CMD_ICC_SLUMBER,
+		[0x4]	= PORT_CMD_ICC_ACTIVE,
+	};
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+
+	/* proceed only if idle */
+	if (!(tmp & PORT_CMD_ICC_MASK))
+		writel(tmp | icc_map[sctl_spm], port_mmio + PORT_CMD);
+}
+
+static unsigned long ahci_hips_timer_fn(struct ata_port *ap, int seq)
+{
+	u8 sctl_ipm = ata_scontrol_field(ap->scontrol, ATA_SCTL_IPM);
+
+	return sata_do_hips_timer_fn(ap, seq, sctl_ipm, ahci_update_sctl_spm);
+}
+
+static void ahci_set_powersave(struct ata_port *ap, int ps_state)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	u8 sctl_ipm;
+
+	/* determine IPM */
+	sctl_ipm = 0x3;
+	if (hpriv->cap & HOST_CAP_PARTIAL)
+		sctl_ipm &= ~0x1;
+	if (hpriv->cap & HOST_CAP_SLUMBER)
+		sctl_ipm &= ~0x2;
+
+	/* turn off SError.N IRQ if entering dynamic powersave mode */
+	if (ata_ps_dynamic(ps_state))
+		writel(DEF_PORT_IRQ & ~PORT_IRQ_PHYRDY,
+		       port_mmio + PORT_IRQ_MASK);
+
+	/* do standard SATA set_powersave */
+	if (ata_ps_dynamic(ps_state) == ATA_PS_HIPS) {
+		ap->ps_timer_fn = ahci_hips_timer_fn;
+		sata_determine_hips_params(ap, &sctl_ipm);
+	}
+
+	sata_do_set_powersave(ap, ps_state, sctl_ipm, ahci_update_sctl_spm);
+}
+
 static void ahci_setup_port(struct ata_ioports *port, unsigned long base,
 			    unsigned int port_idx)
 {
@@ -1398,6 +1461,9 @@ static int ahci_init_one (struct pci_dev
 	    (hpriv->cap & HOST_CAP_NCQ))
 		probe_ent->host_flags |= ATA_FLAG_NCQ;
 
+	if (hpriv->cap & (HOST_CAP_PARTIAL | HOST_CAP_SLUMBER))
+		probe_ent->host_flags |= ATA_FLAG_HIPS | ATA_FLAG_DIPS;
+
 	ahci_print_info(probe_ent);
 
 	/* FIXME: check ata_device_add return value */
-- 
1.3.2


