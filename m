From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 3/3] ata: sata_mv: Fix probe failures with optional phys
Date: Sat,  1 Feb 2014 15:15:57 +0100
Message-ID: <1391264157-2112-3-git-send-email-andrew@lunn.ch>
References: <0140131114857.GC26148@htj.dyndns.org>
 <1391264157-2112-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:49895 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932797AbaBAOQU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Feb 2014 09:16:20 -0500
In-Reply-To: <1391264157-2112-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, kishon@ti.com
Cc: linux-ide@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

Make use of devm_phy_optional() in order to fix probe failures on
Armada 370, XP and others, when there is no phy driver available.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/ata/sata_mv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index eaa21eddbe70..26021cf077a8 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4111,12 +4111,14 @@ static int mv_platform_probe(struct platform_device *pdev)
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

