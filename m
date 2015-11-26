From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v6 2/7] ata: ahci_brcmstb: disable NCQ for MIPS-based platforms
Date: Thu, 26 Nov 2015 11:56:30 +0900
Message-ID: <1448506595-4981-3-git-send-email-jaedon.shin@gmail.com>
References: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36611 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbbKZC4x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2015 21:56:53 -0500
Received: by pacdm15 with SMTP id dm15so75616829pac.3
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2015 18:56:53 -0800 (PST)
In-Reply-To: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-ide@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>

The most MIPS-based platforms need to disable NCQ while have the NCQ
capability in HOST_CAP, and several ARM-based platforms (eg. BCM7349A0,
BCM7445A0, BCM7445B0) need to disable too.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 73e3b0b2a3c2..e62e02de71d0 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -69,10 +69,15 @@
 	(DATA_ENDIAN << DMADESC_ENDIAN_SHIFT) |		\
 	(MMIO_ENDIAN << MMIO_ENDIAN_SHIFT))
 
+enum brcm_ahci_quirks {
+	BRCM_AHCI_QUIRK_NO_NCQ		= BIT(0),
+};
+
 struct brcm_ahci_priv {
 	struct device *dev;
 	void __iomem *top_ctrl;
 	u32 port_mask;
+	u32 quirks;
 };
 
 static const struct ata_port_info ahci_brcm_port_info = {
@@ -256,6 +261,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
+	if (of_device_is_compatible(dev->of_node, "brcm,bcm7425-ahci"))
+		priv->quirks |= BRCM_AHCI_QUIRK_NO_NCQ;
+
 	brcm_sata_init(priv);
 
 	priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
@@ -273,6 +281,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (priv->quirks & BRCM_AHCI_QUIRK_NO_NCQ)
+		hpriv->flags |= AHCI_HFLAG_NO_NCQ;
+
 	ret = ahci_platform_init_host(pdev, hpriv, &ahci_brcm_port_info,
 				      &ahci_platform_sht);
 	if (ret)
-- 
2.6.3

