Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC7CC7EE2A
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjEPNHF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjEPNGl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8252F83FD
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7CA3639F4
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60F9C4339B;
        Tue, 16 May 2023 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242377;
        bh=wRv/0DMw0qtQY2afxzxBj1cYPhzy7UKWYzqgdSD7TWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MB0iRfkIdwMncgezYX5iojSXbVmIrYEks+RQWAuj4MB4scrX0N+L5g6fnI5dxrgRD
         WkIsCSAd2SlbQQa6FCaJL4wwXelxefQ0MNeJqGazEn8v5xJBwU9rg9dLYBjoTu92fK
         10f/9xoR7l0vf8dNvjWVFcOCtP6GVZoT5fm0rOmRaPlYze17SGPesxj4+p5p1NyKFT
         2EAVeFMDRwSaTdfmjUCmzQiFU52s3lSpHrbOyIBuYgBKIB7u6zYBvCzN3xxrLbU7kp
         kLiJ0GIRrtNofqhrdQ/LeB5mf5+b9lmVpmf+wR8pWnMdaaOXCDcKoZJPYGBKyO7t3U
         X4ZeJ/gtEy/pA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 06/13] ata: pata_parport: Fix epia module code indentation and style
Date:   Tue, 16 May 2023 22:06:04 +0900
Message-Id: <20230516130611.109932-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the epia pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/epia.c | 442 +++++++++++++++++---------------
 1 file changed, 230 insertions(+), 212 deletions(-)

diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index f6db2f79fe99..920e9f40d401 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -1,14 +1,13 @@
-/* 
-        epia.c    (c) 1997-8  Grant R. Guenther <grant@torque.net>
-                              Under the terms of the GNU General Public License.
-
-        epia.c is a low-level protocol driver for Shuttle Technologies 
-	EPIA parallel to IDE adapter chip.  This device is now obsolete
-	and has been replaced with the EPAT chip, which is supported
-	by epat.c, however, some devices based on EPIA are still
-	available.
-
-*/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (c) 1997-1998  Grant R. Guenther <grant@torque.net>
+ *
+ * epia.c is a low-level protocol driver for Shuttle Technologies
+ * EPIA parallel to IDE adapter chip.  This device is now obsolete
+ * and has been replaced with the EPAT chip, which is supported
+ * by epat.c, however, some devices based on EPIA are still
+ * available.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -19,255 +18,274 @@
 #include <asm/io.h>
 #include "pata_parport.h"
 
-/* mode codes:  0  nybble reads on port 1, 8-bit writes
-                1  5/3 reads on ports 1 & 2, 8-bit writes
-                2  8-bit reads and writes
-                3  8-bit EPP mode
-		4  16-bit EPP
-		5  32-bit EPP
-*/
-
-#define j44(a,b)                (((a>>4)&0x0f)+(b&0xf0))
-#define j53(a,b)                (((a>>3)&0x1f)+((b<<4)&0xe0))
-
-/* cont =  0   IDE register file
-   cont =  1   IDE control registers
-*/
-
+/*
+ * mode codes:  0  nybble reads on port 1, 8-bit writes
+ *		1  5/3 reads on ports 1 & 2, 8-bit writes
+ *		2  8-bit reads and writes
+ *		3  8-bit EPP mode
+ *		4  16-bit EPP
+ *		5  32-bit EPP
+ */
+
+#define j44(a, b)	(((a >> 4) & 0x0f) + (b & 0xf0))
+#define j53(a, b)	(((a >> 3) & 0x1f) + ((b << 4) & 0xe0))
+
+/*
+ * cont =  0   IDE register file
+ * cont =  1   IDE control registers
+ */
 static int cont_map[2] = { 0, 0x80 };
 
 static int epia_read_regr(struct pi_adapter *pi, int cont, int regr)
-
-{       int     a, b, r;
+{
+	int a, b, r;
 
 	regr += cont_map[cont];
 
-        switch (pi->mode)  {
-
-        case 0: r = regr^0x39;
-                w0(r); w2(1); w2(3); w0(r);
-                a = r1(); w2(1); b = r1(); w2(4);
-                return j44(a,b);
-
-        case 1: r = regr^0x31;
-                w0(r); w2(1); w0(r&0x37); 
-                w2(3); w2(5); w0(r|0xf0);
-                a = r1(); b = r2(); w2(4);
-                return j53(a,b);
-
-        case 2: r = regr^0x29;
-                w0(r); w2(1); w2(0X21); w2(0x23); 
-                a = r0(); w2(4);
-                return a;
-
+	switch (pi->mode)  {
+	case 0:
+		r = regr ^ 0x39;
+		w0(r); w2(1); w2(3); w0(r);
+		a = r1(); w2(1); b = r1(); w2(4);
+		return j44(a, b);
+	case 1:
+		r = regr ^ 0x31;
+		w0(r); w2(1); w0(r & 0x37);
+		w2(3); w2(5); w0(r | 0xf0);
+		a = r1(); b = r2(); w2(4);
+		return j53(a, b);
+	case 2:
+		r = regr^0x29;
+		w0(r); w2(1); w2(0X21); w2(0x23);
+		a = r0(); w2(4);
+		return a;
 	case 3:
 	case 4:
-        case 5: w3(regr); w2(0x24); a = r4(); w2(4);
-                return a;
+	case 5:
+		w3(regr); w2(0x24); a = r4(); w2(4);
+		return a;
+	}
 
-        }
-        return -1;
-}       
+	return -1;
+}
 
 static void epia_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
-
-{       int  r;
+{
+	int  r;
 
 	regr += cont_map[cont];
 
-        switch (pi->mode)  {
-
-        case 0:
-        case 1:
-        case 2: r = regr^0x19;
-                w0(r); w2(1); w0(val); w2(3); w2(4);
-                break;
-
+	switch (pi->mode)  {
+	case 0:
+	case 1:
+	case 2:
+		r = regr ^ 0x19;
+		w0(r); w2(1); w0(val); w2(3); w2(4);
+		break;
 	case 3:
 	case 4:
-        case 5: r = regr^0x40;
-                w3(r); w4(val); w2(4);
-                break;
-        }
+	case 5:
+		r = regr ^ 0x40;
+		w3(r); w4(val); w2(4);
+		break;
+	}
 }
 
-#define WR(r,v)         epia_write_regr(pi,0,r,v)
-#define RR(r)           (epia_read_regr(pi,0,r))
-
-/* The use of register 0x84 is entirely unclear - it seems to control
-   some EPP counters ...  currently we know about 3 different block
-   sizes:  the standard 512 byte reads and writes, 12 byte writes and 
-   2048 byte reads (the last two being used in the CDrom drivers.
-*/
+#define WR(r, v)	epia_write_regr(pi, 0, r, v)
+#define RR(r)		epia_read_regr(pi, 0, r)
 
+/*
+ * The use of register 0x84 is entirely unclear - it seems to control
+ * some EPP counters ...  currently we know about 3 different block
+ * sizes:  the standard 512 byte reads and writes, 12 byte writes and
+ * 2048 byte reads (the last two being used in the CDrom drivers.
+ */
 static void epia_connect(struct pi_adapter *pi)
-
-{       pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
-
-        w2(4); w0(0xa0); w0(0x50); w0(0xc0); w0(0x30); w0(0xa0); w0(0);
-        w2(1); w2(4);
-        if (pi->mode >= 3) { 
-                w0(0xa); w2(1); w2(4); w0(0x82); w2(4); w2(0xc); w2(4);
-                w2(0x24); w2(0x26); w2(4);
-        }
-        WR(0x86,8);  
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+
+	w2(4); w0(0xa0); w0(0x50); w0(0xc0); w0(0x30); w0(0xa0); w0(0);
+	w2(1); w2(4);
+	if (pi->mode >= 3) {
+		w0(0xa); w2(1); w2(4); w0(0x82); w2(4); w2(0xc); w2(4);
+		w2(0x24); w2(0x26); w2(4);
+	}
+	WR(0x86, 8);
 }
 
 static void epia_disconnect(struct pi_adapter *pi)
-
-{       /* WR(0x84,0x10); */
-        w0(pi->saved_r0);
-        w2(1); w2(4);
-        w0(pi->saved_r0);
-        w2(pi->saved_r2);
-} 
+{
+	/* WR(0x84,0x10); */
+	w0(pi->saved_r0);
+	w2(1); w2(4);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
 
 static void epia_read_block(struct pi_adapter *pi, char *buf, int count)
 
-{       int     k, ph, a, b;
-
-        switch (pi->mode) {
-
-        case 0: w0(0x81); w2(1); w2(3); w0(0xc1);
-                ph = 1;
-                for (k=0;k<count;k++) {
-                        w2(2+ph); a = r1();
-                        w2(4+ph); b = r1();
-                        buf[k] = j44(a,b);
-                        ph = 1 - ph;
-                } 
-                w0(0); w2(4);
-                break;
-
-        case 1: w0(0x91); w2(1); w0(0x10); w2(3); 
-                w0(0x51); w2(5); w0(0xd1); 
-                ph = 1;
-                for (k=0;k<count;k++) {
-                        w2(4+ph);
-                        a = r1(); b = r2();
-                        buf[k] = j53(a,b);
-                        ph = 1 - ph;
-                }
-                w0(0); w2(4);
-                break;
-
-        case 2: w0(0x89); w2(1); w2(0x23); w2(0x21); 
-                ph = 1;
-                for (k=0;k<count;k++) {
-                        w2(0x24+ph);
-                        buf[k] = r0();
-                        ph = 1 - ph;
-                }
-                w2(6); w2(4);
-                break;
-
-        case 3: if (count > 512) WR(0x84,3);
+{
+	int k, ph, a, b;
+
+	switch (pi->mode) {
+	case 0:
+		w0(0x81); w2(1); w2(3); w0(0xc1);
+		ph = 1;
+		for (k = 0; k < count; k++) {
+			w2(2+ph); a = r1();
+			w2(4+ph); b = r1();
+			buf[k] = j44(a, b);
+			ph = 1 - ph;
+		}
+		w0(0); w2(4);
+		break;
+	case 1:
+		w0(0x91); w2(1); w0(0x10); w2(3);
+		w0(0x51); w2(5); w0(0xd1);
+		ph = 1;
+		for (k = 0; k < count; k++) {
+			w2(4 + ph);
+			a = r1(); b = r2();
+			buf[k] = j53(a, b);
+			ph = 1 - ph;
+		}
+		w0(0); w2(4);
+		break;
+	case 2:
+		w0(0x89); w2(1); w2(0x23); w2(0x21);
+		ph = 1;
+		for (k = 0; k < count; k++) {
+			w2(0x24 + ph);
+			buf[k] = r0();
+			ph = 1 - ph;
+		}
+		w2(6); w2(4);
+		break;
+	case 3:
+		if (count > 512)
+			WR(0x84, 3);
 		w3(0); w2(0x24);
-                for (k=0;k<count;k++) buf[k] = r4();
-                w2(4); WR(0x84,0);
-                break;
-
-        case 4: if (count > 512) WR(0x84,3);
+		for (k = 0; k < count; k++)
+			buf[k] = r4();
+		w2(4); WR(0x84, 0);
+		break;
+	case 4:
+		if (count > 512)
+			WR(0x84, 3);
 		w3(0); w2(0x24);
-		for (k=0;k<count/2;k++) ((u16 *)buf)[k] = r4w();
-                w2(4); WR(0x84,0);
-                break;
-
-        case 5: if (count > 512) WR(0x84,3);
+		for (k = 0; k < count / 2; k++)
+			((u16 *)buf)[k] = r4w();
+		w2(4); WR(0x84, 0);
+		break;
+	case 5:
+		if (count > 512)
+			WR(0x84, 3);
 		w3(0); w2(0x24);
-                for (k=0;k<count/4;k++) ((u32 *)buf)[k] = r4l();
-                w2(4); WR(0x84,0);
-                break;
-
-        }
+		for (k = 0; k < count / 4; k++)
+			((u32 *)buf)[k] = r4l();
+		w2(4); WR(0x84, 0);
+		break;
+	}
 }
 
 static void epia_write_block(struct pi_adapter *pi, char *buf, int count)
-
-{       int     ph, k, last, d;
-
-        switch (pi->mode) {
-
-        case 0:
-        case 1:
-        case 2: w0(0xa1); w2(1); w2(3); w2(1); w2(5);
-                ph = 0;  last = 0x8000;
-                for (k=0;k<count;k++) {
-                        d = buf[k];
-                        if (d != last) { last = d; w0(d); }
-                        w2(4+ph);
-                        ph = 1 - ph;
-                }
-                w2(7); w2(4);
-                break;
-
-        case 3: if (count < 512) WR(0x84,1);
+{
+	int ph, k, last, d;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+	case 2:
+		w0(0xa1); w2(1); w2(3); w2(1); w2(5);
+		ph = 0;  last = 0x8000;
+		for (k = 0; k < count; k++) {
+			d = buf[k];
+			if (d != last) {
+				last = d;
+				w0(d);
+			}
+			w2(4 + ph);
+			ph = 1 - ph;
+		}
+		w2(7); w2(4);
+		break;
+	case 3:
+		if (count < 512)
+			WR(0x84, 1);
 		w3(0x40);
-                for (k=0;k<count;k++) w4(buf[k]);
-		if (count < 512) WR(0x84,0);
-                break;
-
-        case 4: if (count < 512) WR(0x84,1);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
+		if (count < 512)
+			WR(0x84, 0);
+		break;
+	case 4:
+		if (count < 512)
+			WR(0x84, 1);
 		w3(0x40);
-                for (k=0;k<count/2;k++) w4w(((u16 *)buf)[k]);
-		if (count < 512) WR(0x84,0);
-                break;
-
-        case 5: if (count < 512) WR(0x84,1);
+		for (k = 0; k < count / 2; k++)
+			w4w(((u16 *)buf)[k]);
+		if (count < 512)
+			WR(0x84, 0);
+		break;
+	case 5:
+		if (count < 512)
+			WR(0x84, 1);
 		w3(0x40);
-                for (k=0;k<count/4;k++) w4l(((u32 *)buf)[k]);
-		if (count < 512) WR(0x84,0);
-                break;
-
-        }
-
+		for (k = 0; k < count / 4; k++)
+			w4l(((u32 *)buf)[k]);
+		if (count < 512)
+			WR(0x84, 0);
+		break;
+	}
 }
 
 static int epia_test_proto(struct pi_adapter *pi)
-
-{       int     j, k, f;
-	int	e[2] = {0,0};
+{
+	int j, k, f;
+	int e[2] = { 0, 0 };
 	char scratch[512];
 
-        epia_connect(pi);
-        for (j=0;j<2;j++) {
-            WR(6,0xa0+j*0x10);
-            for (k=0;k<256;k++) {
-                WR(2,k^0xaa);
-                WR(3,k^0x55);
-                if (RR(2) != (k^0xaa)) e[j]++;
-                }
-	    WR(2,1); WR(3,1);
-            }
-        epia_disconnect(pi);
-
-        f = 0;
-        epia_connect(pi);
-        WR(0x84,8);
-        epia_read_block(pi,scratch,512);
-        for (k=0;k<256;k++) {
-            if ((scratch[2*k] & 0xff) != ((k+1) & 0xff)) f++;
-            if ((scratch[2*k+1] & 0xff) != ((-2-k) & 0xff)) f++;
-        }
-        WR(0x84,0);
-        epia_disconnect(pi);
+	epia_connect(pi);
+	for (j = 0; j < 2; j++) {
+		WR(6, 0xa0 + j * 0x10);
+		for (k = 0; k < 256; k++) {
+			WR(2, k ^ 0xaa);
+			WR(3, k ^ 0x55);
+			if (RR(2) != (k ^ 0xaa))
+				e[j]++;
+		}
+		WR(2, 1); WR(3, 1);
+	}
+	epia_disconnect(pi);
+
+	f = 0;
+	epia_connect(pi);
+	WR(0x84, 8);
+	epia_read_block(pi, scratch, 512);
+	for (k = 0; k < 256; k++) {
+		if ((scratch[2 * k] & 0xff) != ((k + 1) & 0xff))
+			f++;
+		if ((scratch[2 * k + 1] & 0xff) != ((-2 - k) & 0xff))
+			f++;
+	}
+	WR(0x84, 0);
+	epia_disconnect(pi);
 
 	dev_dbg(&pi->dev, "epia: port 0x%x, mode %d, test=(%d,%d,%d)\n",
-	       pi->port, pi->mode, e[0], e[1], f);
-        
-        return (e[0] && e[1]) || f;
+		pi->port, pi->mode, e[0], e[1], f);
 
+	return (e[0] && e[1]) || f;
 }
 
 
 static void epia_log_adapter(struct pi_adapter *pi)
+{
+	char *mode[6] = { "4-bit", "5/3", "8-bit", "EPP-8", "EPP-16", "EPP-32"};
 
-{       char    *mode_string[6] = {"4-bit","5/3","8-bit",
-				   "EPP-8","EPP-16","EPP-32"};
-
-	dev_info(&pi->dev, "Shuttle EPIA at 0x%x, mode %d (%s), delay %d\n",
-		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+	dev_info(&pi->dev,
+		 "Shuttle EPIA at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode[pi->mode], pi->delay);
 }
 
 static struct pi_protocol epia = {
-- 
2.40.1

