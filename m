From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 Resend 2/3] ata: pata_arasan: add Device Tree probing capability
Date: Mon, 27 Aug 2012 10:37:18 +0530
Message-ID: <818d0dc1eed7a38361ca96f8e3d9fdc8f7abdf63.1346042344.git.viresh.kumar@linaro.com>
References: <cover.1346042344.git.viresh.kumar@linaro.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33966 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab2H0FH1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Aug 2012 01:07:27 -0400
In-Reply-To: <cover.1346042344.git.viresh.kumar@linaro.com>
In-Reply-To: <cover.1346042344.git.viresh.kumar@linaro.com>
References: <cover.1346042344.git.viresh.kumar@linaro.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com, spear-devel@list.st.com, viresh.linux@gmail.com, Viresh Kumar <viresh.kumar@linaro.com>

From: Viresh Kumar <viresh.kumar@linaro.com>

SPEAr platforms now support DT and so must convert all drivers to support D=
T.
This patch adds DT probing support for Arasan Compact Flash controller and
updates its documentation too.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.com>
---
 Documentation/devicetree/bindings/ata/pata-arasan.txt | 17 +++++++++++++++=
++
 drivers/ata/pata_arasan_cf.c                          | 10 ++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/pata-arasan.txt

diff --git a/Documentation/devicetree/bindings/ata/pata-arasan.txt b/Docume=
ntation/devicetree/bindings/ata/pata-arasan.txt
new file mode 100644
index 0000000..95ec7f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/pata-arasan.txt
@@ -0,0 +1,17 @@
+* ARASAN PATA COMPACT FLASH CONTROLLER
+
+Required properties:
+- compatible: "arasan,cf-spear1340"
+- reg: Address range of the CF registers
+- interrupt-parent: Should be the phandle for the interrupt controller
+  that services interrupts for this device
+- interrupt: Should contain the CF interrupt number
+
+Example:
+
+=09cf@fc000000 {
+=09=09compatible =3D "arasan,cf-spear1340";
+=09=09reg =3D <0xfc000000 0x1000>;
+=09=09interrupt-parent =3D <&vic1>;
+=09=09interrupts =3D <12>;
+=09};
diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index d82c6dc..26201eb 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/libata.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pata_arasan_cf_data.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
@@ -935,6 +936,14 @@ static int arasan_cf_resume(struct device *dev)
=20
 static SIMPLE_DEV_PM_OPS(arasan_cf_pm_ops, arasan_cf_suspend, arasan_cf_re=
sume);
=20
+#ifdef CONFIG_OF
+static const struct of_device_id arasan_cf_id_table[] =3D {
+=09{ .compatible =3D "arasan,cf-spear1340" },
+=09{}
+};
+MODULE_DEVICE_TABLE(of, arasan_cf_id_table);
+#endif
+
 static struct platform_driver arasan_cf_driver =3D {
 =09.probe=09=09=3D arasan_cf_probe,
 =09.remove=09=09=3D __devexit_p(arasan_cf_remove),
@@ -942,6 +951,7 @@ static struct platform_driver arasan_cf_driver =3D {
 =09=09.name=09=3D DRIVER_NAME,
 =09=09.owner=09=3D THIS_MODULE,
 =09=09.pm=09=3D &arasan_cf_pm_ops,
+=09=09.of_match_table =3D of_match_ptr(arasan_cf_id_table),
 =09},
 };
=20
--=20
1.7.12.rc2.18.g61b472e


