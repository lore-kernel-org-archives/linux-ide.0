Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA13C77B7A
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjEPNHE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjEPNGj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B146186AC
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 418E4639F1
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7C7C433EF;
        Tue, 16 May 2023 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242376;
        bh=+em/KQN9oSeOtCRgS82I9ubyj53zauA7FxF3KOwZDfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UT7F5cCBtQ0itE2j+6X8/T0qvyoutgYwcioN9hGyqJgspFEhoqCxmZZ65Z6+GYGhE
         WlBWp6huQnnf1whE4oFJcWrJ35oG6DphZOgjLsDpTgtLn+ETJVE3Q46EZu42rtImRG
         AxYQjdZ16vMmIoQX/9Nz2fkKadiPcxR2KLnAn7XiyofixNVitkFVqqJkAp4EGryoPv
         XldTYUCF4Mnm+ByUJpVorPdsEfSVgUdnQ+2JhHMypvfCIEiK0LNYk3QuYYDveshP52
         3rmJZNLpB+QrLTVFEELXgD37WULn7JrIow4ot3GgaEMzV8lRLDRqXnNLOBMDNnGCAQ
         5ufE6sn8HJRsA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 05/13] ata: pata_parport: Fix epat module code indentation and style
Date:   Tue, 16 May 2023 22:06:03 +0900
Message-Id: <20230516130611.109932-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the epat pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/epat.c | 320 ++++++++++++++++++--------------
 1 file changed, 178 insertions(+), 142 deletions(-)

diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index b146999368ae..016bd96bce89 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -1,13 +1,12 @@
-/* 
-        epat.c  (c) 1997-8  Grant R. Guenther <grant@torque.net>
-                            Under the terms of the GNU General Public License.
-
-	This is the low level protocol driver for the EPAT parallel
-        to IDE adapter from Shuttle Technologies.  This adapter is
-        used in many popular parallel port disk products such as the
-        SyQuest EZ drives, the Avatar Shark and the Imation SuperDisk.
-	
-*/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (c) 1997-1998  Grant R. Guenther <grant@torque.net>
+ *
+ * This is the low level protocol driver for the EPAT parallel
+ * to IDE adapter from Shuttle Technologies.  This adapter is
+ * used in many popular parallel port disk products such as the
+ * SyQuest EZ drives, the Avatar Shark and the Imation SuperDisk.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -18,276 +17,313 @@
 #include <asm/io.h>
 #include "pata_parport.h"
 
-#define j44(a,b)		(((a>>4)&0x0f)+(b&0xf0))
-#define j53(a,b)		(((a>>3)&0x1f)+((b<<4)&0xe0))
+#define j44(a, b)	(((a >> 4) & 0x0f) + (b & 0xf0))
+#define j53(a, b)	(((a >> 3) & 0x1f) + ((b << 4) & 0xe0))
 
 static int epatc8;
 
 module_param(epatc8, int, 0);
-MODULE_PARM_DESC(epatc8, "support for the Shuttle EP1284 chip, "
-	"used in any recent Imation SuperDisk (LS-120) drive.");
-
-/* cont =  0   IDE register file
-   cont =  1   IDE control registers
-   cont =  2   internal EPAT registers
-*/
-
+MODULE_PARM_DESC(epatc8,
+		 "support for the Shuttle EP1284 chip, "
+		 "used in any recent Imation SuperDisk (LS-120) drive.");
+
+/*
+ * cont =  0   IDE register file
+ * cont =  1   IDE control registers
+ * cont =  2   internal EPAT registers
+ */
 static int cont_map[3] = { 0x18, 0x10, 0 };
 
 static void epat_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
-
-{	int r;
-
-	r = regr + cont_map[cont];
+{
+	int r = regr + cont_map[cont];
 
 	switch (pi->mode) {
-
 	case 0:
 	case 1:
-	case 2:	w0(0x60+r); w2(1); w0(val); w2(4);
+	case 2:
+		w0(0x60+r); w2(1); w0(val); w2(4);
 		break;
-
 	case 3:
 	case 4:
-	case 5: w3(0x40+r); w4(val);
+	case 5:
+		w3(0x40+r); w4(val);
 		break;
-
 	}
 }
 
 static int epat_read_regr(struct pi_adapter *pi, int cont, int regr)
-
-{	int  a, b, r;
+{
+	int  a, b, r;
 
 	r = regr + cont_map[cont];
 
 	switch (pi->mode) {
 
-	case 0:	w0(r); w2(1); w2(3); 
+	case 0:
+		w0(r); w2(1); w2(3);
 		a = r1(); w2(4); b = r1();
-		return j44(a,b);
-
-	case 1: w0(0x40+r); w2(1); w2(4);
+		return j44(a, b);
+	case 1:
+		w0(0x40+r); w2(1); w2(4);
 		a = r1(); b = r2(); w0(0xff);
-		return j53(a,b);
-
-	case 2: w0(0x20+r); w2(1); w2(0x25);
+		return j53(a, b);
+	case 2:
+		w0(0x20+r); w2(1); w2(0x25);
 		a = r0(); w2(4);
 		return a;
-
 	case 3:
 	case 4:
-	case 5: w3(r); w2(0x24); a = r4(); w2(4);
+	case 5:
+		w3(r); w2(0x24); a = r4(); w2(4);
 		return a;
-
 	}
+
 	return -1;	/* never gets here */
 }
 
 static void epat_read_block(struct pi_adapter *pi, char *buf, int count)
-
-{	int  k, ph, a, b;
+{
+	int  k, ph, a, b;
 
 	switch (pi->mode) {
 
-	case 0:	w0(7); w2(1); w2(3); w0(0xff);
+	case 0:
+		w0(7); w2(1); w2(3); w0(0xff);
 		ph = 0;
-		for(k=0;k<count;k++) {
-			if (k == count-1) w0(0xfd);
-			w2(6+ph); a = r1();
-			if (a & 8) b = a; 
-			  else { w2(4+ph); b = r1(); }
-			buf[k] = j44(a,b);
+		for (k = 0; k < count; k++) {
+			if (k == count-1)
+				w0(0xfd);
+			w2(6 + ph); a = r1();
+			if (a & 8) {
+				b = a;
+			} else {
+				w2(4+ph); b = r1();
+			}
+			buf[k] = j44(a, b);
 			ph =  1 - ph;
 		}
 		w0(0); w2(4);
 		break;
 
-	case 1: w0(0x47); w2(1); w2(5); w0(0xff);
+	case 1:
+		w0(0x47); w2(1); w2(5); w0(0xff);
 		ph = 0;
-		for(k=0;k<count;k++) {
-			if (k == count-1) w0(0xfd); 
-			w2(4+ph);
+		for (k = 0; k < count; k++) {
+			if (k == count - 1)
+				w0(0xfd);
+			w2(4 + ph);
 			a = r1(); b = r2();
-			buf[k] = j53(a,b);
+			buf[k] = j53(a, b);
 			ph = 1 - ph;
 		}
 		w0(0); w2(4);
 		break;
 
-	case 2: w0(0x27); w2(1); w2(0x25); w0(0);
+	case 2:
+		w0(0x27); w2(1); w2(0x25); w0(0);
 		ph = 0;
-		for(k=0;k<count-1;k++) {
-			w2(0x24+ph);
+		for (k = 0; k < count - 1; k++) {
+			w2(0x24 + ph);
 			buf[k] = r0();
 			ph = 1 - ph;
 		}
-		w2(0x26); w2(0x27); buf[count-1] = r0(); 
+		w2(0x26); w2(0x27);
+		buf[count - 1] = r0();
 		w2(0x25); w2(4);
 		break;
 
-	case 3: w3(0x80); w2(0x24);
-		for(k=0;k<count-1;k++) buf[k] = r4();
-		w2(4); w3(0xa0); w2(0x24); buf[count-1] = r4();
+	case 3:
+		w3(0x80); w2(0x24);
+		for (k = 0; k < count - 1; k++)
+			buf[k] = r4();
+		w2(4); w3(0xa0); w2(0x24);
+		buf[count - 1] = r4();
 		w2(4);
 		break;
 
-	case 4: w3(0x80); w2(0x24);
-		for(k=0;k<(count/2)-1;k++) ((u16 *)buf)[k] = r4w();
-		buf[count-2] = r4();
-		w2(4); w3(0xa0); w2(0x24); buf[count-1] = r4();
+	case 4:
+		w3(0x80); w2(0x24);
+		for (k = 0; k < count / 2 - 1; k++)
+			((u16 *)buf)[k] = r4w();
+		buf[count - 2] = r4();
+		w2(4); w3(0xa0); w2(0x24);
+		buf[count - 1] = r4();
 		w2(4);
 		break;
 
-	case 5: w3(0x80); w2(0x24);
-		for(k=0;k<(count/4)-1;k++) ((u32 *)buf)[k] = r4l();
-		for(k=count-4;k<count-1;k++) buf[k] = r4();
-		w2(4); w3(0xa0); w2(0x24); buf[count-1] = r4();
+	case 5:
+		w3(0x80); w2(0x24);
+		for (k = 0; k < count / 4 - 1; k++)
+			((u32 *)buf)[k] = r4l();
+		for (k = count - 4; k < count - 1; k++)
+			buf[k] = r4();
+		w2(4); w3(0xa0); w2(0x24);
+		buf[count - 1] = r4();
 		w2(4);
 		break;
-
 	}
 }
 
 static void epat_write_block(struct pi_adapter *pi, char *buf, int count)
-
-{	int ph, k;
+{
+	int ph, k;
 
 	switch (pi->mode) {
-
 	case 0:
 	case 1:
-	case 2: w0(0x67); w2(1); w2(5);
+	case 2:
+		w0(0x67); w2(1); w2(5);
 		ph = 0;
-		for(k=0;k<count;k++) {
+		for (k = 0; k < count; k++) {
 		  	w0(buf[k]);
-			w2(4+ph);
+			w2(4 + ph);
 			ph = 1 - ph;
 		}
 		w2(7); w2(4);
 		break;
-
-	case 3: w3(0xc0); 
-		for(k=0;k<count;k++) w4(buf[k]);
+	case 3:
+		w3(0xc0);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
 		w2(4);
 		break;
-
-	case 4: w3(0xc0); 
-		for(k=0;k<(count/2);k++) w4w(((u16 *)buf)[k]);
+	case 4:
+		w3(0xc0);
+		for (k = 0; k < count / 2; k++)
+			w4w(((u16 *)buf)[k]);
 		w2(4);
 		break;
-
-	case 5: w3(0xc0); 
-		for(k=0;k<(count/4);k++) w4l(((u32 *)buf)[k]);
+	case 5:
+		w3(0xc0);
+		for (k = 0; k < count / 4; k++)
+			w4l(((u32 *)buf)[k]);
 		w2(4);
 		break;
-
 	}
 }
 
 /* these macros access the EPAT registers in native addressing */
 
-#define	WR(r,v)		epat_write_regr(pi,2,r,v)
-#define	RR(r)		(epat_read_regr(pi,2,r))
+#define	WR(r, v)	epat_write_regr(pi, 2, r, v)
+#define	RR(r)		epat_read_regr(pi, 2, r)
 
 /* and these access the IDE task file */
 
-#define WRi(r,v)         epat_write_regr(pi,0,r,v)
-#define RRi(r)           (epat_read_regr(pi,0,r))
+#define WRi(r, v)	epat_write_regr(pi, 0, r, v)
+#define RRi(r)		epat_read_regr(pi, 0, r)
 
 /* FIXME:  the CPP stuff should be fixed to handle multiple EPATs on a chain */
 
-#define CPP(x) 	w2(4);w0(0x22);w0(0xaa);w0(0x55);w0(0);w0(0xff);\
-                w0(0x87);w0(0x78);w0(x);w2(4);w2(5);w2(4);w0(0xff);
+#define CPP(x)					\
+	do {					\
+		w2(4); w0(0x22); w0(0xaa);	\
+		w0(0x55); w0(0); w0(0xff);	\
+		w0(0x87); w0(0x78); w0(x);	\
+		w2(4); w2(5); w2(4); w0(0xff);	\
+	} while (0)
 
 static void epat_connect(struct pi_adapter *pi)
-
-{       pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
 
  	/* Initialize the chip */
 	CPP(0);
 
 	if (epatc8) {
-		CPP(0x40);CPP(0xe0);
-		w0(0);w2(1);w2(4);
-		WR(0x8,0x12);WR(0xc,0x14);WR(0x12,0x10);
-		WR(0xe,0xf);WR(0xf,4);
+		CPP(0x40); CPP(0xe0);
+		w0(0); w2(1); w2(4);
+		WR(0x8, 0x12);
+		WR(0xc, 0x14);
+		WR(0x12, 0x10);
+		WR(0xe, 0xf);
+		WR(0xf, 4);
 		/* WR(0xe,0xa);WR(0xf,4); */
-		WR(0xe,0xd);WR(0xf,0);
+		WR(0xe, 0xd);
+		WR(0xf, 0);
 		/* CPP(0x30); */
 	}
 
         /* Connect to the chip */
 	CPP(0xe0);
-        w0(0);w2(1);w2(4); /* Idle into SPP */
+	w0(0); w2(1); w2(4); /* Idle into SPP */
         if (pi->mode >= 3) {
-          w0(0);w2(1);w2(4);w2(0xc);
-          /* Request EPP */
-          w0(0x40);w2(6);w2(7);w2(4);w2(0xc);w2(4);
+		w0(0); w2(1); w2(4); w2(0xc);
+		/* Request EPP */
+		w0(0x40); w2(6); w2(7); w2(4); w2(0xc); w2(4);
         }
 
 	if (!epatc8) {
-		WR(8,0x10); WR(0xc,0x14); WR(0xa,0x38); WR(0x12,0x10);
+		WR(8, 0x10);
+		WR(0xc, 0x14);
+		WR(0xa, 0x38);
+		WR(0x12, 0x10);
 	}
 }
 
 static void epat_disconnect(struct pi_adapter *pi)
-{	CPP(0x30);
+{
+	CPP(0x30);
 	w0(pi->saved_r0);
 	w2(pi->saved_r2);
 }
 
 static int epat_test_proto(struct pi_adapter *pi)
-
-{       int     k, j, f, cc;
-	int	e[2] = {0,0};
+{
+	int k, j, f, cc;
+	int e[2] = { 0, 0 };
 	char scratch[512];
 
-        epat_connect(pi);
+	epat_connect(pi);
 	cc = RR(0xd);
 	epat_disconnect(pi);
 
 	epat_connect(pi);
 	for (j=0;j<2;j++) {
-  	    WRi(6,0xa0+j*0x10);
-            for (k=0;k<256;k++) {
-                WRi(2,k^0xaa);
-                WRi(3,k^0x55);
-                if (RRi(2) != (k^0xaa)) e[j]++;
-                }
-	    }
-        epat_disconnect(pi);
-
-        f = 0;
-        epat_connect(pi);
-        WR(0x13,1); WR(0x13,0); WR(0xa,0x11);
-        epat_read_block(pi,scratch,512);
-	
-        for (k=0;k<256;k++) {
-            if ((scratch[2*k] & 0xff) != k) f++;
-            if ((scratch[2*k+1] & 0xff) != (0xff-k)) f++;
-        }
-        epat_disconnect(pi);
+		WRi(6, 0xa0 + j * 0x10);
+		for (k = 0; k < 256; k++) {
+			WRi(2, k ^ 0xaa);
+			WRi(3, k ^ 0x55);
+			if (RRi(2) != (k ^ 0xaa))
+				e[j]++;
+		}
+	}
+	epat_disconnect(pi);
 
-	dev_dbg(&pi->dev, "epat: port 0x%x, mode %d, ccr %x, test=(%d,%d,%d)\n",
-	       pi->port, pi->mode, cc, e[0], e[1], f);
-	
-        return (e[0] && e[1]) || f;
+	f = 0;
+	epat_connect(pi);
+	WR(0x13, 1); WR(0x13, 0); WR(0xa, 0x11);
+	epat_read_block(pi, scratch, 512);
+
+	for (k = 0; k < 256; k++) {
+		if ((scratch[2 * k] & 0xff) != k)
+			f++;
+		if ((scratch[2 * k + 1] & 0xff) != 0xff - k)
+			f++;
+	}
+	epat_disconnect(pi);
+
+	dev_dbg(&pi->dev,
+		"epat: port 0x%x, mode %d, ccr %x, test=(%d,%d,%d)\n",
+		pi->port, pi->mode, cc, e[0], e[1], f);
+
+	return (e[0] && e[1]) || f;
 }
 
 static void epat_log_adapter(struct pi_adapter *pi)
-
-{	int	ver;
-        char    *mode_string[6] = 
-		   {"4-bit","5/3","8-bit","EPP-8","EPP-16","EPP-32"};
+{
+	int ver;
+	char *mode_string[6] =
+		{ "4-bit", "5/3", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
 
 	epat_connect(pi);
-	WR(0xa,0x38);		/* read the version code */
-        ver = RR(0xb);
-        epat_disconnect(pi);
+	WR(0xa, 0x38);		/* read the version code */
+	ver = RR(0xb);
+	epat_disconnect(pi);
 
-	dev_info(&pi->dev, "Shuttle EPAT chip %x at 0x%x, mode %d (%s), delay %d\n",
+	dev_info(&pi->dev,
+		 "Shuttle EPAT chip %x at 0x%x, mode %d (%s), delay %d\n",
 		 ver, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
-- 
2.40.1

