Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090FAC7EE2D
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjEPNH3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjEPNG4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0857688
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2C09639D9
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4095C433D2;
        Tue, 16 May 2023 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242382;
        bh=fZCXzRxPA0ckYvTh2NUoDsFDWUHp12jg3NwXenGrjQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNIVE53uUI1QDtZvwp9+LeXmg7GdxWhPGojZ4HUPVXXrvXs5EteBxXG8l0NC2gXWX
         3tskLqB7/zyLQ62J0JhY9SugkBbNwcUxSzLNnjzFfaQ3UecqZgTv5866fKULJjmGOy
         0JF1KB7a2KctHnRYxJRIeV0F4PilhfuTMUNtzvuGbLOi/mp6R7StEvA3NQoy3n18o3
         BQ54l/8Lf+PMnWTs2siztiNlKmDuV7Ys4Zm5SZOOvkQca3g2ADAg+OV0DF8oiVhiOI
         jncQVH9LDu7utIFYCDxyGubTB7JGrae6uE+AR8L7+G670ZeCT8Ite0U3/rVU0GPxTp
         JAV2XiIBwwFtA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 13/13] ata: pata_parport: Fix on26 module code indentation and style
Date:   Tue, 16 May 2023 22:06:11 +0900
Message-Id: <20230516130611.109932-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the on26 pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/on26.c | 414 +++++++++++++++++---------------
 1 file changed, 217 insertions(+), 197 deletions(-)

diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
index dc47a54b121f..5da317b394c1 100644
--- a/drivers/ata/pata_parport/on26.c
+++ b/drivers/ata/pata_parport/on26.c
@@ -1,11 +1,10 @@
-/* 
-        on26.c    (c) 1997-8  Grant R. Guenther <grant@torque.net>
-                              Under the terms of the GNU General Public License.
-
-        on26.c is a low-level protocol driver for the 
-        OnSpec 90c26 parallel to IDE adapter chip.
-
-*/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (c) 1997-1998  Grant R. Guenther <grant@torque.net>
+ *
+ * on26.c is a low-level protocol driver for the
+ * OnSpec 90c26 parallel to IDE adapter chip.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -16,260 +15,281 @@
 #include <asm/io.h>
 #include "pata_parport.h"
 
-/* mode codes:  0  nybble reads, 8-bit writes
-                1  8-bit reads and writes
-                2  8-bit EPP mode
-		3  EPP-16
-		4  EPP-32
-*/
+/*
+ * mode codes:  0  nybble reads, 8-bit writes
+ *		1  8-bit reads and writes
+ *		2  8-bit EPP mode
+ *		3  EPP-16
+ *		4  EPP-32
+ */
 
-#define j44(a,b)  (((a>>4)&0x0f)|(b&0xf0))
+#define j44(a, b)	(((a >> 4) & 0x0f) | (b & 0xf0))
 
-#define P1	w2(5);w2(0xd);w2(5);w2(0xd);w2(5);w2(4);
-#define P2	w2(5);w2(7);w2(5);w2(4);
+#define P1						      \
+	do {						      \
+		w2(5); w2(0xd); w2(5); w2(0xd); w2(5); w2(4); \
+	} while (0)
 
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
-*/
-
-static int on26_read_regr(struct pi_adapter *pi, int cont, int regr)
+#define P2					\
+	do {					\
+		w2(5); w2(7); w2(5); w2(4);	\
+	} while (0)
 
-{       int     a, b, r;
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
 
-	r = (regr<<2) + 1 + cont;
+static int on26_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int a, b, r;
 
-        switch (pi->mode)  {
+	r = (regr << 2) + 1 + cont;
 
-        case 0: w0(1); P1; w0(r); P2; w0(0); P1; 
+	switch (pi->mode) {
+	case 0:
+		w0(1); P1; w0(r); P2; w0(0); P1;
 		w2(6); a = r1(); w2(4);
 		w2(6); b = r1(); w2(4);
 		w2(6); w2(4); w2(6); w2(4);
-                return j44(a,b);
-
-        case 1: w0(1); P1; w0(r); P2; w0(0); P1;
+		return j44(a, b);
+	case 1:
+		w0(1); P1; w0(r); P2; w0(0); P1;
 		w2(0x26); a = r0(); w2(4); w2(0x26); w2(4);
-                return a;
-
+		return a;
 	case 2:
 	case 3:
-        case 4: w3(1); w3(1); w2(5); w4(r); w2(4);
+	case 4:
+		w3(1); w3(1); w2(5); w4(r); w2(4);
 		w3(0); w3(0); w2(0x24); a = r4(); w2(4);
 		w2(0x24); (void)r4(); w2(4);
-                return a;
+		return a;
+	}
 
-        }
-        return -1;
-}       
+	return -1;
+}
 
 static void on26_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = (regr << 2) + 1 + cont;
 
-{       int  r;
-
-        r = (regr<<2) + 1 + cont;
-
-        switch (pi->mode)  {
-
-        case 0:
-        case 1: w0(1); P1; w0(r); P2; w0(0); P1;
+	switch (pi->mode) {
+	case 0:
+	case 1:
+		w0(1); P1; w0(r); P2; w0(0); P1;
 		w0(val); P2; w0(val); P2;
 		break;
-
 	case 2:
 	case 3:
-        case 4: w3(1); w3(1); w2(5); w4(r); w2(4);
-		w3(0); w3(0); 
+	case 4:
+		w3(1); w3(1); w2(5); w4(r); w2(4);
+		w3(0); w3(0);
 		w2(5); w4(val); w2(4);
 		w2(5); w4(val); w2(4);
-                break;
-        }
+		break;
+	}
 }
 
-#define  CCP(x)  w0(0xfe);w0(0xaa);w0(0x55);w0(0);w0(0xff);\
-		 w0(0x87);w0(0x78);w0(x);w2(4);w2(5);w2(4);w0(0xff);
+#define CCP(x)						\
+	do {						\
+		w0(0xfe); w0(0xaa); w0(0x55); w0(0);	\
+		w0(0xff); w0(0x87); w0(0x78); w0(x);	\
+		w2(4); w2(5); w2(4); w0(0xff);		\
+	} while (0)
 
 static void on26_connect(struct pi_adapter *pi)
-
-{       int	x;
+{
+	int x;
 
 	pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
+	pi->saved_r2 = r2();
 
-        CCP(0x20);
-	x = 8; if (pi->mode) x = 9;
+	CCP(0x20);
+	if (pi->mode)
+		x = 9;
+	else
+		x = 8;
 
 	w0(2); P1; w0(8); P2;
 	w0(2); P1; w0(x); P2;
 }
 
 static void on26_disconnect(struct pi_adapter *pi)
-
-{       if (pi->mode >= 2) { w3(4); w3(4); w3(4); w3(4); }
-	              else { w0(4); P1; w0(4); P1; }
+{
+	if (pi->mode >= 2) {
+		w3(4); w3(4); w3(4); w3(4);
+	} else {
+		w0(4); P1; w0(4); P1;
+	}
 	CCP(0x30);
-        w0(pi->saved_r0);
-        w2(pi->saved_r2);
-} 
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
 
 #define	RESET_WAIT  200
 
-static int on26_test_port(struct pi_adapter *pi)  /* hard reset */
+/* hard reset */
+static int on26_test_port(struct pi_adapter *pi)
+{
+	int i, m, d, x = 0, y = 0;
 
-{       int     i, m, d, x=0, y=0;
-
-        pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
-
-        d = pi->delay;
-        m = pi->mode;
-        pi->delay = 5;
-        pi->mode = 0;
-
-        w2(0xc);
-
-        CCP(0x30); CCP(0); 
-
-        w0(0xfe);w0(0xaa);w0(0x55);w0(0);w0(0xff);
-        i = ((r1() & 0xf0) << 4); w0(0x87);
-        i |= (r1() & 0xf0); w0(0x78);
-        w0(0x20);w2(4);w2(5);
-        i |= ((r1() & 0xf0) >> 4);
-        w2(4);w0(0xff);
-
-        if (i == 0xb5f) {
-
-            w0(2); P1; w0(0);   P2;
-            w0(3); P1; w0(0);   P2;
-            w0(2); P1; w0(8);   P2; udelay(100);
-            w0(2); P1; w0(0xa); P2; udelay(100);
-            w0(2); P1; w0(8);   P2; udelay(1000);
-            
-            on26_write_regr(pi,0,6,0xa0);
-
-            for (i=0;i<RESET_WAIT;i++) {
-                on26_write_regr(pi,0,6,0xa0);
-                x = on26_read_regr(pi,0,7);
-                on26_write_regr(pi,0,6,0xb0);
-                y = on26_read_regr(pi,0,7);
-                if (!((x&0x80)||(y&0x80))) break;
-                mdelay(100);
-            }
-
-	    if (i == RESET_WAIT) 
-		dev_err(&pi->dev, "on26: Device reset failed (%x,%x)\n", x, y);
-
-            w0(4); P1; w0(4); P1;
-        }
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+
+	d = pi->delay;
+	m = pi->mode;
+	pi->delay = 5;
+	pi->mode = 0;
+
+	w2(0xc);
+
+	CCP(0x30); CCP(0);
+
+	w0(0xfe); w0(0xaa); w0(0x55); w0(0); w0(0xff);
+	i = ((r1() & 0xf0) << 4); w0(0x87);
+	i |= (r1() & 0xf0); w0(0x78);
+	w0(0x20); w2(4); w2(5);
+	i |= ((r1() & 0xf0) >> 4);
+	w2(4); w0(0xff);
+
+	if (i == 0xb5f) {
+		w0(2); P1; w0(0);   P2;
+		w0(3); P1; w0(0);   P2;
+		w0(2); P1; w0(8);   P2; udelay(100);
+		w0(2); P1; w0(0xa); P2; udelay(100);
+		w0(2); P1; w0(8);   P2; udelay(1000);
+
+		on26_write_regr(pi, 0, 6, 0xa0);
+
+		for (i = 0; i < RESET_WAIT; i++) {
+			on26_write_regr(pi, 0, 6, 0xa0);
+			x = on26_read_regr(pi, 0, 7);
+			on26_write_regr(pi, 0, 6, 0xb0);
+			y = on26_read_regr(pi, 0, 7);
+			if (!((x & 0x80) || (y & 0x80)))
+				break;
+			mdelay(100);
+		}
+
+		if (i == RESET_WAIT)
+			dev_err(&pi->dev,
+				"on26: Device reset failed (%x,%x)\n", x, y);
+
+		w0(4); P1; w0(4); P1;
+	}
 
-        CCP(0x30);
+	CCP(0x30);
 
-        pi->delay = d;
-        pi->mode = m;
-        w0(pi->saved_r0);
-        w2(pi->saved_r2);
+	pi->delay = d;
+	pi->mode = m;
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
 
-        return 5;
+	return 5;
 }
 
-
 static void on26_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k, a, b;
 
-{       int     k, a, b;
-
-        switch (pi->mode) {
-
-        case 0: w0(1); P1; w0(1); P2; w0(2); P1; w0(0x18); P2; w0(0); P1;
+	switch (pi->mode) {
+	case 0:
+		w0(1); P1; w0(1); P2; w0(2); P1; w0(0x18); P2; w0(0); P1;
 		udelay(10);
-		for (k=0;k<count;k++) {
-                        w2(6); a = r1();
-                        w2(4); b = r1();
-                        buf[k] = j44(a,b);
-                }
-		w0(2); P1; w0(8); P2; 
-                break;
-
-        case 1: w0(1); P1; w0(1); P2; w0(2); P1; w0(0x19); P2; w0(0); P1;
+		for (k = 0; k < count; k++) {
+			w2(6); a = r1();
+			w2(4); b = r1();
+			buf[k] = j44(a, b);
+		}
+		w0(2); P1; w0(8); P2;
+		break;
+	case 1:
+		w0(1); P1; w0(1); P2; w0(2); P1; w0(0x19); P2; w0(0); P1;
+		udelay(10);
+		for (k = 0; k < count / 2; k++) {
+			w2(0x26); buf[2 * k] = r0();
+			w2(0x24); buf[2 * k + 1] = r0();
+		}
+		w0(2); P1; w0(9); P2;
+		break;
+	case 2:
+		w3(1); w3(1); w2(5); w4(1); w2(4);
+		w3(0); w3(0); w2(0x24);
+		udelay(10);
+		for (k = 0; k < count; k++)
+			buf[k] = r4();
+		w2(4);
+		break;
+	case 3:
+		w3(1); w3(1); w2(5); w4(1); w2(4);
+		w3(0); w3(0); w2(0x24);
 		udelay(10);
-                for (k=0;k<count/2;k++) {
-                        w2(0x26); buf[2*k] = r0();  
-			w2(0x24); buf[2*k+1] = r0();
-                }
-                w0(2); P1; w0(9); P2;
-                break;
-
-        case 2: w3(1); w3(1); w2(5); w4(1); w2(4);
+		for (k = 0; k < count / 2; k++)
+			((u16 *)buf)[k] = r4w();
+		w2(4);
+		break;
+	case 4:
+		w3(1); w3(1); w2(5); w4(1); w2(4);
 		w3(0); w3(0); w2(0x24);
 		udelay(10);
-                for (k=0;k<count;k++) buf[k] = r4();
-                w2(4);
-                break;
-
-        case 3: w3(1); w3(1); w2(5); w4(1); w2(4);
-                w3(0); w3(0); w2(0x24);
-                udelay(10);
-                for (k=0;k<count/2;k++) ((u16 *)buf)[k] = r4w();
-                w2(4);
-                break;
-
-        case 4: w3(1); w3(1); w2(5); w4(1); w2(4);
-                w3(0); w3(0); w2(0x24);
-                udelay(10);
-                for (k=0;k<count/4;k++) ((u32 *)buf)[k] = r4l();
-                w2(4);
-                break;
-
-        }
+		for (k = 0; k < count / 4; k++)
+			((u32 *)buf)[k] = r4l();
+		w2(4);
+		break;
+	}
 }
 
 static void on26_write_block(struct pi_adapter *pi, char *buf, int count)
-
-{       int	k;
-
-        switch (pi->mode) {
-
-        case 0: 
-        case 1: w0(1); P1; w0(1); P2; 
-		w0(2); P1; w0(0x18+pi->mode); P2; w0(0); P1;
+{
+	int k;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+		w0(1); P1; w0(1); P2;
+		w0(2); P1; w0(0x18 + pi->mode); P2; w0(0); P1;
 		udelay(10);
-		for (k=0;k<count/2;k++) {
-                        w2(5); w0(buf[2*k]); 
-			w2(7); w0(buf[2*k+1]);
-                }
-                w2(5); w2(4);
-		w0(2); P1; w0(8+pi->mode); P2;
-                break;
-
-        case 2: w3(1); w3(1); w2(5); w4(1); w2(4);
+		for (k = 0; k < count / 2; k++) {
+			w2(5); w0(buf[2 * k]);
+			w2(7); w0(buf[2 * k + 1]);
+		}
+		w2(5); w2(4);
+		w0(2); P1; w0(8 + pi->mode); P2;
+		break;
+	case 2:
+		w3(1); w3(1); w2(5); w4(1); w2(4);
 		w3(0); w3(0); w2(0xc5);
 		udelay(10);
-                for (k=0;k<count;k++) w4(buf[k]);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
 		w2(0xc4);
-                break;
-
-        case 3: w3(1); w3(1); w2(5); w4(1); w2(4);
-                w3(0); w3(0); w2(0xc5);
-                udelay(10);
-                for (k=0;k<count/2;k++) w4w(((u16 *)buf)[k]);
-                w2(0xc4);
-                break;
-
-        case 4: w3(1); w3(1); w2(5); w4(1); w2(4);
-                w3(0); w3(0); w2(0xc5);
-                udelay(10);
-                for (k=0;k<count/4;k++) w4l(((u32 *)buf)[k]);
-                w2(0xc4);
-                break;
-
-        }
-
+		break;
+	case 3:
+		w3(1); w3(1); w2(5); w4(1); w2(4);
+		w3(0); w3(0); w2(0xc5);
+		udelay(10);
+		for (k = 0; k < count / 2; k++)
+			w4w(((u16 *)buf)[k]);
+		w2(0xc4);
+		break;
+	case 4:
+		w3(1); w3(1); w2(5); w4(1); w2(4);
+		w3(0); w3(0); w2(0xc5);
+		udelay(10);
+		for (k = 0; k < count / 4; k++)
+			w4l(((u32 *)buf)[k]);
+		w2(0xc4);
+		break;
+	}
 }
 
 static void on26_log_adapter(struct pi_adapter *pi)
+{
+	char *mode_string[5] = { "4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
 
-{       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
-				   "EPP-16","EPP-32"};
-
-	dev_info(&pi->dev, "OnSpec 90c26 at 0x%x, mode %d (%s), delay %d\n",
-		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+	dev_info(&pi->dev,
+		 "OnSpec 90c26 at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol on26 = {
-- 
2.40.1

