From: Viresh Kumar <viresh.linux@gmail.com>
Subject: [PATCH V2 3/5] ata: pata_arasan: add Device Tree probing capability
Date: Sat, 21 Apr 2012 17:40:11 +0530
Message-ID: <d56c669fe264f42b5137ec6443881e3fe8e919ae.1335009632.git.viresh.kumar@st.com>
References: <cover.1335009631.git.viresh.kumar@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33246 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab2DUMLw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Apr 2012 08:11:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so2061502pbc.19
        for <linux-ide@vger.kernel.org>; Sat, 21 Apr 2012 05:11:52 -0700 (PDT)
In-Reply-To: <cover.1335009631.git.viresh.kumar@st.com>
In-Reply-To: <cover.1335009631.git.viresh.kumar@st.com>
References: <cover.1335009631.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-ide@vger.kernel.org, sshtylyov@mvista.com, Viresh Kumar <viresh.kumar@st.com>

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
index aa3b4d4..24b6fa8 100644
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
@@ -940,6 +941,14 @@ static int arasan_cf_resume(struct device *dev)
 
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
@@ -947,6 +956,7 @@ static struct platform_driver arasan_cf_driver = {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
 		.pm	= &arasan_cf_pm_ops,
+		.of_match_table = of_match_ptr(arasan_cf_id_table),
 	},
 };
 
-- 
1.7.9

