From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 2/5] ata: ahci_imx: avoid reprobing ahci_imx driver when
 using DT
Date: Wed, 16 Apr 2014 09:43:30 +0100
Message-ID: <E1WaLRK-0002yJ-T1@rmk-PC.arm.linux.org.uk>
References: <20140416084227.GD24070@n2100.arm.linux.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:36130 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751107AbaDPInc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 04:43:32 -0400
In-Reply-To: <20140416084227.GD24070@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Avoid matching our child platform device, which can happen as we copy the
DT node to the child device.  This allows the child platform device to be
matched against the ahci-imx driver and should this happen, it will cause
another platform device to be allocated, resulting in failure.

Ideally, we shouldn't be copying the of_node, but this is unavoidable as
prevents ahci_platform() obtaining its resources.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/ata/ahci_imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 6a56a561a80b..26ee412127b3 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -213,6 +213,10 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	unsigned int reg_val;
 	int ret;
 
+	/* Prevent our child ahci device coming back to us */
+	if (!strcmp(dev_name(&pdev->dev), "ahci"))
+		return -ENODEV;
+
 	of_id = of_match_device(imx_ahci_of_match, dev);
 	if (!of_id)
 		return -EINVAL;
-- 
1.8.3.1

