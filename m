From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI driver preferring nr_ports over port map
Date: Tue, 05 Feb 2008 22:17:46 +0900
Message-ID: <47A861FA.1070001@gmail.com>
References: <47A712240200007800045D39@public.id2-vpn.continvity.gns.novell.com> <47A71538.50803@gmail.com> <47A8228B.76E4.0078.0@novell.com> <47A854AE.5070403@gmail.com> <47A86734.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:25910 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbYBENR7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2008 08:17:59 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1694093rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 05 Feb 2008 05:17:58 -0800 (PST)
In-Reply-To: <47A86734.76E4.0078.0@novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Jan Beulich wrote:
> It does, in the description for bits 4:0 of the host capabilities register:
> "Number of Ports (NPS)" RO. Hardwired to 5h to indicate support for 6
> ports. Note that the number of ports indicated in this field may be more
> than the number of ports indicated in the PI (ABAR + 0Ch) register."

Oops, you're right, NP can go over PI.  Somehow I've been believing it
should match PI.  Oh well, that's me being delusional again.  :-(

>From ahci 1.1.

 Number of Ports (NP): 0's based value indicating the maximum number
 of ports supported by the HBA silicon. A maximum of 32 ports can be
 supported. A value of Impl.  '0h', indicating one port, is the
 minimum requirement. Note that the number of ports Spec.  indicated
 in this field may be more than the number of ports indicated in the
 GHC.PI register.

Does the following patch fix the problem?

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
