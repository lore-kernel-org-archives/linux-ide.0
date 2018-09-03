From: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 4/9] ata: ahci_platform: add support for PHY
 controller regulator
Date: Mon,  3 Sep 2018 12:01:56 +0200
Message-ID: <20180903100201.23131-5-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Reply-To: clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBD7YLCN32UNBBJENWTOAKGQEWRAIHDY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

The SoC R40 AHCI controller need a PHY regulator to work.
But since the PHY is embedded in the controller, we cannot do a DT node for it,
since phy-supply works only in node with a PHY compatible.
So this patch adds a way to add an optional phy-supply regulator on AHCI controller node.

Signed-off-by: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/ata/ahci.h             |  1 +
 drivers/ata/libahci_platform.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 1415f1012de5..ef356e70e6de 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -353,6 +353,7 @@ struct ahci_host_priv {
 	struct reset_control	*rsts;		/* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
 	struct regulator	*ahci_regulator;/* Optional */
+	struct regulator	*phy_regulator;/* Optional */
 	/*
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
 	 * the PHY position in this array.
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index a886b61476a3..dc4d79b1c9ae 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -157,6 +157,12 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 			return rc;
 	}
 
+	if (hpriv->phy_regulator) {
+		rc = regulator_enable(hpriv->phy_regulator);
+		if (rc)
+			goto disable_ahci_pwrs;
+	}
+
 	for (i = 0; i < hpriv->nports; i++) {
 		if (!hpriv->target_pwrs[i])
 			continue;
@@ -173,6 +179,9 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 		if (hpriv->target_pwrs[i])
 			regulator_disable(hpriv->target_pwrs[i]);
 
+	if (hpriv->phy_regulator)
+		regulator_disable(hpriv->phy_regulator);
+disable_ahci_pwrs:
 	if (hpriv->ahci_regulator)
 		regulator_disable(hpriv->ahci_regulator);
 	return rc;
@@ -198,6 +207,8 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 
 	if (hpriv->ahci_regulator)
 		regulator_disable(hpriv->ahci_regulator);
+	if (hpriv->phy_regulator)
+		regulator_disable(hpriv->phy_regulator);
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_regulators);
 /**
@@ -430,6 +441,15 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		hpriv->ahci_regulator = NULL;
 	}
 
+	hpriv->phy_regulator = devm_regulator_get_optional(dev, "phy");
+	if (IS_ERR(hpriv->phy_regulator)) {
+		rc = PTR_ERR(hpriv->phy_regulator);
+		if (rc == -EPROBE_DEFER)
+			goto err_out;
+		rc = 0;
+		hpriv->phy_regulator = NULL;
+	}
+
 	if (flags & AHCI_PLATFORM_GET_RESETS) {
 		hpriv->rsts = devm_reset_control_array_get_optional_shared(dev);
 		if (IS_ERR(hpriv->rsts)) {
-- 
2.16.4
