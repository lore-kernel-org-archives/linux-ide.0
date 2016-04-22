From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 4/5] ata: ahci_mvebu: add support for Armada 8K
Date: Fri, 22 Apr 2016 16:32:40 +0200
Message-ID: <1461335561-18363-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41751 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754378AbcDVOcu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Apr 2016 10:32:50 -0400
In-Reply-To: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>
Cc: linux-ide@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commit adds support for the AHCI controller found in the Armada
7K/8K ARM64 SoCs. This controller uses non-standard port offset and
port length values, which explains why some special handling is
needed.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/ata/ahci_mvebu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index de7128d..b1d1d64 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -120,6 +120,10 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 
 		ahci_mvebu_mbus_config(hpriv, dram);
 		ahci_mvebu_regret_option(hpriv);
+	} else if (of_device_is_compatible(pdev->dev.of_node,
+					   "marvell,armada-8k-ahci")) {
+		hpriv->port_offset = 0x10000;
+		hpriv->port_length = 0x10000;
 	}
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
@@ -137,6 +141,7 @@ disable_resources:
 static const struct of_device_id ahci_mvebu_of_match[] = {
 	{ .compatible = "marvell,armada-380-ahci", },
 	{ .compatible = "marvell,armada-3700-ahci", },
+	{ .compatible = "marvell,armada-8k-ahci", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
-- 
2.6.4

