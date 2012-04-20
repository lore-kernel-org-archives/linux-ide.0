From: Viresh Kumar <viresh.linux@gmail.com>
Subject: [PATCH 3/5] ata: pata_arasan: add Device Tree probing capability
Date: Fri, 20 Apr 2012 20:08:21 +0530
Message-ID: <eaefebbe69ccad52909365c915e98224aef23aec.1334932338.git.viresh.kumar@st.com>
References: <cover.1334932338.git.viresh.kumar@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48531 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768Ab2DTOjp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2012 10:39:45 -0400
Received: by pbcun15 with SMTP id un15so1138334pbc.19
        for <linux-ide@vger.kernel.org>; Fri, 20 Apr 2012 07:39:44 -0700 (PDT)
In-Reply-To: <cover.1334932338.git.viresh.kumar@st.com>
In-Reply-To: <cover.1334932338.git.viresh.kumar@st.com>
References: <cover.1334932338.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-ide@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>

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
index 492db9c..f583124 100644
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
@@ -947,6 +948,14 @@ static int arasan_cf_resume(struct device *dev)
 
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
@@ -954,6 +963,7 @@ static struct platform_driver arasan_cf_driver = {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
 		.pm	= &arasan_cf_pm_ops,
+		.of_match_table = of_match_ptr(arasan_cf_id_table),
 	},
 };
 
-- 
1.7.9

