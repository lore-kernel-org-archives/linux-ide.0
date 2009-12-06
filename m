From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH 4/6] sata_mv: move the PCI bar description initialization code from mv_init_host to mv_pci_init_one
Date: Sun,  6 Dec 2009 18:26:20 +0200
Message-ID: <1260116782-31714-4-git-send-email-saeed@marvell.com>
References: <1260116782-31714-1-git-send-email-saeed@marvell.com>
 <1260116782-31714-2-git-send-email-saeed@marvell.com>
 <1260116782-31714-3-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:50740 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679AbZLFQ0Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Dec 2009 11:26:25 -0500
In-Reply-To: <1260116782-31714-3-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org
Cc: liml@rtr.ca, nico@fluxnic.net, buytenh@wantstofly.org, Saeed Bishara <saeed@marvell.com>

the mv_init_host will be used to initialize the host hw on resume. the PCI bar description need to be initialized only once when the device probed.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 17a138b..3eadbd5 100755
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3910,14 +3910,6 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 		void __iomem *port_mmio = mv_port_base(mmio, port);
 
 		mv_port_init(&ap->ioaddr, port_mmio);
-
-#ifdef CONFIG_PCI
-		if (!IS_SOC(hpriv)) {
-			unsigned int offset = port_mmio - mmio;
-			ata_port_pbar_desc(ap, MV_PRIMARY_BAR, -1, "mmio");
-			ata_port_pbar_desc(ap, MV_PRIMARY_BAR, offset, "port");
-		}
-#endif
 	}
 
 	for (hc = 0; hc < n_hc; hc++) {
@@ -4268,7 +4260,7 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 	const struct ata_port_info *ppi[] = { &mv_port_info[board_idx], NULL };
 	struct ata_host *host;
 	struct mv_host_priv *hpriv;
-	int n_ports, rc;
+	int n_ports, port, rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
@@ -4304,6 +4296,15 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
+	for (port = 0; port < host->n_ports; port++) {
+		struct ata_port *ap = host->ports[port];
+		void __iomem *port_mmio = mv_port_base(hpriv->base, port);
+		unsigned int offset = port_mmio - hpriv->base;
+
+		ata_port_pbar_desc(ap, MV_PRIMARY_BAR, -1, "mmio");
+		ata_port_pbar_desc(ap, MV_PRIMARY_BAR, offset, "port");
+	}
+
 	/* initialize adapter */
 	rc = mv_init_host(host, board_idx);
 	if (rc)
-- 
1.6.0.4

