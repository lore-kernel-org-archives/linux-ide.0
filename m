From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/2] ahci: move port_map handling to ahci_save_initial_config()
Date: Sun, 18 Mar 2007 22:26:53 +0900
Message-ID: <20070318132653.GD6152@htj.dyndns.org>
References: <20070318131533.GC6152@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:41447 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXCRN1A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 09:27:00 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1081485uga
        for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 06:26:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070318131533.GC6152@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Move cross checking between port_map and cap.n_ports into
ahci_save_initial_config().  After save_initial_config is done,
hpriv->port_map is always setup properly.

Tested on JMB363, ICH7 and ICH8 (with dummy ports).

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This moves all special case fixup into ahci_save_initial_config() and
cleans up initialization path.

 drivers/ata/ahci.c |   57 +++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -484,6 +484,7 @@ static void ahci_save_initial_config(str
 	struct ahci_host_priv *hpriv = probe_ent->private_data;
 	void __iomem *mmio = probe_ent->iomap[AHCI_PCI_BAR];
 	u32 cap, port_map;
+	int i;
 
 	/* Values prefixed with saved_ are written back to host after
 	 * reset.  Values without are used for driver operation.
@@ -501,6 +502,31 @@ static void ahci_save_initial_config(str
 		hpriv->saved_port_map = port_map;
 	}
 
+	/* cross check port_map and cap.n_ports */
+	if (probe_ent->port_flags & AHCI_FLAG_HONOR_PI) {
+		u32 tmp_port_map = port_map;
+		int n_ports = ahci_nr_ports(cap);
+
+		for (i = 0; i < AHCI_MAX_PORTS && n_ports; i++) {
+			if (tmp_port_map & (1 << i)) {
+				n_ports--;
+				tmp_port_map &= ~(1 << i);
+			}
+		}
+
+		/* Whine if inconsistent.  No need to update cap.
+		 * port_map is used to determine number of ports.
+		 */
+		if (n_ports || tmp_port_map)
+			dev_printk(KERN_WARNING, probe_ent->dev,
+				   "nr_ports (%u) and implemented port map "
+				   "(0x%x) don't match\n",
+				   ahci_nr_ports(cap), port_map);
+	} else {
+		/* fabricate port_map from cap.nr_ports */
+		port_map = (1 << ahci_nr_ports(cap)) - 1;
+	}
+
 	/* record values to use during operation */
 	hpriv->cap = cap;
 	hpriv->port_map = port_map;
@@ -1572,41 +1598,18 @@ static int ahci_host_init(struct ata_pro
 	struct ahci_host_priv *hpriv = probe_ent->private_data;
 	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
 	void __iomem *mmio = probe_ent->iomap[AHCI_PCI_BAR];
-	unsigned int i, cap_n_ports, using_dac;
+	unsigned int i, using_dac;
 	int rc;
 
 	rc = ahci_reset_controller(mmio, pdev, hpriv);
 	if (rc)
 		return rc;
 
-	cap_n_ports = ahci_nr_ports(hpriv->cap);
+	probe_ent->n_ports = fls(hpriv->port_map);
+	probe_ent->dummy_port_mask = ~hpriv->port_map;
 
 	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
-		hpriv->cap, hpriv->port_map, cap_n_ports);
-
-	if (probe_ent->port_flags & AHCI_FLAG_HONOR_PI) {
-		unsigned int n_ports = cap_n_ports;
-		u32 port_map = hpriv->port_map;
-		int max_port = 0;
-
-		for (i = 0; i < AHCI_MAX_PORTS && n_ports; i++) {
-			if (port_map & (1 << i)) {
-				n_ports--;
-				port_map &= ~(1 << i);
-				max_port = i;
-			} else
-				probe_ent->dummy_port_mask |= 1 << i;
-		}
-
-		if (n_ports || port_map)
-			dev_printk(KERN_WARNING, &pdev->dev,
-				   "nr_ports (%u) and implemented port map "
-				   "(0x%x) don't match\n",
-				   cap_n_ports, hpriv->port_map);
-
-		probe_ent->n_ports = max_port + 1;
-	} else
-		probe_ent->n_ports = cap_n_ports;
+		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
 
 	using_dac = hpriv->cap & HOST_CAP_64;
 	if (using_dac &&
