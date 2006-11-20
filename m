From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: do not powerdown during initialization
Date: Mon, 20 Nov 2006 15:42:36 +0900
Message-ID: <20061120064236.GM2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:46144 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S933970AbWKTGmp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Nov 2006 01:42:45 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1106219ugc
        for <linux-ide@vger.kernel.org>; Sun, 19 Nov 2006 22:42:44 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: flyboy@gmail.com

ahci_init_controller() calls ahci_deinit_port() to make sure the
controller is stopped before initializing the controller.  In turn,
ahci_deinit_port() invokes ahci_power_down() to power down the port.
If the controller supports slumber mode, the link is put into it.

Unfortunately, some devices don't implement link powersaving mode
properly and show erratic behavior after link is put into slumber
mode.  For example, HL-DT-ST DVD-RAM GSA-H30N completely locks up on
slumber transition and can only be recovered with the *REAL* hard
reset - power removal and reapply.

Note that this makes the first probing reset different from all
others.  If the above dvd-ram is hotplugged after ahci is initialized,
no problem occurs because ahci is already fully initialized with phy
powered up.  So, this might also be the reason for other weird AHCI
initial probing abnormalities.

This patch moves power up/down out of port init/deinit and call them
only when needed.

Power down is now called only when suspending.  As system suspend
usually involves powering down 12v for storage devices, this shouldn't
cause problem even if the attached device doesn't support slumber
mode.  However, in partial power management and suspend failure cases,
devices might lock up after suspend attempt.  I thought about removing
transition to slumber mode altogether but ahci spec mandates it before
HBA D3 state transition.  Blacklisting such devices might be the
solution.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Berck, can you please test this patch?  This might fix your problem
too.  Jeff, this patch is necessary regardless of Berck's repsonse.  I
think this should go into #usptream-fixes too after some testing in
#upstream (and in -mm).

Thanks.

 drivers/ata/ahci.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b05e22f..a6ad324 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -588,9 +588,6 @@ static void ahci_power_down(void __iomem
 static void ahci_init_port(void __iomem *port_mmio, u32 cap,
 			   dma_addr_t cmd_slot_dma, dma_addr_t rx_fis_dma)
 {
-	/* power up */
-	ahci_power_up(port_mmio, cap);
-
 	/* enable FIS reception */
 	ahci_start_fis_rx(port_mmio, cap, cmd_slot_dma, rx_fis_dma);
 
@@ -616,9 +613,6 @@ static int ahci_deinit_port(void __iomem
 		return rc;
 	}
 
-	/* put device into slumber mode */
-	ahci_power_down(port_mmio, cap);
-
 	return 0;
 }
 
@@ -1293,7 +1287,9 @@ static int ahci_port_suspend(struct ata_
 	int rc;
 
 	rc = ahci_deinit_port(port_mmio, hpriv->cap, &emsg);
-	if (rc) {
+	if (rc == 0)
+		ahci_power_down(port_mmio, hpriv->cap);
+	else {
 		ata_port_printk(ap, KERN_ERR, "%s (%d)\n", emsg, rc);
 		ahci_init_port(port_mmio, hpriv->cap,
 			       pp->cmd_slot_dma, pp->rx_fis_dma);
@@ -1309,6 +1305,7 @@ static int ahci_port_resume(struct ata_p
 	void __iomem *mmio = ap->host->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 
+	ahci_power_up(port_mmio, hpriv->cap);
 	ahci_init_port(port_mmio, hpriv->cap, pp->cmd_slot_dma, pp->rx_fis_dma);
 
 	return 0;
@@ -1415,6 +1412,9 @@ static int ahci_port_start(struct ata_po
 
 	ap->private_data = pp;
 
+	/* power up port */
+	ahci_power_up(port_mmio, hpriv->cap);
+
 	/* initialize port */
 	ahci_init_port(port_mmio, hpriv->cap, pp->cmd_slot_dma, pp->rx_fis_dma);
 
