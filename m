From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: AHCI driver preferring nr_ports over port map
Date: Tue, 05 Feb 2008 14:51:55 +0000
Message-ID: <47A8861B.76E4.0078.0@novell.com>
References: <47A712240200007800045D39@public.id2-vpn.continvity.gns.novell.com>
 <47A71538.50803@gmail.com> <47A8228B.76E4.0078.0@novell.com>
 <47A854AE.5070403@gmail.com> <47A86734.76E4.0078.0@novell.com>
 <47A861FA.1070001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:19825
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750805AbYBEOvj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Feb 2008 09:51:39 -0500
In-Reply-To: <47A861FA.1070001@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

>Does the following patch fix the problem?

Yes, it does - thanks!

Jan

*********************************

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index e75966b..39627c7 100644
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
+		/* If PI has more ports than n_ports, whine and clear
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

