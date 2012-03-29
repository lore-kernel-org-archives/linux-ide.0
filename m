From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: [PATCH 3/3] ep93xx: Add IDE support to edb93xx boards
Date: Thu, 29 Mar 2012 10:20:15 +0200
Message-ID: <4F741B3F.4000507@metasoft.pl>
References: <4F7418E7.4060500@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:46019 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839Ab2C2IU1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Mar 2012 04:20:27 -0400
In-Reply-To: <4F7418E7.4060500@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, hsweeten@visionengravers.com, ryan@bluewatersys.com, sshtylyov@ru.montavista.com, joao.ramos@inov.pt, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---
 arch/arm/mach-ep93xx/edb93xx.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

Index: linux-2.6/arch/arm/mach-ep93xx/edb93xx.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-ep93xx/edb93xx.c
+++ linux-2.6/arch/arm/mach-ep93xx/edb93xx.c
@@ -233,6 +233,28 @@ static void __init edb93xx_register_fb(v
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
+	return machine_is_edb9315a();
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
@@ -243,6 +265,7 @@ static void __init edb93xx_init_machine(
 	edb93xx_register_i2s();
 	edb93xx_register_pwm();
 	edb93xx_register_fb();
+	edb93xx_register_ide();
 }
 
 
