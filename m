Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBECC77B7A
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjEPNHj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjEPNG5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902230F8
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04C9E639F7
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A3AC433D2;
        Tue, 16 May 2023 13:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242379;
        bh=/J8/a6o5xT5YevG7n+8tQm+Wn0F2CSc6Y3S14B+OST0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSomx/ZDV1mnMlI6EAvLtAzbciGHHe8wIsl6WofG440Hy4L8ikw1ZOk3dwfGxnIup
         /ztaFd3Nhx8iAXDpdGgk7PHLG/0YO4GpiXtbbX99/nHhOn0wlcjWXMPjZ6hesHoObP
         V3HMbPOZreolMjteKdmjadC6vz0krLffMYU5d5abQ1TjJ8EFCyaqCO9Q7NuF98S0FC
         W5YO+AkegkPkXEBA8X8QasKvRVbupPPmyhu1mzlBeSIG2fFeHu/nrR38uV7TuOvYhn
         KqOKRBfnIWgA6I3lypFDR1+JsRitu0UAF60UPI/NRoeFjDk0g4wICYLJFpWv9hMj2e
         eFFRc8hZAqeXw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 09/13] ata: pata_parport: Fix friq module code indentation and style
Date:   Tue, 16 May 2023 22:06:07 +0900
Message-Id: <20230516130611.109932-10-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the friq pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/friq.c | 292 ++++++++++++++++----------------
 1 file changed, 150 insertions(+), 142 deletions(-)

diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index 1647264cd9a8..dc428f54fe0c 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -1,24 +1,23 @@
-/* 
-	friq.c	(c) 1998    Grant R. Guenther <grant@torque.net>
-		            Under the terms of the GNU General Public License
-
-	friq.c is a low-level protocol driver for the Freecom "IQ"
-	parallel port IDE adapter.   Early versions of this adapter
-	use the 'frpw' protocol.
-	
-	Freecom uses this adapter in a battery powered external 
-	CD-ROM drive.  It is also used in LS-120 drives by
-	Maxell and Panasonic, and other devices.
-
-	The battery powered drive requires software support to
-	control the power to the drive.  This module enables the
-	drive power when the high level driver (pcd) is loaded
-	and disables it when the module is unloaded.  Note, if
-	the friq module is built in to the kernel, the power
-	will never be switched off, so other means should be
-	used to conserve battery power.
-
-*/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (c) 1998    Grant R. Guenther <grant@torque.net>
+ *
+ * friq.c is a low-level protocol driver for the Freecom "IQ"
+ * parallel port IDE adapter.   Early versions of this adapter
+ * use the 'frpw' protocol.
+ *
+ * Freecom uses this adapter in a battery powered external
+ * CD-ROM drive.  It is also used in LS-120 drives by
+ * Maxell and Panasonic, and other devices.
+ *
+ * The battery powered drive requires software support to
+ * control the power to the drive.  This module enables the
+ * drive power when the high level driver (pcd) is loaded
+ * and disables it when the module is unloaded.  Note, if
+ * the friq module is built in to the kernel, the power
+ * will never be switched off, so other means should be
+ * used to conserve battery power.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -29,197 +28,206 @@
 #include <asm/io.h>
 #include "pata_parport.h"
 
-#define CMD(x)		w2(4);w0(0xff);w0(0xff);w0(0x73);w0(0x73);\
-			w0(0xc9);w0(0xc9);w0(0x26);w0(0x26);w0(x);w0(x);
+#define CMD(x)							\
+	do {							\
+		w2(4); w0(0xff); w0(0xff); w0(0x73); w0(0x73);	\
+		w0(0xc9); w0(0xc9); w0(0x26);			\
+		w0(0x26); w0(x); w0(x);				\
+	} while (0)
 
-#define j44(l,h)	(((l>>4)&0x0f)|(h&0xf0))
+#define j44(l, h)	(((l >> 4) & 0x0f) | (h & 0xf0))
 
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
-*/
-
-static int  cont_map[2] = { 0x08, 0x10 };
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+static int cont_map[2] = { 0x08, 0x10 };
 
 static int friq_read_regr(struct pi_adapter *pi, int cont, int regr)
-
-{	int	h,l,r;
+{
+	int h, l, r;
 
 	r = regr + cont_map[cont];
 
 	CMD(r);
 	w2(6); l = r1();
 	w2(4); h = r1();
-	w2(4); 
-
-	return j44(l,h);
+	w2(4);
 
+	return j44(l, h);
 }
 
 static void friq_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
-
-{	int r;
-
-        r = regr + cont_map[cont];
+{
+	int r = regr + cont_map[cont];
 
 	CMD(r);
 	w0(val);
-	w2(5);w2(7);w2(5);w2(4);
+	w2(5); w2(7); w2(5); w2(4);
 }
 
 static void friq_read_block_int(struct pi_adapter *pi, char *buf, int count, int regr)
+{
+	int h, l, k, ph;
 
-{       int     h, l, k, ph;
-
-        switch(pi->mode) {
-
-        case 0: CMD(regr); 
-                for (k=0;k<count;k++) {
-                        w2(6); l = r1();
-                        w2(4); h = r1();
-                        buf[k] = j44(l,h);
-                }
-                w2(4);
-                break;
-
-        case 1: ph = 2;
-                CMD(regr+0xc0); 
-                w0(0xff);
-                for (k=0;k<count;k++) {
-                        w2(0xa4 + ph); 
-                        buf[k] = r0();
-                        ph = 2 - ph;
-                } 
-                w2(0xac); w2(0xa4); w2(4);
-                break;
-
-	case 2: CMD(regr+0x80);
-		for (k=0;k<count-2;k++) buf[k] = r4();
+	switch (pi->mode) {
+	case 0:
+		CMD(regr);
+		for (k = 0; k < count; k++) {
+			w2(6); l = r1();
+			w2(4); h = r1();
+			buf[k] = j44(l, h);
+		}
+		w2(4);
+		break;
+	case 1:
+		ph = 2;
+		CMD(regr + 0xc0);
+		w0(0xff);
+		for (k = 0; k < count; k++) {
+			w2(0xa4 + ph);
+			buf[k] = r0();
+			ph = 2 - ph;
+		}
+		w2(0xac); w2(0xa4); w2(4);
+		break;
+	case 2:
+		CMD(regr + 0x80);
+		for (k = 0; k < count - 2; k++)
+			buf[k] = r4();
 		w2(0xac); w2(0xa4);
-		buf[count-2] = r4();
-		buf[count-1] = r4();
+		buf[count - 2] = r4();
+		buf[count - 1] = r4();
 		w2(4);
 		break;
-
-	case 3: CMD(regr+0x80);
-                for (k=0;k<(count/2)-1;k++) ((u16 *)buf)[k] = r4w();
-                w2(0xac); w2(0xa4);
-                buf[count-2] = r4();
-                buf[count-1] = r4();
-                w2(4);
-                break;
-
-	case 4: CMD(regr+0x80);
-                for (k=0;k<(count/4)-1;k++) ((u32 *)buf)[k] = r4l();
-                buf[count-4] = r4();
-                buf[count-3] = r4();
-                w2(0xac); w2(0xa4);
-                buf[count-2] = r4();
-                buf[count-1] = r4();
-                w2(4);
-                break;
-
-        }
+	case 3:
+		CMD(regr + 0x80);
+		for (k = 0; k < count / 2 - 1; k++)
+			((u16 *)buf)[k] = r4w();
+		w2(0xac); w2(0xa4);
+		buf[count - 2] = r4();
+		buf[count - 1] = r4();
+		w2(4);
+		break;
+	case 4:
+		CMD(regr + 0x80);
+		for (k = 0; k < count / 4 - 1; k++)
+			((u32 *)buf)[k] = r4l();
+		buf[count - 4] = r4();
+		buf[count - 3] = r4();
+		w2(0xac); w2(0xa4);
+		buf[count - 2] = r4();
+		buf[count - 1] = r4();
+		w2(4);
+		break;
+	}
 }
 
 static void friq_read_block(struct pi_adapter *pi, char *buf, int count)
-
-{	friq_read_block_int(pi,buf,count,0x08);
+{
+	friq_read_block_int(pi, buf, count, 0x08);
 }
 
 static void friq_write_block(struct pi_adapter *pi, char *buf, int count)
- 
-{	int	k;
-
-	switch(pi->mode) {
+{
+	int k;
 
+	switch (pi->mode) {
 	case 0:
-	case 1: CMD(8); w2(5);
-        	for (k=0;k<count;k++) {
+	case 1:
+		CMD(8); w2(5);
+		for (k = 0; k < count; k++) {
 			w0(buf[k]);
-			w2(7);w2(5);
+			w2(7); w2(5);
 		}
 		w2(4);
 		break;
-
-	case 2: CMD(0xc8); w2(5);
-		for (k=0;k<count;k++) w4(buf[k]);
+	case 2:
+		CMD(0xc8); w2(5);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
+		w2(4);
+		break;
+	case 3:
+		CMD(0xc8); w2(5);
+		for (k = 0; k < count / 2; k++)
+			w4w(((u16 *)buf)[k]);
+		w2(4);
+		break;
+	case 4:
+		CMD(0xc8); w2(5);
+		for (k = 0; k < count / 4; k++)
+			w4l(((u32 *)buf)[k]);
 		w2(4);
 		break;
-
-        case 3: CMD(0xc8); w2(5);
-                for (k=0;k<count/2;k++) w4w(((u16 *)buf)[k]);
-                w2(4);
-                break;
-
-        case 4: CMD(0xc8); w2(5);
-                for (k=0;k<count/4;k++) w4l(((u32 *)buf)[k]);
-                w2(4);
-                break;
-	}
+}
 }
 
 static void friq_connect(struct pi_adapter *pi)
-
-{       pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
 	w2(4);
 }
 
 static void friq_disconnect(struct pi_adapter *pi)
-
-{       CMD(0x20);
+{
+	CMD(0x20);
 	w0(pi->saved_r0);
-        w2(pi->saved_r2);
-} 
+	w2(pi->saved_r2);
+}
 
 static int friq_test_proto(struct pi_adapter *pi)
-
-{       int     j, k, r;
-	int	e[2] = {0,0};
+{
+	int j, k, r;
+	int e[2] = { 0, 0 };
 	char scratch[512];
 
-	pi->saved_r0 = r0();	
+	pi->saved_r0 = r0();
 	w0(0xff); udelay(20); CMD(0x3d); /* turn the power on */
 	udelay(500);
 	w0(pi->saved_r0);
 
 	friq_connect(pi);
-	for (j=0;j<2;j++) {
-                friq_write_regr(pi,0,6,0xa0+j*0x10);
-                for (k=0;k<256;k++) {
-                        friq_write_regr(pi,0,2,k^0xaa);
-                        friq_write_regr(pi,0,3,k^0x55);
-                        if (friq_read_regr(pi,0,2) != (k^0xaa)) e[j]++;
-                        }
-                }
+	for (j = 0; j < 2; j++) {
+		friq_write_regr(pi, 0, 6, 0xa0 + j * 0x10);
+		for (k = 0; k < 256; k++) {
+			friq_write_regr(pi, 0, 2, k ^ 0xaa);
+			friq_write_regr(pi, 0, 3, k ^ 0x55);
+			if (friq_read_regr(pi, 0, 2) != (k ^ 0xaa))
+				e[j]++;
+		}
+	}
 	friq_disconnect(pi);
 
 	friq_connect(pi);
-        friq_read_block_int(pi,scratch,512,0x10);
-        r = 0;
-        for (k=0;k<128;k++) if (scratch[k] != k) r++;
+	friq_read_block_int(pi, scratch, 512, 0x10);
+	r = 0;
+	for (k = 0; k < 128; k++) {
+		if (scratch[k] != k)
+			r++;
+	}
 	friq_disconnect(pi);
 
-	dev_dbg(&pi->dev, "friq: port 0x%x, mode %d, test=(%d,%d,%d)\n",
-	       pi->port, pi->mode, e[0], e[1], r);
+	dev_dbg(&pi->dev,
+		"friq: port 0x%x, mode %d, test=(%d,%d,%d)\n",
+		pi->port, pi->mode, e[0], e[1], r);
 
-        return (r || (e[0] && e[1]));
+	return r || (e[0] && e[1]);
 }
 
-
 static void friq_log_adapter(struct pi_adapter *pi)
+{
+	char *mode_string[6] = { "4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32"};
 
-{       char    *mode_string[6] = {"4-bit","8-bit",
-				   "EPP-8","EPP-16","EPP-32"};
-
-	dev_info(&pi->dev, "Freecom IQ ASIC-2 adapter at 0x%x, mode %d (%s), delay %d\n",
-		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+	dev_info(&pi->dev,
+		 "Freecom IQ ASIC-2 adapter at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 
 	pi->private = 1;
 	friq_connect(pi);
 	CMD(0x9e);  		/* disable sleep timer */
 	friq_disconnect(pi);
-
 }
 
 static void friq_release_proto(struct pi_adapter *pi)
-- 
2.40.1

