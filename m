From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V3 2/3] ata: pata_arasan: add Device Tree probing capability
Date: Wed, 9 May 2012 09:39:00 +0530
Message-ID: <152161a1a77cf922b618e58671acc11f4398e31b.1336536285.git.viresh.kumar@st.com>
References: <cover.1336536285.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:47744 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282Ab2EIEJ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 May 2012 00:09:26 -0400
In-Reply-To: <cover.1336536285.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com, spear-devel@list.st.com, viresh.linux@gmail.com, Viresh Kumar <viresh.kumar@st.com>

SPEAr platforms now support DT and so must convert all drivers to support DT.
This patch adds DT probing support for Arasan Compact Flash controller and
updates its documentation too.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 .../devicetree/bindings/ata/pata-arasan.txt        |   17 +++++++++++++++++
 drivers/ata/pata_arasan_cf.c                       |   10 ++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/pata-arasan.txt

diff --git a/Documentation/devicetree/bindings/ata/pata-arasan.txt b/Documentation/devicetree/bindings/ata/pata-arasan.txt
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
+	cf@fc000000 {
+		compatible = "arasan,cf-spear1340";
+		reg = <0xfc000000 0x1000>;
+		interrupt-parent = <&vic1>;
+		interrupts = <12>;
+	};
diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index febc914..e455c95 100644
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
 
 static SIMPLE_DEV_PM_OPS(arasan_cf_pm_ops, arasan_cf_suspend, arasan_cf_resume);
 
+#ifdef CONFIG_OF
+static const struct of_device_id arasan_cf_id_table[] = {
+	{ .compatible = "arasan,cf-spear1340" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, arasan_cf_id_table);
+#endif
+
 static struct platform_driver arasan_cf_driver = {
 	.probe		= arasan_cf_probe,
 	.remove		= __devexit_p(arasan_cf_remove),
@@ -942,6 +951,7 @@ static struct platform_driver arasan_cf_driver = {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
 		.pm	= &arasan_cf_pm_ops,
+		.of_match_table = of_match_ptr(arasan_cf_id_table),
 	},
 };
 
-- 
1.7.9

