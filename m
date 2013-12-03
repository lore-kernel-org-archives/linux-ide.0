From: Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH] ARM: dts: imx53: Enable AHCI SATA for imx53-qsb
Date: Tue,  3 Dec 2013 08:39:38 -0600
Message-ID: <1386081578-3651-1-git-send-email-robertcnelson@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34749 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab3LCOjp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Dec 2013 09:39:45 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so23483221iec.5
        for <linux-ide@vger.kernel.org>; Tue, 03 Dec 2013 06:39:44 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Linux-IDE <linux-ide@vger.kernel.org>
---
 arch/arm/boot/dts/imx53-qsb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 91a5935..ea927be 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -307,6 +307,10 @@
 	status = "okay";
 };
 
+&sata {
+	status = "okay";
+};
+
 &vpu {
 	status = "okay";
 };
-- 
1.8.4.3

