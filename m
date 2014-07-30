From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH v13 3/8] ata: libahci_platform: move port_map parameters into the AHCI structure
Date: Wed, 30 Jul 2014 19:04:57 +0200
Message-ID: <1406739902-26311-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1406739902-26311-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406739902-26311-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, tj@kernel.org
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This patch moves force_port_map and mask_port_map into the
ahci_host_priv structure. This allows to modify them into the AHCI
framework. This is needed by the new dt bindings representing ports as
the port_map mask is computed automatically.

Parameters modifying force_port_map, mask_port_map and flags have been
removed from the ahci_platform_init_host() function, and inputs in the
ahci_host_priv structure are now directly filled.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
---
 drivers/ata/ahci.h             | 10 ++++++----
 drivers/ata/ahci_da850.c       |  3 +--
 drivers/ata/ahci_imx.c         |  3 +--
 drivers/ata/ahci_mvebu.c       |  3 +--
 drivers/ata/ahci_platform.c    |  6 ++----
 drivers/ata/ahci_st.c          |  2 +-
 drivers/ata/ahci_sunxi.c       |  8 +++-----
 drivers/ata/ahci_xgene.c       |  6 ++----
 drivers/ata/libahci.c          | 17 +++++++----------
 drivers/ata/libahci_platform.c | 13 +++----------
 include/linux/ahci_platform.h  |  5 +----
 11 files changed, 28 insertions(+), 48 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 2ed84e1c70ea..15396f0330ae 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -316,8 +316,12 @@ struct ahci_port_priv {
 };
=20
 struct ahci_host_priv {
-	void __iomem *		mmio;		/* bus-independent mem map */
+	/* Input fields */
 	unsigned int		flags;		/* AHCI_HFLAG_* */
+	u32			force_port_map;	/* force port map */
+	u32			mask_port_map;	/* mask out particular bits */
+
+	void __iomem *		mmio;		/* bus-independent mem map */
 	u32			cap;		/* cap to use */
 	u32			cap2;		/* cap2 to use */
 	u32			port_map;	/* port map to use */
@@ -361,9 +365,7 @@ unsigned int ahci_dev_classify(struct ata_port *ap)=
;
 void ahci_fill_cmd_slot(struct ahci_port_priv *pp, unsigned int tag,
 			u32 opts);
 void ahci_save_initial_config(struct device *dev,
-			      struct ahci_host_priv *hpriv,
-			      unsigned int force_port_map,
-			      unsigned int mask_port_map);
+			      struct ahci_host_priv *hpriv);
 void ahci_init_controller(struct ata_host *host);
 int ahci_reset_controller(struct ata_host *host);
=20
diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 2b77d53bccf8..ad1e71ec10cf 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -85,8 +85,7 @@ static int ahci_da850_probe(struct platform_device *p=
dev)
=20
 	da850_sata_init(dev, pwrdn_reg, hpriv->mmio);
=20
-	rc =3D ahci_platform_init_host(pdev, hpriv, &ahci_da850_port_info,
-				     0, 0, 0);
+	rc =3D ahci_platform_init_host(pdev, hpriv, &ahci_da850_port_info);
 	if (rc)
 		goto disable_resources;
=20
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 1e5fa5f21aff..f3970b4ed889 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -620,8 +620,7 @@ static int imx_ahci_probe(struct platform_device *p=
dev)
 	reg_val =3D clk_get_rate(imxpriv->ahb_clk) / 1000;
 	writel(reg_val, hpriv->mmio + IMX_TIMER1MS);
=20
-	ret =3D ahci_platform_init_host(pdev, hpriv, &ahci_imx_port_info,
-				      0, 0, 0);
+	ret =3D ahci_platform_init_host(pdev, hpriv, &ahci_imx_port_info);
 	if (ret)
 		goto disable_sata;
=20
diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index fd3dfd733b84..68672d2692ee 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -88,8 +88,7 @@ static int ahci_mvebu_probe(struct platform_device *p=
dev)
 	ahci_mvebu_mbus_config(hpriv, dram);
 	ahci_mvebu_regret_option(hpriv);
=20
-	rc =3D ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info,
-				     0, 0, 0);
+	rc =3D ahci_platform_init_host(pdev, hpriv, &ahci_mvebu_port_info);
 	if (rc)
 		goto disable_resources;
=20
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index b10d81ddb528..fb3eca5cd66c 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -34,7 +34,6 @@ static int ahci_probe(struct platform_device *pdev)
 	struct device *dev =3D &pdev->dev;
 	struct ahci_platform_data *pdata =3D dev_get_platdata(dev);
 	struct ahci_host_priv *hpriv;
-	unsigned long hflags =3D 0;
 	int rc;
=20
 	hpriv =3D ahci_platform_get_resources(pdev);
@@ -58,10 +57,9 @@ static int ahci_probe(struct platform_device *pdev)
 	}
=20
 	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
-		hflags |=3D AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
+		hpriv->flags |=3D AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
=20
-	rc =3D ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
-				     hflags, 0, 0);
+	rc =3D ahci_platform_init_host(pdev, hpriv, &ahci_port_info);
 	if (rc)
 		goto pdata_exit;
=20
diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index 29821b9fd13d..835d6eea84fd 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -166,7 +166,7 @@ static int st_ahci_probe(struct platform_device *pd=
ev)
 	if (err)
 		return err;
=20
-	err =3D ahci_platform_init_host(pdev, hpriv, &st_ahci_port_info, 0, 0=
, 0);
+	err =3D ahci_platform_init_host(pdev, hpriv, &st_ahci_port_info);
 	if (err) {
 		ahci_platform_disable_resources(hpriv);
 		return err;
diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 02002f125bd4..e44d675a30ec 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -167,7 +167,6 @@ static int ahci_sunxi_probe(struct platform_device =
*pdev)
 {
 	struct device *dev =3D &pdev->dev;
 	struct ahci_host_priv *hpriv;
-	unsigned long hflags;
 	int rc;
=20
 	hpriv =3D ahci_platform_get_resources(pdev);
@@ -184,11 +183,10 @@ static int ahci_sunxi_probe(struct platform_devic=
e *pdev)
 	if (rc)
 		goto disable_resources;
=20
-	hflags =3D AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
-		 AHCI_HFLAG_NO_PMP | AHCI_HFLAG_YES_NCQ;
+	hpriv->flags =3D AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
+		       AHCI_HFLAG_NO_PMP | AHCI_HFLAG_YES_NCQ;
=20
-	rc =3D ahci_platform_init_host(pdev, hpriv, &ahci_sunxi_port_info,
-				     hflags, 0, 0);
+	rc =3D ahci_platform_init_host(pdev, hpriv, &ahci_sunxi_port_info);
 	if (rc)
 		goto disable_resources;
=20
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 1cfbdca638d2..bc281115490b 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -422,7 +422,6 @@ static int xgene_ahci_probe(struct platform_device =
*pdev)
 	struct ahci_host_priv *hpriv;
 	struct xgene_ahci_context *ctx;
 	struct resource *res;
-	unsigned long hflags;
 	int rc;
=20
 	hpriv =3D ahci_platform_get_resources(pdev);
@@ -481,10 +480,9 @@ static int xgene_ahci_probe(struct platform_device=
 *pdev)
 	/* Configure the host controller */
 	xgene_ahci_hw_init(hpriv);
=20
-	hflags =3D AHCI_HFLAG_NO_PMP | AHCI_HFLAG_YES_NCQ;
+	hpriv->flags =3D AHCI_HFLAG_NO_PMP | AHCI_HFLAG_YES_NCQ;
=20
-	rc =3D ahci_platform_init_host(pdev, hpriv, &xgene_ahci_port_info,
-				     hflags, 0, 0);
+	rc =3D ahci_platform_init_host(pdev, hpriv, &xgene_ahci_port_info);
 	if (rc)
 		goto disable_resources;
=20
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index d72ce0470309..3c0b623747bd 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -398,10 +398,7 @@ static ssize_t ahci_show_em_supported(struct devic=
e *dev,
  *	LOCKING:
  *	None.
  */
-void ahci_save_initial_config(struct device *dev,
-			      struct ahci_host_priv *hpriv,
-			      unsigned int force_port_map,
-			      unsigned int mask_port_map)
+void ahci_save_initial_config(struct device *dev, struct ahci_host_pri=
v *hpriv)
 {
 	void __iomem *mmio =3D hpriv->mmio;
 	u32 cap, cap2, vers, port_map;
@@ -468,17 +465,17 @@ void ahci_save_initial_config(struct device *dev,
 		cap &=3D ~HOST_CAP_FBS;
 	}
=20
-	if (force_port_map && port_map !=3D force_port_map) {
+	if (hpriv->force_port_map && port_map !=3D hpriv->force_port_map) {
 		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
-			 port_map, force_port_map);
-		port_map =3D force_port_map;
+			 port_map, hpriv->force_port_map);
+		port_map =3D hpriv->force_port_map;
 	}
=20
-	if (mask_port_map) {
+	if (hpriv->mask_port_map) {
 		dev_warn(dev, "masking port_map 0x%x -> 0x%x\n",
 			port_map,
-			port_map & mask_port_map);
-		port_map &=3D mask_port_map;
+			port_map & hpriv->mask_port_map);
+		port_map &=3D hpriv->mask_port_map;
 	}
=20
 	/* cross check port_map and cap.n_ports */
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platf=
orm.c
index 28840a2f470f..00582d3a46a4 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -288,9 +288,6 @@ EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
  * @pdev: platform device pointer for the host
  * @hpriv: ahci-host private data for the host
  * @pi_template: template for the ata_port_info to use
- * @host_flags: ahci host flags used in ahci_host_priv
- * @force_port_map: param passed to ahci_save_initial_config
- * @mask_port_map: param passed to ahci_save_initial_config
  *
  * This function does all the usual steps needed to bring up an
  * ahci-platform host, note any necessary resources (ie clks, phy, etc=
=2E)
@@ -301,10 +298,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
  */
 int ahci_platform_init_host(struct platform_device *pdev,
 			    struct ahci_host_priv *hpriv,
-			    const struct ata_port_info *pi_template,
-			    unsigned long host_flags,
-			    unsigned int force_port_map,
-			    unsigned int mask_port_map)
+			    const struct ata_port_info *pi_template)
 {
 	struct device *dev =3D &pdev->dev;
 	struct ata_port_info pi =3D *pi_template;
@@ -319,10 +313,9 @@ int ahci_platform_init_host(struct platform_device=
 *pdev,
 	}
=20
 	/* prepare host */
-	pi.private_data =3D (void *)host_flags;
-	hpriv->flags |=3D host_flags;
+	pi.private_data =3D (void *)hpriv->flags;
=20
-	ahci_save_initial_config(dev, hpriv, force_port_map, mask_port_map);
+	ahci_save_initial_config(dev, hpriv);
=20
 	if (hpriv->cap & HOST_CAP_NCQ)
 		pi.flags |=3D ATA_FLAG_NCQ;
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platfor=
m.h
index 6dfd51a04d77..09a947e8bc87 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -43,10 +43,7 @@ struct ahci_host_priv *ahci_platform_get_resources(
 	struct platform_device *pdev);
 int ahci_platform_init_host(struct platform_device *pdev,
 			    struct ahci_host_priv *hpriv,
-			    const struct ata_port_info *pi_template,
-			    unsigned long host_flags,
-			    unsigned int force_port_map,
-			    unsigned int mask_port_map);
+			    const struct ata_port_info *pi_template);
=20
 int ahci_platform_suspend_host(struct device *dev);
 int ahci_platform_resume_host(struct device *dev);
--=20
1.9.1
