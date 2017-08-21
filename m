From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 1/9] devicetree: bindings: Add sata port phy config parameters in ahci-ceva
Date: Mon, 21 Aug 2017 13:17:16 +0200
Message-ID: <ad403e69fd5f17255db7d5190993f55ceb72c5a0.1503314240.git.michal.simek@xilinx.com>
References: <cover.1503314240.git.michal.simek@xilinx.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36113 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbdHULRc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Aug 2017 07:17:32 -0400
Received: by mail-wr0-f194.google.com with SMTP id f8so11981519wrf.3
        for <linux-ide@vger.kernel.org>; Mon, 21 Aug 2017 04:17:31 -0700 (PDT)
In-Reply-To: <cover.1503314240.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1503314240.git.michal.simek@xilinx.com>
References: <cover.1503314240.git.michal.simek@xilinx.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>, Tejun Heo <tj@kernel.org>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

This patch adds device tree bindings for sata port phy parameters
in the ahci-ceva.txt file.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- DT fix naming in parameters description use pN instead of phy
  reported by Rob

 .../devicetree/bindings/ata/ahci-ceva.txt          | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
index 7ca8b976c13a..7561cc4de371 100644
--- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
@@ -5,6 +5,36 @@ Required properties:
   - compatible: Compatibility string. Must be 'ceva,ahci-1v84'.
   - clocks: Input clock specifier. Refer to common clock bindings.
   - interrupts: Interrupt specifier. Refer to interrupt binding.
+  - ceva,p0-cominit-params: OOB timing value for COMINIT parameter for port 0.
+  - ceva,p1-cominit-params: OOB timing value for COMINIT parameter for port 1.
+			The fields for the above parameter must be as shown below:
+			ceva,pN-cominit-params = /bits/ 8 <CIBGMN CIBGMX CIBGN CINMP>;
+			CINMP : COMINIT Negate Minimum Period.
+			CIBGN : COMINIT Burst Gap Nominal.
+			CIBGMX: COMINIT Burst Gap Maximum.
+			CIBGMN: COMINIT Burst Gap Minimum.
+  - ceva,p0-comwake-params: OOB timing value for COMWAKE parameter for port 0.
+  - ceva,p1-comwake-params: OOB timing value for COMWAKE parameter for port 1.
+			The fields for the above parameter must be as shown below:
+			ceva,pN-comwake-params = /bits/ 8 <CWBGMN CWBGMX CWBGN CWNMP>;
+			CWBGMN: COMWAKE Burst Gap Minimum.
+			CWBGMX: COMWAKE Burst Gap Maximum.
+			CWBGN: COMWAKE Burst Gap Nominal.
+			CWNMP: COMWAKE Negate Minimum Period.
+  - ceva,p0-burst-params: Burst timing value for COM parameter for port 0.
+  - ceva,p1-burst-params: Burst timing value for COM parameter for port 1.
+			The fields for the above parameter must be as shown below:
+			ceva,pN-burst-params = /bits/ 8 <BMX BNM SFD PTST>;
+			BMX: COM Burst Maximum.
+			BNM: COM Burst Nominal.
+			SFD: Signal Failure Detection value.
+			PTST: Partial to Slumber timer value.
+  - ceva,p0-retry-params: Retry interval timing value for port 0.
+  - ceva,p1-retry-params: Retry interval timing value for port 1.
+			The fields for the above parameter must be as shown below:
+			ceva,pN-retry-params = /bits/ 16 <RIT RCT>;
+			RIT:  Retry Interval Timer.
+			RCT:  Rate Change Timer.
 
 Optional properties:
   - ceva,broken-gen2: limit to gen1 speed instead of gen2.
@@ -16,5 +46,14 @@ Examples:
 		interrupt-parent = <&gic>;
 		interrupts = <0 133 4>;
 		clocks = <&clkc SATA_CLK_ID>;
+		ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
+		ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
+		ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
+		ceva,p0-retry-params = /bits/ 16 <0x0216 0x7F06>;
+
+		ceva,p1-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
+		ceva,p1-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
+		ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
+		ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
 		ceva,broken-gen2;
 	};
-- 
1.9.1

