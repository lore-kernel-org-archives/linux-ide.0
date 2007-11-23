From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce pata node, make use pata_of_platform driver
Date: Fri, 23 Nov 2007 20:53:56 +0300
Message-ID: <20071123175356.GC27338@localhost.localdomain>
References: <20071123175229.GA27143@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:21823 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753374AbXKWRsf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Nov 2007 12:48:35 -0500
Content-Disposition: inline
In-Reply-To: <20071123175229.GA27143@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org


Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts    |    9 +++++++--
 arch/powerpc/platforms/83xx/mpc834x_itx.c |   17 +++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 5072f6d..898c294 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -249,6 +249,11 @@
 		device_type = "pci";
 	};
 
-
-
+	pata@f0000000 {
+		compatible = "fsl,mpc8349emitx", "pata-platform";
+		reg = <f0000000 10 f000020c 4>;
+		ioport-shift = <1>;
+		interrupts = <17 8>;
+		interrupt-parent = <&ipic>;
+	};
 };
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index aa76819..150fafb 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -37,6 +38,22 @@
 
 #include "mpc83xx.h"
 
+static struct of_device_id mpc834x_ids[] = {
+	{ .compatible = "pata-platform", },
+	{},
+};
+
+static int __init mpc834x_declare_of_platform_devices(void)
+{
+	if (!machine_is(mpc834x_itx))
+		return 0;
+
+	of_platform_bus_probe(NULL, mpc834x_ids, NULL);
+
+	return 0;
+}
+device_initcall(mpc834x_declare_of_platform_devices);
+
 /* ************************************************************************
  *
  * Setup the architecture
-- 
1.5.2.2
