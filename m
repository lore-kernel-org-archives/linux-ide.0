From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH 1/7] S3C64XX: Add physical address definition for Compact Flash controller.
Date: Sun,  1 Nov 2009 13:49:04 +0900
Message-ID: <1257050944-7951-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:53531 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbZKAEwk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Nov 2009 00:52:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

This patch adds the physical address definition and length of address
space for Compact Flash controller (IDE) module.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/mach-s3c6400/include/mach/map.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c6400/include/mach/map.h
index fc8b223..c1f3dd5 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -80,4 +80,8 @@
 #define S3C_PA_USBHOST		S3C64XX_PA_USBHOST
 #define S3C_PA_USB_HSOTG	S3C64XX_PA_USB_HSOTG
 
+/* CF controller */
+#define S3C64XX_PA_CFCON	(0x70300000)
+#define S3C64XX_SZ_CFCON	SZ_1M
+
 #endif /* __ASM_ARCH_6400_MAP_H */
-- 
1.5.3.4

