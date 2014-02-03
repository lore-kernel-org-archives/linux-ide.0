From: Andrew Lunn <andrew@lunn.ch>
Subject: [patch v3 3/3] ata: sata_mv: Fix probe failures with optional phys
Date: Mon,  3 Feb 2014 19:17:20 +0100
Message-ID: <1391451440-15959-1-git-send-email-andrew@lunn.ch>
References: <52EFE823.6060200@cogentembedded.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:50456 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592AbaBCSRv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Feb 2014 13:17:51 -0500
In-Reply-To: <52EFE823.6060200@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, kishon@ti.com
Cc: Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

Make use of devm_optional_get() in order to fix probe failures on
Armada 370, XP and others, when there is no phy driver available.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2
No change
v3
Fix commit log devm_get_optional->devm_option_get.
---
 drivers/ata/sata_mv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 20a7517bd339..52b8181ddafd 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4126,12 +4126,14 @@ static int mv_platform_probe(struct platform_device *pdev)
 			clk_prepare_enable(hpriv->port_clks[port]);
 
 		sprintf(port_number, "port%d", port);
-		hpriv->port_phys[port] = devm_phy_get(&pdev->dev, port_number);
+		hpriv->port_phys[port] = devm_phy_optional_get(&pdev->dev,
+							       port_number);
 		if (IS_ERR(hpriv->port_phys[port])) {
 			rc = PTR_ERR(hpriv->port_phys[port]);
 			hpriv->port_phys[port] = NULL;
-			if ((rc != -EPROBE_DEFER) && (rc != -ENODEV))
-				dev_warn(&pdev->dev, "error getting phy");
+			if (rc != -EPROBE_DEFER)
+				dev_warn(&pdev->dev, "error getting phy %d",
+					rc);
 			goto err;
 		} else
 			phy_power_on(hpriv->port_phys[port]);
-- 
1.8.5.2

