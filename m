From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Subject: [PATCH 1/2] sata_rcar: Adjust and document device tree bindings
Date: Mon, 14 Oct 2013 19:42:33 +0400
Message-ID: <1381765354-28440-2-git-send-email-valentine.barshak@cogentembedded.com>
References: <1381765354-28440-1-git-send-email-valentine.barshak@cogentembedded.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:46415 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756578Ab3JNPmk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Oct 2013 11:42:40 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so5773040lab.2
        for <linux-ide@vger.kernel.org>; Mon, 14 Oct 2013 08:42:38 -0700 (PDT)
In-Reply-To: <1381765354-28440-1-git-send-email-valentine.barshak@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>

This converts the R-Car SATA DT compatibility string to
the <unit>-<soc> format which is the preferred one for
all SH-Mobile devices. The DT bindings are documented.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt | 16 ++++++++++++++++
 arch/arm/boot/dts/r8a7779.dtsi                      |  2 +-
 drivers/ata/sata_rcar.c                             |  2 +-
 3 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
new file mode 100644
index 0000000..2465183
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -0,0 +1,16 @@
+* Renesas R-Car SATA
+
+Required properties:
+- compatible		: must be "renesas,sata-r8a7779"
+- reg			: address range of the SATA registers.
+- interrupt-parent	: interrupt parent controller phandle
+- interrupts		: must consist of one interrupt specifier.
+
+Example:
+
+sata: sata@fc600000 {
+	compatible = "renesas,sata-r8a7779";
+	reg = <0xfc600000 0x2000>;
+	interrupt-parent = <&gic>;
+	interrupts = <0 100 0x4>;
+};
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index da61d27..b1747f5 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -201,7 +201,7 @@
 	};
 
 	sata: sata@fc600000 {
-		compatible = "renesas,rcar-sata";
+		compatible = "renesas,sata-r8a7779";
 		reg = <0xfc600000 0x2000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 100 0x4>;
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index c2d95e9..c4cd738 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -893,7 +893,7 @@ static const struct dev_pm_ops sata_rcar_pm_ops = {
 #endif
 
 static struct of_device_id sata_rcar_match[] = {
-	{ .compatible = "renesas,rcar-sata", },
+	{ .compatible = "renesas,sata-r8a7779", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sata_rcar_match);
-- 
1.8.3.1

