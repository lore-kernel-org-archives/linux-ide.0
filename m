From: Loc Ho <lho@apm.com>
Subject: [PATCH] arm64: Add APM X-Gene SoC SATA host controller DTS entries
Date: Wed, 20 Nov 2013 23:11:38 -0700
Message-ID: <1385014298-15700-5-git-send-email-lho@apm.com>
References: <1385014298-15700-1-git-send-email-lho@apm.com>
 <1385014298-15700-2-git-send-email-lho@apm.com>
 <1385014298-15700-3-git-send-email-lho@apm.com>
 <1385014298-15700-4-git-send-email-lho@apm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:33256 "HELO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752156Ab3KUGMW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Nov 2013 01:12:22 -0500
Received: by mail-pa0-f52.google.com with SMTP id ld10so6543123pab.11
        for <linux-ide@vger.kernel.org>; Wed, 20 Nov 2013 22:12:20 -0800 (PST)
In-Reply-To: <1385014298-15700-4-git-send-email-lho@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, Loc Ho <lho@apm.com>, Tuan Phan <tphan@apm.com>, Suman Tripathi <stripathi@apm.com>

arm64: Add APM X-Gene SoC SATA host controller DTS entries

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 arch/arm64/boot/dts/apm-storm.dtsi |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 359d7b6..592485c 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -193,5 +193,38 @@
 			reg = <0x0 0x17000014 0x0 0x100>;
 			mask = <0x1>;
 		};
+
+		sata0: sata@1a000000 {
+			compatible = "apm,xgene-ahci";
+			reg = <0x0 0x1a000000 0x0 0x100000>,
+			      <0x0 0x1f210000 0x0 0x10000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x86 0x4>;
+			status = "disabled";
+			phys = <&sataphy0>;
+			phy-names = "sataphy1f210000";
+		};
+
+		sata1: sata@1a400000 {
+			compatible = "apm,xgene-ahci";
+			reg = <0x0 0x1a400000 0x0 0x100000>,
+			      <0x0 0x1f220000 0x0 0x10000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x87 0x4>;
+			status = "ok";
+			phys = <&sataphy1>;
+			phy-names = "sataphy1f220000";
+		};
+
+		sata2: sata@1a800000 {
+			compatible = "apm,xgene-ahci";
+			reg = <0x0 0x1a800000 0x0 0x100000>,
+			      <0x0 0x1f230000 0x0 0x10000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x88 0x4>;
+			status = "ok";
+			phys = <&sataphy2>;
+			phy-names = "sataphy1f230000";
+		};
 	};
 };
-- 
1.5.5

