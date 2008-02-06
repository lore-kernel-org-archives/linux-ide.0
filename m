From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: fix CAP.NP and PI handling
Date: Wed, 06 Feb 2008 15:13:51 +0900
Message-ID: <47A9501F.5020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:7619 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759436AbYBFInd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 03:43:33 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1885294rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 06 Feb 2008 00:43:33 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Jan Beulich <jbeulich@novell.com>

AHCI uses CAP.NP to indicate the number of ports and PI to tell which
ports are enabled.  The only requirement is that the number of ports
indicated by CAP.NP should equal or be higher than the number of
enabled ports in PI.

CAP.NP and PI carry duplicate information and there have been some
interesting cases.  Some early AHCI controllers didn't set PI at all
and just implement from port 0 to CAP.NP.  An ICH8 board which wired
four out of six available ports had 3 (4 ports) for CAP.NP and 0x33
for PI.  While ESB2 has less bits set in PI than the value in CAP.NP.

Till now, ahci driver assumed that PI is invalid if it doesn't match
CAP.NP exactly.  This violates AHCI standard and the driver ends up
accessing unmimplemented ports on ESB2.

This patch updates CAP.NP and PI handling such that PI can have less
number of bits set than indicated in CAP.NP and the highest port is
determined as the maximum port of what CAP.NP and PI indicate.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jan Beulich <jbeulich@novell.com>
---
 drivers/ata/ahci.c |   35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 27c8d56..29e71bd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -679,24 +679,20 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 
 	/* cross check port_map and cap.n_ports */
 	if (port_map) {
-		u32 tmp_port_map = port_map;
-		int n_ports = ahci_nr_ports(cap);
+		int map_ports = 0;
 
-		for (i = 0; i < AHCI_MAX_PORTS && n_ports; i++) {
-			if (tmp_port_map & (1 << i)) {
-				n_ports--;
-				tmp_port_map &= ~(1 << i);
-			}
-		}
+		for (i = 0; i < AHCI_MAX_PORTS; i++)
+			if (port_map & (1 << i))
+				map_ports++;
 
-		/* If n_ports and port_map are inconsistent, whine and
-		 * clear port_map and let it be generated from n_ports.
+		/* If PI has more ports than n_ports, whine, clear
+		 * port_map and let it be generated from n_ports.
 		 */
-		if (n_ports || tmp_port_map) {
+		if (map_ports > ahci_nr_ports(cap)) {
 			dev_printk(KERN_WARNING, &pdev->dev,
-				   "nr_ports (%u) and implemented port map "
-				   "(0x%x) don't match, using nr_ports\n",
-				   ahci_nr_ports(cap), port_map);
+				   "implemented port map (0x%x) contains more "
+				   "ports than nr_ports (%u), using nr_ports\n",
+				   port_map, ahci_nr_ports(cap));
 			port_map = 0;
 		}
 	}
@@ -2201,7 +2197,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct ata_host *host;
-	int i, rc;
+	int n_ports, i, rc;
 
 	VPRINTK("ENTER\n");
 
@@ -2255,7 +2251,14 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (hpriv->cap & HOST_CAP_PMP)
 		pi.flags |= ATA_FLAG_PMP;
 
-	host = ata_host_alloc_pinfo(&pdev->dev, ppi, fls(hpriv->port_map));
+	/* CAP.NP sometimes indicate the index of the last enabled
+	 * port, at other times, that of the last possible port, so
+	 * determining the maximum port number requires looking at
+	 * both CAP.NP and port_map.
+	 */
+	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
+
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
 	if (!host)
 		return -ENOMEM;
 	host->iomap = pcim_iomap_table(pdev);

