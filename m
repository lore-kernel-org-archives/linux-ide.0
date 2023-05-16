Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D51C77B7A
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjEPNH0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjEPNGy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A2729B
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2358639FB
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B092BC4339B;
        Tue, 16 May 2023 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242380;
        bh=KiHMfsIeE7dL73HVURUEoPKGRhOnbnKhJ/vxupgheAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjvWzJpdRZBNGtqhhPW2RJkS47509qrEpR8uAYw6/xxrhpaJ46YKvO58BHQt0de91
         jhalaXwO6mJm8ijpL6DHKzhxRQfHpLVVyxsGbWccRqenK8Dtu5B1MPyQ2S0gWLtAiw
         dk6jsN+l2vThvVSaRvNEdDQbr3RsmhUKWFRY0+vYL3o5Qv+AJ3DGbeH1iFxk1hbQnn
         8eOEWin82LsAA8VgaWtDwg9XKWh0ZOT1JwXk77HjnVsojOmt5lRM6OwY3Oz3zJYl2S
         azgsK9W80kocyIubKXDTiuPdOeUMuwGMY/MZr3dQqp87dy4aogbvmg70luGp5cRxnU
         Qc7Rns8Iv3obw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 10/13] ata: pata_parport: Fix kbic module code indentation and style
Date:   Tue, 16 May 2023 22:06:08 +0900
Message-Id: <20230516130611.109932-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the kbic pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/kbic.c | 314 ++++++++++++++++----------------
 1 file changed, 162 insertions(+), 152 deletions(-)

diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index 8213e62f8f00..6023e071516d 100644
--- a/drivers/ata/pata_parport/kbic.c
+++ b/drivers/ata/pata_parport/kbic.c
@@ -1,16 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-        kbic.c    (c) 1997-8  Grant R. Guenther <grant@torque.net>
-                              Under the terms of the GNU General Public License.
-
-        This is a low-level driver for the KBIC-951A and KBIC-971A
-        parallel to IDE adapter chips from KingByte Information Systems.
-
-	The chips are almost identical, however, the wakeup code 
-	required for the 971A interferes with the correct operation of
-        the 951A, so this driver registers itself twice, once for
-	each chip.
-
-*/
+ * (c) 1997-1998  Grant R. Guenther <grant@torque.net>
+ *
+ * This is a low-level driver for the KBIC-951A and KBIC-971A
+ * parallel to IDE adapter chips from KingByte Information Systems.
+ *
+ * The chips are almost identical, however, the wakeup code
+ * required for the 971A interferes with the correct operation of
+ * the 951A, so this driver registers itself twice, once for
+ * each chip.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -21,212 +20,223 @@
 #include <asm/io.h>
 #include "pata_parport.h"
 
-#define r12w()			(delay_p,inw(pi->port+1)&0xffff) 
+#define r12w()		(delay_p, inw(pi->port + 1) & 0xffff)
 
-#define j44(a,b)                ((((a>>4)&0x0f)|(b&0xf0))^0x88)
-#define j53(w)                  (((w>>3)&0x1f)|((w>>4)&0xe0))
+#define j44(a, b)	((((a >> 4) & 0x0f) | (b & 0xf0)) ^ 0x88)
+#define j53(w)		(((w >> 3) & 0x1f) | ((w >> 4) & 0xe0))
 
 
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
-*/
-
-static int  cont_map[2] = { 0x80, 0x40 };
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+static int cont_map[2] = { 0x80, 0x40 };
 
 static int kbic_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int a, b, s;
 
-{       int     a, b, s;
-
-        s = cont_map[cont];
+	s = cont_map[cont];
 
 	switch (pi->mode) {
-
-	case 0: w0(regr|0x18|s); w2(4); w2(6); w2(4); w2(1); w0(8);
-	        a = r1(); w0(0x28); b = r1(); w2(4);
-		return j44(a,b);
-
-	case 1: w0(regr|0x38|s); w2(4); w2(6); w2(4); w2(5); w0(8);
+	case 0:
+		w0(regr | 0x18 | s); w2(4); w2(6); w2(4); w2(1); w0(8);
+		a = r1(); w0(0x28); b = r1(); w2(4);
+		return j44(a, b);
+	case 1:
+		w0(regr|0x38 | s); w2(4); w2(6); w2(4); w2(5); w0(8);
 		a = r12w(); w2(4);
 		return j53(a);
-
-	case 2: w0(regr|0x08|s); w2(4); w2(6); w2(4); w2(0xa5); w2(0xa1);
+	case 2:
+		w0(regr | 0x08 | s); w2(4); w2(6); w2(4); w2(0xa5); w2(0xa1);
 		a = r0(); w2(4);
-       		return a;
-
+		return a;
 	case 3:
 	case 4:
-	case 5: w0(0x20|s); w2(4); w2(6); w2(4); w3(regr);
+	case 5:
+		w0(0x20 | s); w2(4); w2(6); w2(4); w3(regr);
 		a = r4(); b = r4(); w2(4); w2(0); w2(4);
 		return a;
-
 	}
+
 	return -1;
-}       
+}
 
 static void kbic_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int s = cont_map[cont];
 
-{       int  s;
-
-        s = cont_map[cont];
-
-        switch (pi->mode) {
-
-	case 0: 
-        case 1:
-	case 2:	w0(regr|0x10|s); w2(4); w2(6); w2(4); 
+	switch (pi->mode) {
+	case 0:
+	case 1:
+	case 2:
+		w0(regr | 0x10 | s); w2(4); w2(6); w2(4);
 		w0(val); w2(5); w2(4);
 		break;
-
 	case 3:
 	case 4:
-	case 5: w0(0x20|s); w2(4); w2(6); w2(4); w3(regr);
+	case 5:
+		w0(0x20 | s); w2(4); w2(6); w2(4); w3(regr);
 		w4(val); w4(val);
 		w2(4); w2(0); w2(4);
-                break;
-
+		break;
 	}
 }
 
 static void k951_connect(struct pi_adapter *pi)
-
-{ 	pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
-        w2(4); 
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(4);
 }
 
 static void k951_disconnect(struct pi_adapter *pi)
-
-{      	w0(pi->saved_r0);
-        w2(pi->saved_r2);
+{
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
 }
 
-#define	CCP(x)	w2(0xc4);w0(0xaa);w0(0x55);w0(0);w0(0xff);w0(0x87);\
-		w0(0x78);w0(x);w2(0xc5);w2(0xc4);w0(0xff);
+#define	CCP(x)						\
+	do {						\
+		w2(0xc4); w0(0xaa); w0(0x55);		\
+		w0(0); w0(0xff); w0(0x87);		\
+		w0(0x78); w0(x); w2(0xc5);		\
+		w2(0xc4); w0(0xff);			\
+	} while (0)
 
 static void k971_connect(struct pi_adapter *pi)
-
-{ 	pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
 	CCP(0x20);
-        w2(4); 
+	w2(4);
 }
 
 static void k971_disconnect(struct pi_adapter *pi)
-
-{       CCP(0x30);
+{
+	CCP(0x30);
 	w0(pi->saved_r0);
-        w2(pi->saved_r2);
+	w2(pi->saved_r2);
 }
 
-/* counts must be congruent to 0 MOD 4, but all known applications
-   have this property.
-*/
-
+/*
+ * count must be congruent to 0 MOD 4, but all known applications
+ *have this property.
+ */
 static void kbic_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k, a, b;
 
-{       int     k, a, b;
-
-        switch (pi->mode) {
-
-        case 0: w0(0x98); w2(4); w2(6); w2(4);
-                for (k=0;k<count/2;k++) {
-			w2(1); w0(8);    a = r1();
-			       w0(0x28); b = r1();
-			buf[2*k]   = j44(a,b);
-			w2(5);           b = r1();
-			       w0(8);    a = r1();
-			buf[2*k+1] = j44(a,b);
+	switch (pi->mode) {
+	case 0:
+		w0(0x98); w2(4); w2(6); w2(4);
+		for (k = 0; k < count / 2; k++) {
+			w2(1); w0(8);
+			a = r1();
+			w0(0x28);
+			b = r1();
+			buf[2 * k] = j44(a, b);
+			w2(5);
+			b = r1();
+			w0(8);
+			a = r1();
+			buf[2 * k + 1] = j44(a, b);
 			w2(4);
-                } 
-                break;
-
-        case 1: w0(0xb8); w2(4); w2(6); w2(4); 
-                for (k=0;k<count/4;k++) {
-                        w0(0xb8); 
-			w2(4); w2(5); 
-                        w0(8);    buf[4*k]   = j53(r12w());
-			w0(0xb8); buf[4*k+1] = j53(r12w());
+		}
+		break;
+	case 1:
+		w0(0xb8); w2(4); w2(6); w2(4);
+		for (k = 0; k < count / 4; k++) {
+			w0(0xb8);
 			w2(4); w2(5);
-			          buf[4*k+3] = j53(r12w());
-			w0(8);    buf[4*k+2] = j53(r12w());
-                }
-                w2(4);
-                break;
-
-        case 2: w0(0x88); w2(4); w2(6); w2(4);
-                for (k=0;k<count/2;k++) {
-                        w2(0xa0); w2(0xa1); buf[2*k] = r0();
-                        w2(0xa5); buf[2*k+1] = r0();
-                }
-                w2(4);
-                break;
-
-        case 3: w0(0xa0); w2(4); w2(6); w2(4); w3(0);
-                for (k=0;k<count;k++) buf[k] = r4();
-                w2(4); w2(0); w2(4);
-                break;
-
-	case 4: w0(0xa0); w2(4); w2(6); w2(4); w3(0);
-                for (k=0;k<count/2;k++) ((u16 *)buf)[k] = r4w();
-                w2(4); w2(0); w2(4);
-                break;
-
-        case 5: w0(0xa0); w2(4); w2(6); w2(4); w3(0);
-                for (k=0;k<count/4;k++) ((u32 *)buf)[k] = r4l();
-                w2(4); w2(0); w2(4);
-                break;
-
-
-        }
+			w0(8);
+			buf[4 * k] = j53(r12w());
+			w0(0xb8);
+			buf[4 * k + 1] = j53(r12w());
+			w2(4); w2(5);
+			buf[4 * k + 3] = j53(r12w());
+			w0(8);
+			buf[4 * k + 2] = j53(r12w());
+		}
+		w2(4);
+		break;
+	case 2:
+		w0(0x88); w2(4); w2(6); w2(4);
+		for (k = 0; k < count / 2; k++) {
+			w2(0xa0); w2(0xa1);
+			buf[2 * k] = r0();
+			w2(0xa5);
+			buf[2 * k + 1] = r0();
+		}
+		w2(4);
+		break;
+	case 3:
+		w0(0xa0); w2(4); w2(6); w2(4); w3(0);
+		for (k = 0; k < count; k++)
+			buf[k] = r4();
+		w2(4); w2(0); w2(4);
+		break;
+	case 4:
+		w0(0xa0); w2(4); w2(6); w2(4); w3(0);
+		for (k = 0; k < count / 2; k++)
+			((u16 *)buf)[k] = r4w();
+		w2(4); w2(0); w2(4);
+		break;
+	case 5:
+		w0(0xa0); w2(4); w2(6); w2(4); w3(0);
+		for (k = 0; k < count / 4; k++)
+			((u32 *)buf)[k] = r4l();
+		w2(4); w2(0); w2(4);
+		break;
+	}
 }
 
 static void kbic_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
 
-{       int     k;
-
-        switch (pi->mode) {
-
-        case 0:
-        case 1:
-        case 2: w0(0x90); w2(4); w2(6); w2(4); 
-		for(k=0;k<count/2;k++) {
-			w0(buf[2*k+1]); w2(0); w2(4); 
-			w0(buf[2*k]);   w2(5); w2(4); 
+	switch (pi->mode) {
+	case 0:
+	case 1:
+	case 2:
+		w0(0x90); w2(4); w2(6); w2(4);
+		for (k = 0; k < count / 2; k++) {
+			w0(buf[2 * k + 1]);
+			w2(0); w2(4);
+			w0(buf[2 * k]);
+			w2(5); w2(4);
 		}
 		break;
-
-        case 3: w0(0xa0); w2(4); w2(6); w2(4); w3(0);
-		for(k=0;k<count/2;k++) {
-			w4(buf[2*k+1]); 
-                        w4(buf[2*k]);
-                }
+	case 3:
+		w0(0xa0); w2(4); w2(6); w2(4); w3(0);
+		for (k = 0; k < count / 2; k++) {
+			w4(buf[2 * k + 1]);
+			w4(buf[2 * k]);
+		}
 		w2(4); w2(0); w2(4);
 		break;
-
-	case 4: w0(0xa0); w2(4); w2(6); w2(4); w3(0);
+	case 4:
+		w0(0xa0); w2(4); w2(6); w2(4); w3(0);
 		for (k = 0; k < count / 2; k++)
 			w4w(swab16(((u16 *)buf)[k]));
-                w2(4); w2(0); w2(4);
-                break;
-
-        case 5: w0(0xa0); w2(4); w2(6); w2(4); w3(0);
+		w2(4); w2(0); w2(4);
+		break;
+	case 5:
+		w0(0xa0); w2(4); w2(6); w2(4); w3(0);
 		for (k = 0; k < count / 4; k++)
 			w4l(swab16(((u16 *)buf)[2 * k]) |
 			    swab16(((u16 *)buf)[2 * k + 1]) << 16);
-                w2(4); w2(0); w2(4);
-                break;
-
-        }
-
+		w2(4); w2(0); w2(4);
+		break;
+	}
 }
 
 static void kbic_log_adapter(struct pi_adapter *pi, char *chip)
-
-{       char    *mode_string[6] = {"4-bit","5/3","8-bit",
-				   "EPP-8","EPP_16","EPP-32"};
+{
+	char *mode[6] = { "4-bit", "5/3", "8-bit", "EPP-8", "EPP_16", "EPP-32"};
 
 	dev_info(&pi->dev, "KingByte %s at 0x%x, mode %d (%s), delay %d\n",
-		 chip, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+		 chip, pi->port, pi->mode, mode[pi->mode], pi->delay);
 }
 
 static void k951_log_adapter(struct pi_adapter *pi)
-- 
2.40.1

