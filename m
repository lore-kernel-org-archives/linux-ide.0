From: Rupjyoti Sarmah <rsarmah@amcc.com>
Subject: [PATCH]Device tree update for the 460ex DWC SATA
Date: Fri, 28 May 2010 17:45:20 +0530
Message-ID: <201005281215.o4SCFKNi025548@amcc.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sdcmail01.amcc.com ([198.137.200.72]:35694 "EHLO
	sdcmail01.amcc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab0E1MP0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 May 2010 08:15:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rsarmah@appliedmicro.com, sr@denx.de, linuxppc-dev@ozlabs.org

Device tree update for the Applied micro processor 460ex on-chip SATA.

Signed-off-by: Rupjyoti Sarmah <rsarmah@appliedmicro.com>
---
 arch/powerpc/boot/dts/canyonlands.dts |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index cd56bb5..d3b2c99 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -163,6 +163,14 @@
 			interrupts = <0x1e 4>;
 		};
 
+		SATA0: sata@bffd1000 {
+                        compatible = "amcc,sata-460ex";
+			reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
+                        interrupt-parent = <&UIC3>;
+                        interrupts = <0x0 0x4       /* SATA */
+                                      0x5 0x4>;     /* AHBDMA */
+                };
+
 		POB0: opb {
 			compatible = "ibm,opb-460ex", "ibm,opb";
 			#address-cells = <1>;
-- 
1.5.6.3

