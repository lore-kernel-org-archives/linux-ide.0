From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: [PATCH v3 3/3] ep93xx: Add IDE support to edb93xx boards
Date: Thu, 12 Apr 2012 14:15:15 +0200
Message-ID: <4F86C753.3020200@metasoft.pl>
References: <4F86C63C.6030908@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:54390 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757375Ab2DLMP4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Apr 2012 08:15:56 -0400
In-Reply-To: <4F86C63C.6030908@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "bzolnier@gmail.com" <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, hsweeten@visionengravers.com, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "rmallon@gmail.com" <rmallon@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


Add IDE support to edb93xx boards.

Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>

---
 arch/arm/mach-ep93xx/edb93xx.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Index: linux-2.6/arch/arm/mach-ep93xx/edb93xx.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-ep93xx/edb93xx.c
+++ linux-2.6/arch/arm/mach-ep93xx/edb93xx.c
@@ -233,6 +233,29 @@ static void __init edb93xx_register_fb(v
 }
 
 
+/*************************************************************************
+ * EDB93xx IDE
+ *************************************************************************/
+static int __init edb93xx_has_ide(void)
+{
+	/*
+	 * Although EDB9312 and EDB9315 do have IDE capability, they have
+	 * INTRQ line wired as pull-up, which makes using IDE interface
+	 * problematic.
+	 */
+	return machine_is_edb9312() || machine_is_edb9315 ||
+	       machine_is_edb9315a();
+}
+
+static void __init edb93xx_register_ide(void)
+{
+	if (!edb93xx_has_ide())
+		return;
+
+	ep93xx_register_ide();
+}
+
+
 static void __init edb93xx_init_machine(void)
 {
 	ep93xx_init_devices();
@@ -243,6 +266,7 @@ static void __init edb93xx_init_machine(
 	edb93xx_register_i2s();
 	edb93xx_register_pwm();
 	edb93xx_register_fb();
+	edb93xx_register_ide();
 }
 
 

