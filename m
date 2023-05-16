Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC7BC7EE2D
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjEPNHG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjEPNGl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA028687
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A192B639FF
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFA9C433D2;
        Tue, 16 May 2023 13:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242378;
        bh=RoDkVV6jF2Pfy8RdbwUCO9YQIfFu44zxFZIAxWNm0iQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjpeNjIVaNGJXmfr4pMdpk811U1+J6/72ear4fDwuRcItdDeZZcwyXohF0uPIBE9G
         RrMofBoWZYvolfjivbZ7o5OuWTvjubZr7RGvbaVZMuTAnuLgD8O8Hf3vRrZH8DZDua
         bRoxd8nmQDOicA60vSaCvdE/5quzyYDRSnhH30XRifcHRjwLdIo7Ug9w17z8sfe/6i
         KMHwkDLRumYX9+zK5wkTHiBmHe/33kz38IG51G3N5ZahXAx07n90qRAm48Q5eMlpsV
         zv5HPBtZiA6vHrtTlSlskTXkE6oMqcTMcccE4yaj5UdB7G2P7Yy85q0yLJzuhoI1bK
         VcWC3Yx038q/g==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 07/13] ata: pata_parport: Fix fit2 module code indentation and style
Date:   Tue, 16 May 2023 22:06:05 +0900
Message-Id: <20230516130611.109932-8-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the fit2 pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/fit2.c | 131 ++++++++++++++++----------------
 1 file changed, 64 insertions(+), 67 deletions(-)

diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
index fd3b2ce426a5..6524f3033b1e 100644
--- a/drivers/ata/pata_parport/fit2.c
+++ b/drivers/ata/pata_parport/fit2.c
@@ -1,17 +1,16 @@
-/* 
-        fit2.c        (c) 1998  Grant R. Guenther <grant@torque.net>
-                          Under the terms of the GNU General Public License.
-
-	fit2.c is a low-level protocol driver for the older version
-        of the Fidelity International Technology parallel port adapter.  
-	This adapter is used in their TransDisk 2000 and older TransDisk
-	3000 portable hard-drives.  As far as I can tell, this device
-	supports 4-bit mode _only_.  
-
-	Newer models of the FIT products use an enhanced protocol.
-	The "fit3" protocol module should support current drives.
-
-*/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (c) 1998  Grant R. Guenther <grant@torque.net>
+ *
+ * fit2.c is a low-level protocol driver for the older version
+ * of the Fidelity International Technology parallel port adapter.
+ * This adapter is used in their TransDisk 2000 and older TransDisk
+ * 3000 portable hard-drives.  As far as I can tell, this device
+ * supports 4-bit mode _only_.
+ *
+ * Newer models of the FIT products use an enhanced protocol.
+ * The "fit3" protocol module should support current drives.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -22,99 +21,97 @@
 #include <asm/io.h>
 #include "pata_parport.h"
 
-#define j44(a,b)                (((a>>4)&0x0f)|(b&0xf0))
-
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
+#define j44(a, b)	(((a >> 4) & 0x0f) | (b & 0xf0))
 
-NB:  The FIT adapter does not appear to use the control registers.
-So, we map ALT_STATUS to STATUS and NO-OP writes to the device
-control register - this means that IDE reset will not work on these
-devices.
-
-*/
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ *
+ * NB: The FIT adapter does not appear to use the control registers.
+ * So, we map ALT_STATUS to STATUS and NO-OP writes to the device
+ * control register - this means that IDE reset will not work on these
+ * devices.
+ */
 
 static void fit2_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
-
-{	if (cont == 1) return;
+{
+	if (cont == 1)
+		return;
 	w2(0xc); w0(regr); w2(4); w0(val); w2(5); w0(0); w2(4);
 }
 
 static int fit2_read_regr(struct pi_adapter *pi, int cont, int regr)
-
-{	int  a, b, r;
+{
+	int  a, b, r;
 
 	if (cont) {
-	  if (regr != 6) return 0xff;
-	  r = 7;
-	} else r = regr + 0x10;
+		if (regr != 6)
+			return 0xff;
+		r = 7;
+	} else {
+		r = regr + 0x10;
+	}
 
-	w2(0xc); w0(r); w2(4); w2(5); 
-	         w0(0); a = r1();
-	         w0(1); b = r1();
+	w2(0xc); w0(r); w2(4); w2(5);
+	w0(0); a = r1();
+	w0(1); b = r1();
 	w2(4);
 
-	return j44(a,b);
-
+	return j44(a, b);
 }
 
 static void fit2_read_block(struct pi_adapter *pi, char *buf, int count)
-
-{	int  k, a, b, c, d;
+{
+	int  k, a, b, c, d;
 
 	w2(0xc); w0(0x10);
 
-	for (k=0;k<count/4;k++) {
-
+	for (k = 0; k < count / 4; k++) {
 		w2(4); w2(5);
 		w0(0); a = r1(); w0(1); b = r1();
-		w0(3); c = r1(); w0(2); d = r1(); 
-		buf[4*k+0] = j44(a,b);
-		buf[4*k+1] = j44(d,c);
-
-                w2(4); w2(5);
-                       a = r1(); w0(3); b = r1();
-                w0(1); c = r1(); w0(0); d = r1(); 
-                buf[4*k+2] = j44(d,c);
-                buf[4*k+3] = j44(a,b);
+		w0(3); c = r1(); w0(2); d = r1();
+		buf[4 * k + 0] = j44(a, b);
+		buf[4 * k + 1] = j44(d, c);
 
+		w2(4); w2(5);
+		a = r1(); w0(3); b = r1();
+		w0(1); c = r1(); w0(0); d = r1();
+		buf[4 * k + 2] = j44(d, c);
+		buf[4 * k + 3] = j44(a, b);
 	}
 
 	w2(4);
-
 }
 
 static void fit2_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
 
-{	int k;
-
-
-	w2(0xc); w0(0); 
-	for (k=0;k<count/2;k++) {
-		w2(4); w0(buf[2*k]); 
-		w2(5); w0(buf[2*k+1]);
+	w2(0xc); w0(0);
+	for (k = 0; k < count / 2; k++) {
+		w2(4); w0(buf[2 * k]);
+		w2(5); w0(buf[2 * k + 1]);
 	}
 	w2(4);
 }
 
 static void fit2_connect(struct pi_adapter *pi)
-
-{       pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
-	w2(0xcc); 
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(0xcc);
 }
 
 static void fit2_disconnect(struct pi_adapter *pi)
-
-{       w0(pi->saved_r0);
-        w2(pi->saved_r2);
-} 
+{
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
 
 static void fit2_log_adapter(struct pi_adapter *pi)
-
 {
 	dev_info(&pi->dev, "FIT 2000 adapter at 0x%x, delay %d\n",
-		pi->port, pi->delay);
+		 pi->port, pi->delay);
 
 }
 
-- 
2.40.1

