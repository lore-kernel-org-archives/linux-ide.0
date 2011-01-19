From: Xulei <B33228@freescale.com>
Subject: [PATCH 2/2] dts: Update sata controller compatible for p1022ds board
Date: Wed, 19 Jan 2011 17:07:30 +0800
Message-ID: <1295428050-21934-2-git-send-email-B33228@freescale.com>
References: <1295428050-21934-1-git-send-email-B33228@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:38764
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753069Ab1ASJGE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jan 2011 04:06:04 -0500
In-Reply-To: <1295428050-21934-1-git-send-email-B33228@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, kumar.gala@freescale.com, Xulei <B33228@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>

Update p1022 sata compatible to "fsl,p1022-sata", "fsl,pq-sata-v2".
p1022ds sata controller is v2 version comparing previous FSL sata
controller, for example, mpc8536.

Signed-off-by: Lei Xu <B33228@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/p1022ds.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 2bbecbb..9ad41dd 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -475,14 +475,14 @@
 		};
 
 		sata@18000 {
-			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
+			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
 			reg = <0x18000 0x1000>;
 			cell-index = <1>;
 			interrupts = <74 0x2>;
 		};
 
 		sata@19000 {
-			compatible = "fsl,mpc8536-sata", "fsl,pq-sata";
+			compatible = "fsl,p1022-sata", "fsl,pq-sata-v2";
 			reg = <0x19000 0x1000>;
 			cell-index = <2>;
 			interrupts = <41 0x2>;
-- 
1.7.0.4


