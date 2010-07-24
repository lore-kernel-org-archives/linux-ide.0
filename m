From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream] ahci: add HFLAG_YES_FBS and apply it to 88SE9128
Date: Sat, 24 Jul 2010 16:53:48 +0200
Message-ID: <4C4AFE7C.5070506@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44717 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733Ab0GXOyD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jul 2010 10:54:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

88SE9128 can do FBS and sets it in HOST_CAP but forgets to set FBSCP
in PORT_CMD.  Implement AHCI_HFLAG_YES_FBS and apply it to 88SE9128.

Signed-off-by: Tejun Heo <tj@kernel.org>
--
 drivers/ata/ahci.c    |   11 +++++++++++
 drivers/ata/ahci.h    |    1 +
 drivers/ata/libahci.c |   16 ++++++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f252253..41fa0a3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -60,6 +60,7 @@ enum board_ids {
 	board_ahci,
 	board_ahci_ign_iferr,
 	board_ahci_nosntf,
+	board_ahci_yes_fbs,

 	/* board IDs for specific chipsets in alphabetical order */
 	board_ahci_mcp65,
@@ -132,6 +133,14 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_yes_fbs] =
+	{
+		AHCI_HFLAGS	(AHCI_HFLAG_YES_FBS),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	/* by chipsets */
 	[board_ahci_mcp65] =
 	{
@@ -362,6 +371,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Marvell */
 	{ PCI_VDEVICE(MARVELL, 0x6145), board_ahci_mv },	/* 6145 */
 	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
+	{ PCI_DEVICE(0x1b4b, 0x9123),
+	  .driver_data = board_ahci_yes_fbs },			/* 88se9128 */

 	/* Promise */
 	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 7113c57..474427b 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -209,6 +209,7 @@ enum {
 							link offline */
 	AHCI_HFLAG_NO_SNTF		= (1 << 12), /* no sntf */
 	AHCI_HFLAG_NO_FPDMA_AA		= (1 << 13), /* no FPDMA AA */
+	AHCI_HFLAG_YES_FBS		= (1 << 14), /* force FBS cap on */

 	/* ap->flags bits */

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 81e772a..666850d 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -430,6 +430,12 @@ void ahci_save_initial_config(struct device *dev,
 		cap &= ~HOST_CAP_SNTF;
 	}

+	if (!(cap & HOST_CAP_FBS) && (hpriv->flags & AHCI_HFLAG_YES_FBS)) {
+		dev_printk(KERN_INFO, dev,
+			   "controller can do FBS, turning on CAP_FBS\n");
+		cap |= HOST_CAP_FBS;
+	}
+
 	if (force_port_map && port_map != force_port_map) {
 		dev_printk(KERN_INFO, dev, "forcing port_map 0x%x -> 0x%x\n",
 			   port_map, force_port_map);
@@ -2036,9 +2042,15 @@ static int ahci_port_start(struct ata_port *ap)
 		u32 cmd = readl(port_mmio + PORT_CMD);
 		if (cmd & PORT_CMD_FBSCP)
 			pp->fbs_supported = true;
-		else
+		else if (hpriv->flags & AHCI_HFLAG_YES_FBS) {
+			dev_printk(KERN_INFO, dev,
+				   "port %d can do FBS, forcing FBSCP\n",
+				   ap->port_no);
+			pp->fbs_supported = true;
+		} else
 			dev_printk(KERN_WARNING, dev,
-				   "The port is not capable of FBS\n");
+				   "port %d is not capable of FBS\n",
+				   ap->port_no);
 	}

 	if (pp->fbs_supported) {
