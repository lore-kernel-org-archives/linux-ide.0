From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ali14xx: constify __initdata
Date: Thu, 22 Nov 2007 22:59:03 +0100
Message-ID: <200711222259.03836.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:57109 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042AbXKVWHU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 17:07:20 -0500
Received: by ug-out-1314.google.com with SMTP id z38so409664ugc
        for <linux-ide@vger.kernel.org>; Thu, 22 Nov 2007 14:07:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ali14xx.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -53,12 +53,13 @@
 
 /* port addresses for auto-detection */
 #define ALI_NUM_PORTS 4
-static int ports[ALI_NUM_PORTS] __initdata = {0x074, 0x0f4, 0x034, 0x0e4};
+static const int ports[ALI_NUM_PORTS] __initdata =
+	{ 0x074, 0x0f4, 0x034, 0x0e4 };
 
 /* register initialization data */
 typedef struct { u8 reg, data; } RegInitializer;
 
-static RegInitializer initData[] __initdata = {
+static const RegInitializer initData[] __initdata = {
 	{0x01, 0x0f}, {0x02, 0x00}, {0x03, 0x00}, {0x04, 0x00},
 	{0x05, 0x00}, {0x06, 0x00}, {0x07, 0x2b}, {0x0a, 0x0f},
 	{0x25, 0x00}, {0x26, 0x00}, {0x27, 0x00}, {0x28, 0x00},
@@ -177,7 +178,7 @@ static int __init findPort (void)
  * Initialize controller registers with default values.
  */
 static int __init initRegisters (void) {
-	RegInitializer *p;
+	const RegInitializer *p;
 	u8 t;
 	unsigned long flags;
 
