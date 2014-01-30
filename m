From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] ATA: SATA_MV: Fix probe failure when no phy exists
Date: Thu, 30 Jan 2014 21:50:35 +0100
Message-ID: <1391115035-25960-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:49454 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482AbaA3Uu4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jan 2014 15:50:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

Armada 370 and XP do not have a SATA phy driver.  The generic phy
layer does not cleanly support optional phys. It is not possible to
determine from the error code if there is expected to be a phy
according to DT, but it cannot be found, or no phy is listed in
DT. All that can be determined is that a phy is expected, but the
driver has not been loaded yet, in which case -EPROBE_DEFER is
returned. Thus for 370 and XP the driver failed to probe.  Play safe,
consider all errors except -EPROBE_DEFER to be none fatal and keep
going, and in the case of -EPROBE_DEFER exit the probe function with
that error code.

Tested on Kirkwood with a sata phy driver and on 370 without a sata
phy driver.

Reported-by: Jean Pihet <jean.pihet@linaro.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Gregory Clement <gregory.clement@free-electrons.com>
---
 drivers/ata/sata_mv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index eaa21eddbe70..148ff5a82c8b 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4115,9 +4115,8 @@ static int mv_platform_probe(struct platform_device *pdev)
 		if (IS_ERR(hpriv->port_phys[port])) {
 			rc = PTR_ERR(hpriv->port_phys[port]);
 			hpriv->port_phys[port] = NULL;
-			if ((rc != -EPROBE_DEFER) && (rc != -ENODEV))
-				dev_warn(&pdev->dev, "error getting phy");
-			goto err;
+			if (rc == -EPROBE_DEFER)
+				goto err;
 		} else
 			phy_power_on(hpriv->port_phys[port]);
 	}
-- 
1.8.5.2

