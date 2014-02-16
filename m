From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH] ata: sata_mv: Cleanup only the initialized ports
Date: Sun, 16 Feb 2014 12:29:53 -0300
Message-ID: <1392564593-3691-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34880 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752451AbaBPPaD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Feb 2014 10:30:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

When an error occurs in the port initialization loop, currently the
driver tries to cleanup all the ports. This results in a NULL pointer
dereference if the ports were only partially initialized.

Fix this by updating only the number of initialized ports (either
with failure or successfully), before jumping to the error path
and looping over that number in the cleanup loop.

Cc: Andrew Lunn <andrew@lunn.ch>
Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Andrew, feel free to rework the patch, fix the comments or anything else.
This is just a quick proposal.

 drivers/ata/sata_mv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 20a7517..9c1a11d 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4104,7 +4104,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 	if (!hpriv->port_phys)
 		return -ENOMEM;
 	host->private_data = hpriv;
-	hpriv->n_ports = n_ports;
 	hpriv->board_idx = chip_soc;
 
 	host->iomap = NULL;
@@ -4132,11 +4131,17 @@ static int mv_platform_probe(struct platform_device *pdev)
 			hpriv->port_phys[port] = NULL;
 			if ((rc != -EPROBE_DEFER) && (rc != -ENODEV))
 				dev_warn(&pdev->dev, "error getting phy");
+
+			/* Cleanup only the initialized ports */
+			hpriv->n_ports = port;
 			goto err;
 		} else
 			phy_power_on(hpriv->port_phys[port]);
 	}
 
+	/* All the ports have been initialized */
+	hpriv->n_ports = n_ports;
+
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
@@ -4174,7 +4179,7 @@ err:
 		clk_disable_unprepare(hpriv->clk);
 		clk_put(hpriv->clk);
 	}
-	for (port = 0; port < n_ports; port++) {
+	for (port = 0; port < hpriv->n_ports; port++) {
 		if (!IS_ERR(hpriv->port_clks[port])) {
 			clk_disable_unprepare(hpriv->port_clks[port]);
 			clk_put(hpriv->port_clks[port]);
-- 
1.8.1.5

