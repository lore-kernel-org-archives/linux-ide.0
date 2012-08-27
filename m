From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 Resend 3/3] ata/ahci_platform: Add clock framework support
Date: Mon, 27 Aug 2012 10:37:19 +0530
Message-ID: <26ddcaf1af37a0a40227d073e66e14e0cdb14769.1346042344.git.viresh.kumar@linaro.com>
References: <cover.1346042344.git.viresh.kumar@linaro.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33989 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab2H0FHa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Aug 2012 01:07:30 -0400
In-Reply-To: <cover.1346042344.git.viresh.kumar@linaro.com>
In-Reply-To: <cover.1346042344.git.viresh.kumar@linaro.com>
References: <cover.1346042344.git.viresh.kumar@linaro.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com, spear-devel@list.st.com, viresh.linux@gmail.com, Viresh Kumar <viresh.kumar@linaro.com>

From: Viresh Kumar <viresh.kumar@linaro.com>

On many architectures, drivers are supposed to prepare/unprepare &
enable/disable functional clock of device. This patch adds clock support fo=
r
ahci_platform.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.com>
---
 drivers/ata/ahci.h          |  2 ++
 drivers/ata/ahci_platform.c | 57 +++++++++++++++++++++++++++++++++++++++--=
----
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 57eb1c2..838a262 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -35,6 +35,7 @@
 #ifndef _AHCI_H
 #define _AHCI_H
=20
+#include <linux/clk.h>
 #include <linux/libata.h>
=20
 /* Enclosure Management Control */
@@ -302,6 +303,7 @@ struct ahci_host_priv {
 =09u32 =09=09=09em_loc; /* enclosure management location */
 =09u32=09=09=09em_buf_sz;=09/* EM buffer size in byte */
 =09u32=09=09=09em_msg_type;=09/* EM message type */
+=09struct clk=09=09*clk;=09=09/* Only for platforms supporting clk */
 };
=20
 extern int ahci_ignore_sss;
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 09728e0..90c2eb9 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -12,6 +12,7 @@
  * any later version.
  */
=20
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
@@ -118,6 +119,17 @@ static int __init ahci_probe(struct platform_device *p=
dev)
 =09=09return -ENOMEM;
 =09}
=20
+=09hpriv->clk =3D clk_get(dev, NULL);
+=09if (IS_ERR(hpriv->clk)) {
+=09=09dev_err(dev, "can't get clock\n");
+=09} else {
+=09=09rc =3D clk_prepare_enable(hpriv->clk);
+=09=09if (rc) {
+=09=09=09dev_err(dev, "clock prepare enable failed");
+=09=09=09goto free_clk;
+=09=09}
+=09}
+
 =09/*
 =09 * Some platforms might need to prepare for mmio region access,
 =09 * which could be done in the following init call. So, the mmio
@@ -127,7 +139,7 @@ static int __init ahci_probe(struct platform_device *pd=
ev)
 =09if (pdata && pdata->init) {
 =09=09rc =3D pdata->init(dev, hpriv->mmio);
 =09=09if (rc)
-=09=09=09return rc;
+=09=09=09goto disable_unprepare_clk;
 =09}
=20
 =09ahci_save_initial_config(dev, hpriv,
@@ -153,7 +165,7 @@ static int __init ahci_probe(struct platform_device *pd=
ev)
 =09host =3D ata_host_alloc_pinfo(dev, ppi, n_ports);
 =09if (!host) {
 =09=09rc =3D -ENOMEM;
-=09=09goto err0;
+=09=09goto pdata_exit;
 =09}
=20
 =09host->private_data =3D hpriv;
@@ -183,7 +195,7 @@ static int __init ahci_probe(struct platform_device *pd=
ev)
=20
 =09rc =3D ahci_reset_controller(host);
 =09if (rc)
-=09=09goto err0;
+=09=09goto pdata_exit;
=20
 =09ahci_init_controller(host);
 =09ahci_print_info(host, "platform");
@@ -191,12 +203,18 @@ static int __init ahci_probe(struct platform_device *=
pdev)
 =09rc =3D ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
 =09=09=09       &ahci_platform_sht);
 =09if (rc)
-=09=09goto err0;
+=09=09goto pdata_exit;
=20
 =09return 0;
-err0:
+pdata_exit:
 =09if (pdata && pdata->exit)
 =09=09pdata->exit(dev);
+disable_unprepare_clk:
+=09if (!IS_ERR(hpriv->clk))
+=09=09clk_disable_unprepare(hpriv->clk);
+free_clk:
+=09if (!IS_ERR(hpriv->clk))
+=09=09clk_put(hpriv->clk);
 =09return rc;
 }
=20
@@ -205,12 +223,18 @@ static int __devexit ahci_remove(struct platform_devi=
ce *pdev)
 =09struct device *dev =3D &pdev->dev;
 =09struct ahci_platform_data *pdata =3D dev_get_platdata(dev);
 =09struct ata_host *host =3D dev_get_drvdata(dev);
+=09struct ahci_host_priv *hpriv =3D host->private_data;
=20
 =09ata_host_detach(host);
=20
 =09if (pdata && pdata->exit)
 =09=09pdata->exit(dev);
=20
+=09if (!IS_ERR(hpriv->clk)) {
+=09=09clk_disable_unprepare(hpriv->clk);
+=09=09clk_put(hpriv->clk);
+=09}
+
 =09return 0;
 }
=20
@@ -245,6 +269,10 @@ static int ahci_suspend(struct device *dev)
=20
 =09if (pdata && pdata->suspend)
 =09=09return pdata->suspend(dev);
+
+=09if (!IS_ERR(hpriv->clk))
+=09=09clk_disable_unprepare(hpriv->clk);
+
 =09return 0;
 }
=20
@@ -252,18 +280,27 @@ static int ahci_resume(struct device *dev)
 {
 =09struct ahci_platform_data *pdata =3D dev_get_platdata(dev);
 =09struct ata_host *host =3D dev_get_drvdata(dev);
+=09struct ahci_host_priv *hpriv =3D host->private_data;
 =09int rc;
=20
+=09if (!IS_ERR(hpriv->clk)) {
+=09=09rc =3D clk_prepare_enable(hpriv->clk);
+=09=09if (rc) {
+=09=09=09dev_err(dev, "clock prepare enable failed");
+=09=09=09return rc;
+=09=09}
+=09}
+
 =09if (pdata && pdata->resume) {
 =09=09rc =3D pdata->resume(dev);
 =09=09if (rc)
-=09=09=09return rc;
+=09=09=09goto disable_unprepare_clk;
 =09}
=20
 =09if (dev->power.power_state.event =3D=3D PM_EVENT_SUSPEND) {
 =09=09rc =3D ahci_reset_controller(host);
 =09=09if (rc)
-=09=09=09return rc;
+=09=09=09goto disable_unprepare_clk;
=20
 =09=09ahci_init_controller(host);
 =09}
@@ -271,6 +308,12 @@ static int ahci_resume(struct device *dev)
 =09ata_host_resume(host);
=20
 =09return 0;
+
+disable_unprepare_clk:
+=09if (!IS_ERR(hpriv->clk))
+=09=09clk_disable_unprepare(hpriv->clk);
+
+=09return rc;
 }
 #endif
=20
--=20
1.7.12.rc2.18.g61b472e


