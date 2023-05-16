Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E57C77B75
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjEPNHG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjEPNGl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E77AA6
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F400639F6
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A4CC433EF;
        Tue, 16 May 2023 13:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242378;
        bh=CROk6LZtCWPg8KSdL6bOjub20Tnwh5kww6LqptI70Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a9x7bQYk6AURF8Tr90h9+JpKbzmnOLGyrSsamiK/5cIstSx9ST/icRKpEyAGuKhhC
         p6K22YNGPwHJesXxKr/B7QzcJ/urRrGQj4NNcuk3Mkq7BNDpJQRFbua6uV8SXNGpmw
         w9hztVXxg8ihk3t84xJNCNq608fw3CttrL1hzGf2zjMcpVuTcwrbYqvQc/mz5uBYcm
         8Scp+1x1lt4BLW63B/mhabasqMvrE2yyNLjSDJ+B5WHEhdsQnLCC4w3Bzi8Kml/jpL
         rkh7/tjQQedDSp6Fn0YIMQTvf1+aOxTqoWyTcyVUv/Y3jKObVBbQdvSPs8qcIwM1vs
         XT8fBqs/pvtTg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 08/13] ata: pata_parport: Fix fit3 module code indentation and style
Date:   Tue, 16 May 2023 22:06:06 +0900
Message-Id: <20230516130611.109932-9-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the fit3 pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/fit3.c | 206 ++++++++++++++++----------------
 1 file changed, 104 insertions(+), 102 deletions(-)

diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index 75df656ac472..c172a38ae67d 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -1,21 +1,20 @@
-/* 
-        fit3.c        (c) 1998  Grant R. Guenther <grant@torque.net>
-                          Under the terms of the GNU General Public License.
-
-	fit3.c is a low-level protocol driver for newer models 
-        of the Fidelity International Technology parallel port adapter.  
-	This adapter is used in their TransDisk 3000 portable 
-	hard-drives, as well as CD-ROM, PD-CD and other devices.
-
-	The TD-2000 and certain older devices use a different protocol.
-	Try the fit2 protocol module with them.
-
-        NB:  The FIT adapters do not appear to support the control 
-	registers.  So, we map ALT_STATUS to STATUS and NO-OP writes 
-	to the device control register - this means that IDE reset 
-	will not work on these devices.
-
-*/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (c) 1998  Grant R. Guenther <grant@torque.net>
+ *
+ * fit3.c is a low-level protocol driver for newer models
+ * of the Fidelity International Technology parallel port adapter.
+ * This adapter is used in their TransDisk 3000 portable
+ * hard-drives, as well as CD-ROM, PD-CD and other devices.
+ *
+ * The TD-2000 and certain older devices use a different protocol.
+ * Try the fit2 protocol module with them.
+ *
+ * NB:  The FIT adapters do not appear to support the control
+ * registers.  So, we map ALT_STATUS to STATUS and NO-OP writes
+ * to the device control register - this means that IDE reset
+ * will not work on these devices.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -26,152 +25,155 @@
 #include <asm/io.h>
 #include "pata_parport.h"
 
-#define j44(a,b)                (((a>>3)&0x0f)|((b<<1)&0xf0))
-
-#define w7(byte)                {out_p(7,byte);}
-#define r7()                    (in_p(7) & 0xff)
+#define j44(a, b)	(((a >> 3) & 0x0f) | ((b << 1) & 0xf0))
 
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
+#define w7(byte)	out_p(7, byte)
+#define r7()		(in_p(7) & 0xff)
 
-*/
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
 
 static void fit3_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
-
-{	if (cont == 1) return;
+{
+	if (cont == 1)
+		return;
 
 	switch (pi->mode) {
-
 	case 0:
-	case 1: w2(0xc); w0(regr); w2(0x8); w2(0xc); 
-		w0(val); w2(0xd); 
+	case 1:
+		w2(0xc); w0(regr); w2(0x8); w2(0xc);
+		w0(val); w2(0xd);
 		w0(0);   w2(0xc);
 		break;
-
-	case 2: w2(0xc); w0(regr); w2(0x8); w2(0xc);
+	case 2:
+		w2(0xc); w0(regr); w2(0x8); w2(0xc);
 		w4(val); w4(0);
 		w2(0xc);
 		break;
-
 	}
 }
 
 static int fit3_read_regr(struct pi_adapter *pi, int cont, int regr)
-
-{	int  a, b;
+{
+	int  a, b;
 
 	if (cont) {
-	  if (regr != 6) return 0xff;
-	  regr = 7;
-	} 
+		if (regr != 6)
+			return 0xff;
+		regr = 7;
+	}
 
 	switch (pi->mode) {
-
-	case 0: w2(0xc); w0(regr + 0x10); w2(0x8); w2(0xc);
+	case 0:
+		w2(0xc); w0(regr + 0x10); w2(0x8); w2(0xc);
 		w2(0xd); a = r1();
-		w2(0xf); b = r1(); 
+		w2(0xf); b = r1();
 		w2(0xc);
-		return j44(a,b);
-
-	case 1: w2(0xc); w0(regr + 0x90); w2(0x8); w2(0xc);
-		w2(0xec); w2(0xee); w2(0xef); a = r0(); 
+		return j44(a, b);
+	case 1:
+		w2(0xc); w0(regr + 0x90); w2(0x8); w2(0xc);
+		w2(0xec); w2(0xee); w2(0xef); a = r0();
 		w2(0xc);
 		return a;
-
-	case 2: w2(0xc); w0(regr + 0x90); w2(0x8); w2(0xc); 
-		w2(0xec); 
-		a = r4(); b = r4(); 
+	case 2:
+		w2(0xc); w0(regr + 0x90); w2(0x8); w2(0xc);
+		w2(0xec);
+		a = r4(); b = r4();
 		w2(0xc);
 		return a;
-
 	}
-	return -1; 
 
+	return -1;
 }
 
 static void fit3_read_block(struct pi_adapter *pi, char *buf, int count)
-
-{	int  k, a, b, c, d;
+{
+	int  k, a, b, c, d;
 
 	switch (pi->mode) {
-
-	case 0: w2(0xc); w0(0x10); w2(0x8); w2(0xc);
-		for (k=0;k<count/2;k++) {
-		    w2(0xd); a = r1();
-		    w2(0xf); b = r1();
-		    w2(0xc); c = r1();
-		    w2(0xe); d = r1();
-		    buf[2*k  ] = j44(a,b);
-		    buf[2*k+1] = j44(c,d);
+	case 0:
+		w2(0xc); w0(0x10); w2(0x8); w2(0xc);
+		for (k = 0; k < count / 2; k++) {
+			w2(0xd); a = r1();
+			w2(0xf); b = r1();
+			w2(0xc); c = r1();
+			w2(0xe); d = r1();
+			buf[2 * k] = j44(a, b);
+			buf[2 * k + 1] = j44(c, d);
 		}
 		w2(0xc);
 		break;
-
-	case 1: w2(0xc); w0(0x90); w2(0x8); w2(0xc); 
+	case 1:
+		w2(0xc); w0(0x90); w2(0x8); w2(0xc);
 		w2(0xec); w2(0xee);
-		for (k=0;k<count/2;k++) {
-		    w2(0xef); a = r0();
-		    w2(0xee); b = r0();
-                    buf[2*k  ] = a;
-                    buf[2*k+1] = b;
+		for (k = 0; k < count / 2; k++) {
+			w2(0xef); a = r0();
+			w2(0xee); b = r0();
+			buf[2 * k] = a;
+			buf[2 * k + 1] = b;
 		}
-		w2(0xec); 
+		w2(0xec);
 		w2(0xc);
 		break;
-
-	case 2: w2(0xc); w0(0x90); w2(0x8); w2(0xc); 
-                w2(0xec);
-		for (k=0;k<count;k++) buf[k] = r4();
-                w2(0xc);
+	case 2:
+		w2(0xc); w0(0x90); w2(0x8); w2(0xc);
+		w2(0xec);
+		for (k = 0; k < count; k++)
+			buf[k] = r4();
+		w2(0xc);
 		break;
-
 	}
 }
 
 static void fit3_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
 
-{	int k;
-
-        switch (pi->mode) {
-
+	switch (pi->mode) {
 	case 0:
-        case 1: w2(0xc); w0(0); w2(0x8); w2(0xc);
-                for (k=0;k<count/2;k++) {
- 		    w0(buf[2*k  ]); w2(0xd);
- 		    w0(buf[2*k+1]); w2(0xc);
+	case 1:
+		w2(0xc); w0(0); w2(0x8); w2(0xc);
+		for (k = 0; k < count / 2; k++) {
+			w0(buf[2 * k]); w2(0xd);
+			w0(buf[2 * k + 1]); w2(0xc);
 		}
 		break;
-
-        case 2: w2(0xc); w0(0); w2(0x8); w2(0xc); 
-                for (k=0;k<count;k++) w4(buf[k]);
-                w2(0xc);
+	case 2:
+		w2(0xc); w0(0); w2(0x8); w2(0xc);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
+		w2(0xc);
 		break;
 	}
 }
 
 static void fit3_connect(struct pi_adapter *pi)
-
-{       pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
 	w2(0xc); w0(0); w2(0xa);
-	if (pi->mode == 2) { 
-		w2(0xc); w0(0x9); w2(0x8); w2(0xc); 
-		}
+	if (pi->mode == 2) {
+		w2(0xc); w0(0x9);
+		w2(0x8); w2(0xc);
+	}
 }
 
 static void fit3_disconnect(struct pi_adapter *pi)
-
-{       w2(0xc); w0(0xa); w2(0x8); w2(0xc);
+{
+	w2(0xc); w0(0xa); w2(0x8); w2(0xc);
 	w0(pi->saved_r0);
-        w2(pi->saved_r2);
-} 
+	w2(pi->saved_r2);
+}
 
 static void fit3_log_adapter(struct pi_adapter *pi)
+{
+	char *mode_string[3] = { "4-bit", "8-bit", "EPP"};
 
-{       char    *mode_string[3] = {"4-bit","8-bit","EPP"};
-
-	dev_info(&pi->dev, "FIT 3000 adapter at 0x%x, mode %d (%s), delay %d\n",
-		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+	dev_info(&pi->dev,
+		 "FIT 3000 adapter at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol fit3 = {
-- 
2.40.1

