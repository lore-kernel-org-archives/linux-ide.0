From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v8 3/7] ata: libahci: allow to use multiple PHYs
Date: Mon, 30 Jun 2014 15:09:28 +0200
Message-ID: <1404133772-11741-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1404133772-11741-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404133772-11741-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org, kishon@ti.com
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The current implementation of the libahci does not allow to use multipl=
e
PHYs. This patch adds the support of multiple PHYs by the libahci while
keeping the old bindings valid for device tree compatibility.

This introduce a new way of defining SATA ports in the device tree, wit=
h
one port per sub-node. This as the advantage of allowing a per port
configuration. Because some ports may be accessible but disabled in the
device tree, the default port_map is computed automatically when using
this.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 drivers/ata/ahci.h             |   3 +-
 drivers/ata/libahci.c          |   7 ++
 drivers/ata/libahci_platform.c | 170 ++++++++++++++++++++++++++++++++-=
--------
 3 files changed, 144 insertions(+), 36 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 05882e4445a6..e5bdbf827ca8 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -330,7 +330,8 @@ struct ahci_host_priv {
 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
 	struct clk		*clks[AHCI_MAX_CLKS]; /* Optional */
 	struct regulator	*target_pwr;	/* Optional */
-	struct phy		*phy;		/* If platform uses phy */
+	struct phy		**phys;		/* If platform uses phys */
+	unsigned		nphys;		/* Number of phys */
 	void			*plat_data;	/* Other platform data */
 	/*
 	 * Optional ahci_start_engine override, if not set this gets set to t=
he
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 40ea583d3610..0bdee8330dcf 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -482,6 +482,13 @@ void ahci_save_initial_config(struct device *dev,
 		port_map &=3D mask_port_map;
 	}
=20
+	/*
+	 * If port_map was filled automatically when finding port sub-nodes,
+	 * make sure we get the right set here.
+	 */
+	if (hpriv->port_map)
+		port_map &=3D hpriv->port_map;
+
 	/* cross check port_map and cap.n_ports */
 	if (port_map) {
 		int map_ports =3D 0;
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platf=
orm.c
index 3a5b4ed25a4f..cd2bc50ba913 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -39,6 +39,61 @@ static struct scsi_host_template ahci_platform_sht =3D=
 {
 };
=20
 /**
+ * ahci_platform_enable_phys - Enable PHYs
+ * @hpriv: host private area to store config values
+ *
+ * This function enables all the PHYs found in hpriv->phys, if any.
+ * If a PHY fails to be enabled, it disables all the PHYs already
+ * enabled in reverse order and returns an error.
+ *
+ * RETURNS:
+ * 0 on success otherwise a negative error code
+ */
+int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
+{
+	int i, rc =3D 0;
+
+	for (i =3D 0; i < hpriv->nphys; i++) {
+		rc =3D phy_init(hpriv->phys[i]);
+		if (rc)
+			goto disable_phys;
+
+		rc =3D phy_power_on(hpriv->phys[i]);
+		if (rc) {
+			phy_exit(hpriv->phys[i]);
+			goto disable_phys;
+		}
+	}
+
+	return 0;
+
+disable_phys:
+	while (--i >=3D 0) {
+		phy_power_off(hpriv->phys[i]);
+		phy_exit(hpriv->phys[i]);
+	}
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ahci_platform_enable_phys);
+
+/**
+ * ahci_platform_disable_phys - Enable PHYs
+ * @hpriv: host private area to store config values
+ *
+ * This function disables all PHYs found in hpriv->phys.
+ */
+void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
+{
+	int i;
+
+	for (i =3D 0; i < hpriv->nphys; i++) {
+		phy_power_off(hpriv->phys[i]);
+		phy_exit(hpriv->phys[i]);
+	}
+}
+EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
+
+/**
  * ahci_platform_enable_clks - Enable platform clocks
  * @hpriv: host private area to store config values
  *
@@ -92,7 +147,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
  * following order:
  * 1) Regulator
  * 2) Clocks (through ahci_platform_enable_clks)
- * 3) Phy
+ * 3) Phys
  *
  * If resource enabling fails at any point the previous enabled resour=
ces
  * are disabled in reverse order.
@@ -114,17 +169,9 @@ int ahci_platform_enable_resources(struct ahci_hos=
t_priv *hpriv)
 	if (rc)
 		goto disable_regulator;
=20
-	if (hpriv->phy) {
-		rc =3D phy_init(hpriv->phy);
-		if (rc)
-			goto disable_clks;
-
-		rc =3D phy_power_on(hpriv->phy);
-		if (rc) {
-			phy_exit(hpriv->phy);
-			goto disable_clks;
-		}
-	}
+	rc =3D ahci_platform_enable_phys(hpriv);
+	if (rc)
+		goto disable_clks;
=20
 	return 0;
=20
@@ -144,16 +191,13 @@ EXPORT_SYMBOL_GPL(ahci_platform_enable_resources)=
;
  *
  * This function disables all ahci_platform managed resources in the
  * following order:
- * 1) Phy
+ * 1) Phys
  * 2) Clocks (through ahci_platform_disable_clks)
  * 3) Regulator
  */
 void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
 {
-	if (hpriv->phy) {
-		phy_power_off(hpriv->phy);
-		phy_exit(hpriv->phy);
-	}
+	ahci_platform_disable_phys(hpriv);
=20
 	ahci_platform_disable_clks(hpriv);
=20
@@ -187,7 +231,7 @@ static void ahci_platform_put_resources(struct devi=
ce *dev, void *res)
  * 2) regulator for controlling the targets power (optional)
  * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree no=
de,
  *    or for non devicetree enabled platforms a single clock
- *	4) phy (optional)
+ *	4) phys (optional)
  *
  * RETURNS:
  * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
@@ -197,7 +241,8 @@ struct ahci_host_priv *ahci_platform_get_resources(=
struct platform_device *pdev)
 	struct device *dev =3D &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct clk *clk;
-	int i, rc =3D -ENOMEM;
+	struct device_node *child;
+	int i, nports, rc =3D -ENOMEM;
=20
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
 		return ERR_PTR(-ENOMEM);
@@ -246,22 +291,77 @@ struct ahci_host_priv *ahci_platform_get_resource=
s(struct platform_device *pdev)
 		hpriv->clks[i] =3D clk;
 	}
=20
-	hpriv->phy =3D devm_phy_get(dev, "sata-phy");
-	if (IS_ERR(hpriv->phy)) {
-		rc =3D PTR_ERR(hpriv->phy);
-		switch (rc) {
-		case -ENODEV:
-		case -ENOSYS:
-			/* continue normally */
-			hpriv->phy =3D NULL;
-			break;
+	nports =3D of_get_child_count(dev->of_node);
=20
-		case -EPROBE_DEFER:
+	if (nports) {
+		hpriv->phys =3D devm_kzalloc(dev, nports * sizeof(*hpriv->phys),
+					   GFP_KERNEL);
+		if (!hpriv->phys) {
+			rc =3D -ENOMEM;
 			goto err_out;
+		}
=20
-		default:
-			dev_err(dev, "couldn't get sata-phy\n");
-			goto err_out;
+		for_each_child_of_node(dev->of_node, child) {
+			u32 port;
+
+			if (!of_device_is_available(child))
+				continue;
+
+			if (of_property_read_u32(child, "reg", &port)) {
+				rc =3D -EINVAL;
+				goto err_out;
+			}
+
+			hpriv->port_map |=3D BIT(port);
+
+			hpriv->phys[hpriv->nphys] =3D devm_of_phy_get(dev, child,
+								    NULL);
+			if (IS_ERR(hpriv->phys[hpriv->nphys])) {
+				rc =3D PTR_ERR(hpriv->phys[hpriv->nphys]);
+				dev_err(dev,
+					"couldn't get PHY in node %s: %d\n",
+					child->name, rc);
+				goto err_out;
+			}
+
+			hpriv->nphys++;
+		}
+
+		if (!hpriv->nphys) {
+			dev_warn(dev, "No port enabled\n");
+			return ERR_PTR(-ENODEV);
+		}
+	} else {
+		/*
+		 * If no sub-node was found, keep this for device tree
+		 * compatibility
+		 */
+		struct phy *phy =3D devm_phy_get(dev, "sata-phy");
+		if (!IS_ERR(phy)) {
+			hpriv->phys =3D devm_kzalloc(dev, sizeof(*hpriv->phys),
+						   GFP_KERNEL);
+			if (!hpriv->phys) {
+				rc =3D -ENOMEM;
+				goto err_out;
+			}
+
+			hpriv->phys[0] =3D phy;
+			hpriv->nphys =3D 1;
+		} else {
+			rc =3D PTR_ERR(phy);
+			switch (rc) {
+			case -ENODEV:
+			case -ENOSYS:
+				/* continue normally */
+				break;
+
+			case -EPROBE_DEFER:
+				goto err_out;
+
+			default:
+				dev_err(dev, "couldn't get sata-phy\n");
+				goto err_out;
+			}
 		}
 	}
=20
@@ -288,7 +388,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
  * @mask_port_map: param passed to ahci_save_initial_config
  *
  * This function does all the usual steps needed to bring up an
- * ahci-platform host, note any necessary resources (ie clks, phy, etc=
=2E)
+ * ahci-platform host, note any necessary resources (ie clks, phys, et=
c.)
  * must be initialized / enabled before calling this.
  *
  * RETURNS:
@@ -394,7 +494,7 @@ static void ahci_host_stop(struct ata_host *host)
  * @dev: device pointer for the host
  *
  * This function does all the usual steps needed to suspend an
- * ahci-platform host, note any necessary resources (ie clks, phy, etc=
=2E)
+ * ahci-platform host, note any necessary resources (ie clks, phys, et=
c.)
  * must be disabled after calling this.
  *
  * RETURNS:
@@ -431,7 +531,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
  * @dev: device pointer for the host
  *
  * This function does all the usual steps needed to resume an ahci-pla=
tform
- * host, note any necessary resources (ie clks, phy, etc.)  must be
+ * host, note any necessary resources (ie clks, phys, etc.)  must be
  * initialized / enabled before calling this.
  *
  * RETURNS:
--=20
1.9.1
