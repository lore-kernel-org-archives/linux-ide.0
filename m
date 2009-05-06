From: Feng Kan <fkan@amcc.com>
Subject: [PATCH 3/3 v3] Add 4xx SATA dts node documentation
Date: Wed,  6 May 2009 10:49:46 -0700
Message-ID: <1241632186-2613-1-git-send-email-fkan@amcc.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sdcmail01.amcc.com ([198.137.200.72]:12900 "EHLO
	sdcmail01.amcc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbZEFRt7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 May 2009 13:49:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Cc: Feng Kan <fkan@amcc.com>

Signed-off-by: Feng Kan <fkan@amcc.com>
---
 Documentation/powerpc/dts-bindings/4xx/sata.txt |   24 +++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/4xx/sata.txt

diff --git a/Documentation/powerpc/dts-bindings/4xx/sata.txt b/Documentation/powerpc/dts-bindings/4xx/sata.txt
new file mode 100644
index 0000000..3ce00d0
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/4xx/sata.txt
@@ -0,0 +1,24 @@
+AMCC SoC SATA Support 
+
+This following is only for the 460ex support for Designware SATA core
+
+Required properties:
+- compatible : "amcc,sata-460ex".
+- reg : the first set defines SATA controller register, the second set
+        is for the AHB DMA controller for SATA.
+- interrupt-parent: UIC3
+- interrupts: one for SATA and one for the DMA
+
+Notes:
+The SATA is only available when the first PCIe port is disabled.
+
+Example:
+
+SATA0: sata@bffd1000 {
+	compatible = "amcc,sata-460ex";
+        reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
+	interrupt-parent = <&UIC3>;
+	interrupts = <0 4       /* SATA */
+		      5 4>;     /* AHBDMA */
+};
+
-- 
1.5.5

