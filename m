From: Rupjyoti Sarmah <rsarmah@amcc.com>
Subject: [PATCH]Device tree update for the 460ex DWC SATA<resubmission>
Date: Fri, 4 Jun 2010 13:34:58 +0530
Message-ID: <201006040804.o5484wTs005378@amcc.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:55562 "EHLO
	denmail01.apm.COM" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753504Ab0FDIqU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jun 2010 04:46:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rsarmah@appliedmicro.com, sr@denx.de, linuxppc-dev@ozlabs.org


Device tree update for the Applied micro processor 460ex on-chip SATA
Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com>
---
 arch/powerpc/boot/dts/canyonlands.dts |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index cd56bb5..3f86564 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -163,6 +163,14 @@
 			interrupts = <0x1e 4>;
 		};
 
+		SATA0: sata@bffd1000 {
+			compatible = "amcc,sata-460ex";
+			reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
+			interrupt-parent = <&UIC3>;
+			interrupts = <0x0 0x4       /* SATA */
+				      0x5 0x4>;     /* AHBDMA */
+		};
+
 		POB0: opb {
 			compatible = "ibm,opb-460ex", "ibm,opb";
 			#address-cells = <1>;
-- 
1.5.6.3

