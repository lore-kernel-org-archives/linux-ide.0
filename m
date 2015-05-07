From: Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH] ahci: avoton port-disable reset-quirk
Date: Thu, 07 May 2015 14:45:50 -0400
Message-ID: <20150507184529.25927.35320.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41016 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbbEGSsn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 May 2015 14:48:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Avoton AHCI occasionally sees drive probe timeouts at driver load time.
When this happens SCR_STATUS indicates device detected, but no D2H FIS
reception.  Reset the internal link state machines by bouncing
port-enable in the PCS register when this occurs.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

Hi Tejun,

The field reports success with this patch, but I wonder what problems I
might induce by bouncing the port aggressively upon seeing SStatus == 1?
Otherwise, if this looks good, please merge.

--              
Dan             

 drivers/ata/ahci.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 33bb06e006c9..782c3f1d7931 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -66,6 +66,7 @@ enum board_ids {
 	board_ahci_yes_fbs,
 
 	/* board IDs for specific chipsets in alphabetical order */
+	board_ahci_avn,
 	board_ahci_mcp65,
 	board_ahci_mcp77,
 	board_ahci_mcp89,
@@ -84,6 +85,8 @@ enum board_ids {
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 				 unsigned long deadline);
+static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
+			      unsigned long deadline);
 static void ahci_mcp89_apple_enable(struct pci_dev *pdev);
 static bool is_mcp89_apple(struct pci_dev *pdev);
 static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
@@ -107,6 +110,11 @@ static struct ata_port_operations ahci_p5wdh_ops = {
 	.hardreset		= ahci_p5wdh_hardreset,
 };
 
+static struct ata_port_operations ahci_avn_ops = {
+	.inherits		= &ahci_ops,
+	.hardreset		= ahci_avn_hardreset,
+};
+
 static const struct ata_port_info ahci_port_info[] = {
 	/* by features */
 	[board_ahci] = {
@@ -151,6 +159,12 @@ static const struct ata_port_info ahci_port_info[] = {
 		.port_ops	= &ahci_ops,
 	},
 	/* by chipsets */
+	[board_ahci_avn] = {
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_avn_ops,
+	},
 	[board_ahci_mcp65] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_FPDMA_AA | AHCI_HFLAG_NO_PMP |
 				 AHCI_HFLAG_YES_NCQ),
@@ -290,14 +304,14 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1f27), board_ahci }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f2e), board_ahci }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x1f2f), board_ahci }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f32), board_ahci }, /* Avoton AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1f33), board_ahci }, /* Avoton AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1f34), board_ahci }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f35), board_ahci }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f36), board_ahci }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci }, /* Avoton RAID */
-	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f32), board_ahci_avn }, /* Avoton AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1f33), board_ahci_avn }, /* Avoton AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1f34), board_ahci_avn }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f35), board_ahci_avn }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f36), board_ahci_avn }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f37), board_ahci_avn }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f3e), board_ahci_avn }, /* Avoton RAID */
+	{ PCI_VDEVICE(INTEL, 0x1f3f), board_ahci_avn }, /* Avoton RAID */
 	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x2827), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x8d02), board_ahci }, /* Wellsburg AHCI */
@@ -670,6 +684,70 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 	return rc;
 }
 
+static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
+			      unsigned long deadline)
+{
+	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	struct ata_port *ap = link->ap;
+	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
+	unsigned long tmo = deadline - jiffies;
+	struct ata_taskfile tf;
+	bool online;
+	int rc, i;
+
+	DPRINTK("ENTER\n");
+
+	ahci_stop_engine(ap);
+
+	for (i = 0; i < 2; i++) {
+		u32 sstatus;
+
+		/* clear D2H reception area to properly wait for D2H FIS */
+		ata_tf_init(link->device, &tf);
+		tf.command = ATA_BUSY;
+		ata_tf_to_fis(&tf, 0, 0, d2h_fis);
+
+		rc = sata_link_hardreset(link, timing, deadline, &online,
+				ahci_check_ready);
+
+		/*
+		 * If the the link is stuck at DET==1 after a reset try
+		 * bouncing the port and retrying the reset.
+		 */
+		if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0 &&
+				(sstatus & 0xf) == 1) {
+			u16 val;
+			int port = ap->port_no;
+			struct ata_host *host = ap->host;
+			struct pci_dev *pdev = to_pci_dev(host->dev);
+
+			ata_link_printk(link, KERN_INFO, "avn bounce port%d\n",
+					port);
+
+			/* bounce port-enable in PCS */
+			pci_read_config_word(pdev, 0x92, &val);
+			val &= ~(1 << port);
+			pci_write_config_word(pdev, 0x92, val);
+			ata_msleep(ap, 1000);
+			val |= 1 << port;
+			pci_write_config_word(pdev, 0x92, val);
+			deadline += tmo;
+		} else
+			break;
+	}
+
+	hpriv->start_engine(ap);
+
+	if (online)
+		*class = ahci_dev_classify(ap);
+
+	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
+	return rc;
+}
+
+
 #ifdef CONFIG_PM
 static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {

