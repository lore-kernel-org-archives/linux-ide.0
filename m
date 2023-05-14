Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB859C77B7F
	for <linux-ide@archiver.kernel.org>; Sun, 14 May 2023 22:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjENWB0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 14 May 2023 18:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENWBY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 14 May 2023 18:01:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32F2E6F
        for <linux-ide@vger.kernel.org>; Sun, 14 May 2023 15:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5974D60F7D
        for <linux-ide@vger.kernel.org>; Sun, 14 May 2023 22:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B452C4339B;
        Sun, 14 May 2023 22:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684101681;
        bh=p4XiAV5LBngxws8/3xzjGKKuPOi+GDOK1id/WC/Wofk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+SXRGt3PqQuZVi4T9/06MVCAwB8E+Krsz7hyH43Hy+RjdP5yDMKEzV7qBJYsnUoT
         FI8Sy1hLdOBFvfcTA+pDmF1SgdqHAxN3LYX+m1jEtMLJ7ameZ3PV+GyMu2Eh3KyUPv
         hKg1FEC/d/XYCbrJgmc1fgjK9Kn2zuHXsR+s1IJfOda9sJJcdTbkeWMr6OhgQBR1P7
         Or9iFXXYc3byEQ8M/y+qbmzgvnDZAzeF9n1TZO3oVkUNK8wXsAP4AB3a/1q6i+lZ5U
         JDllQN/pm1HC/IJxVWnj9AB4fEBxJkejhK4fP8Agfnj+yjoYNxtiJFtED3l7KSf7sN
         bEbSwHF+iPjBQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 2/2] ata: pata_parport: Fix frpw module code indentation and style
Date:   Mon, 15 May 2023 07:01:18 +0900
Message-Id: <20230514220118.114385-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230514220118.114385-1-dlemoal@kernel.org>
References: <20230514220118.114385-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix indentation and coding style in the frpw pata parport protocol
module to suppress smatch warnings such as:

drivers/ata/pata_parport/frpw.c:234 frpw_test_proto() warn: inconsistent indenting

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305061212.EPgEMLXl-lkp@intel.com/
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/frpw.c | 310 +++++++++++++++++---------------
 1 file changed, 162 insertions(+), 148 deletions(-)

diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 3ec0abf16fa6..a644aa7f18b0 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -1,17 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* 
-	frpw.c	(c) 1996-8  Grant R. Guenther <grant@torque.net>
-		            Under the terms of the GNU General Public License
-
-	frpw.c is a low-level protocol driver for the Freecom "Power"
-	parallel port IDE adapter.
-	
-	Some applications of this adapter may require a "printer" reset
-	prior to loading the driver.  This can be done by loading and
-	unloading the "lp" driver, or it can be done by this driver
-	if you define FRPW_HARD_RESET.  The latter is not recommended
-	as it may upset devices on other ports.
-
-*/
+ * (c) 1996-1998  Grant R. Guenther <grant@torque.net>
+ *
+ * frpw.c is a low-level protocol driver for the Freecom "Power" parallel port
+ * IDE adapter.
+ *
+ * Some applications of this adapter may require a "printer" reset prior to
+ * loading the driver.  This can be done by loading and unloading the "lp"
+ * driver, or it can be done by this driver if you define FRPW_HARD_RESET.
+ * The latter is not recommended as it may upset devices on other ports.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -25,15 +23,15 @@
 #define cec4		w2(0xc);w2(0xe);w2(0xe);w2(0xc);w2(4);w2(4);w2(4);
 #define j44(l,h)	(((l>>4)&0x0f)|(h&0xf0))
 
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
-*/
-
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
 static int  cont_map[2] = { 0x08, 0x10 };
 
 static int frpw_read_regr(struct pi_adapter *pi, int cont, int regr)
-
-{	int	h,l,r;
+{
+	int h, l, r;
 
 	r = regr + cont_map[cont];
 
@@ -43,143 +41,154 @@ static int frpw_read_regr(struct pi_adapter *pi, int cont, int regr)
 	w2(4); h = r1();
 	w2(4); 
 
-	return j44(l,h);
-
+	return j44(l, h);
 }
 
 static void frpw_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
-
-{	int r;
-
-        r = regr + cont_map[cont];
+{
+	int r = regr + cont_map[cont];
 
 	w2(4); w0(r); cec4; 
 	w0(val);
-	w2(5);w2(7);w2(5);w2(4);
+	w2(5); w2(7); w2(5); w2(4);
 }
 
-static void frpw_read_block_int(struct pi_adapter *pi, char *buf, int count, int regr)
-
-{       int     h, l, k, ph;
-
-        switch(pi->mode) {
-
-        case 0: w2(4); w0(regr); cec4;
-                for (k=0;k<count;k++) {
-                        w2(6); l = r1();
-                        w2(4); h = r1();
-                        buf[k] = j44(l,h);
-                }
-                w2(4);
-                break;
-
-        case 1: ph = 2;
-                w2(4); w0(regr + 0xc0); cec4;
-                w0(0xff);
-                for (k=0;k<count;k++) {
-                        w2(0xa4 + ph); 
-                        buf[k] = r0();
-                        ph = 2 - ph;
-                } 
-                w2(0xac); w2(0xa4); w2(4);
-                break;
-
-        case 2: w2(4); w0(regr + 0x80); cec4;
-                for (k=0;k<count;k++) buf[k] = r4();
-                w2(0xac); w2(0xa4);
-                w2(4);
-                break;
-
-	case 3: w2(4); w0(regr + 0x80); cec4;
-		for (k=0;k<count-2;k++) buf[k] = r4();
+static void frpw_read_block_int(struct pi_adapter *pi, char *buf, int count,
+				int regr)
+{
+	int h, l, k, ph;
+
+	switch (pi->mode) {
+	case 0:
+		w2(4); w0(regr); cec4;
+		for (k = 0; k < count; k++) {
+			w2(6); l = r1();
+			w2(4); h = r1();
+			buf[k] = j44(l, h);
+		}
+		w2(4);
+		break;
+
+	case 1:
+		ph = 2;
+		w2(4); w0(regr + 0xc0); cec4;
+		w0(0xff);
+		for (k = 0; k < count; k++) {
+			w2(0xa4 + ph);
+			buf[k] = r0();
+			ph = 2 - ph;
+		}
+		w2(0xac); w2(0xa4); w2(4);
+		break;
+
+	case 2:
+		w2(4); w0(regr + 0x80); cec4;
+		for (k = 0; k < count; k++)
+			buf[k] = r4();
 		w2(0xac); w2(0xa4);
-		buf[count-2] = r4();
-		buf[count-1] = r4();
 		w2(4);
 		break;
 
-	case 4: w2(4); w0(regr + 0x80); cec4;
-                for (k=0;k<(count/2)-1;k++) ((u16 *)buf)[k] = r4w();
-                w2(0xac); w2(0xa4);
-                buf[count-2] = r4();
-                buf[count-1] = r4();
-                w2(4);
-                break;
-
-	case 5: w2(4); w0(regr + 0x80); cec4;
-                for (k=0;k<(count/4)-1;k++) ((u32 *)buf)[k] = r4l();
-                buf[count-4] = r4();
-                buf[count-3] = r4();
-                w2(0xac); w2(0xa4);
-                buf[count-2] = r4();
-                buf[count-1] = r4();
-                w2(4);
-                break;
+	case 3:
+		w2(4); w0(regr + 0x80); cec4;
+		for (k = 0; k < count - 2; k++)
+			buf[k] = r4();
+		w2(0xac); w2(0xa4);
+		buf[count - 2] = r4();
+		buf[count - 1] = r4();
+		w2(4);
+		break;
+
+	case 4:
+		w2(4); w0(regr + 0x80); cec4;
+		for (k = 0; k < count / 2 - 1; k++)
+			((u16 *)buf)[k] = r4w();
+		w2(0xac); w2(0xa4);
+		buf[count - 2] = r4();
+		buf[count - 1] = r4();
+		w2(4);
+		break;
 
+	case 5:
+		w2(4); w0(regr + 0x80); cec4;
+		for (k = 0; k < count / 4 - 1; k++)
+			((u32 *)buf)[k] = r4l();
+		buf[count - 4] = r4();
+		buf[count - 3] = r4();
+		w2(0xac); w2(0xa4);
+		buf[count - 2] = r4();
+		buf[count - 1] = r4();
+		w2(4);
+		break;
         }
 }
 
 static void frpw_read_block(struct pi_adapter *pi, char *buf, int count)
-
-{	frpw_read_block_int(pi,buf,count,0x08);
+{
+	frpw_read_block_int(pi, buf, count, 0x08);
 }
 
 static void frpw_write_block(struct pi_adapter *pi, char *buf, int count)
- 
-{	int	k;
-
-	switch(pi->mode) {
+{
+	int k;
 
+	switch (pi->mode) {
 	case 0:
 	case 1:
-	case 2: w2(4); w0(8); cec4; w2(5);
-        	for (k=0;k<count;k++) {
+	case 2:
+		w2(4); w0(8); cec4; w2(5);
+		for (k = 0; k < count; k++) {
 			w0(buf[k]);
-			w2(7);w2(5);
+			w2(7); w2(5);
 		}
 		w2(4);
 		break;
 
-	case 3: w2(4); w0(0xc8); cec4; w2(5);
-		for (k=0;k<count;k++) w4(buf[k]);
+	case 3:
+		w2(4); w0(0xc8); cec4; w2(5);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
 		w2(4);
 		break;
 
-        case 4: w2(4); w0(0xc8); cec4; w2(5);
-                for (k=0;k<count/2;k++) w4w(((u16 *)buf)[k]);
-                w2(4);
-                break;
+	case 4:
+		w2(4); w0(0xc8); cec4; w2(5);
+		for (k = 0; k < count / 2; k++)
+			w4w(((u16 *)buf)[k]);
+		w2(4);
+		break;
 
-        case 5: w2(4); w0(0xc8); cec4; w2(5);
-                for (k=0;k<count/4;k++) w4l(((u32 *)buf)[k]);
-                w2(4);
-                break;
+	case 5:
+		w2(4); w0(0xc8); cec4; w2(5);
+		for (k = 0; k < count / 4; k++)
+			w4l(((u32 *)buf)[k]);
+		w2(4);
+		break;
 	}
 }
 
 static void frpw_connect(struct pi_adapter *pi)
-
-{       pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
 	w2(4);
 }
 
 static void frpw_disconnect(struct pi_adapter *pi)
-
-{       w2(4); w0(0x20); cec4;
+{
+	w2(4); w0(0x20); cec4;
 	w0(pi->saved_r0);
-        w2(pi->saved_r2);
+	w2(pi->saved_r2);
 } 
 
-/* Stub logic to see if PNP string is available - used to distinguish
-   between the Xilinx and ASIC implementations of the Freecom adapter.
-*/
-
+/*
+ * Stub logic to see if PNP string is available - used to distinguish
+ * between the Xilinx and ASIC implementations of the Freecom adapter.
+ * returns chip_type:   0 = Xilinx, 1 = ASIC
+ */
 static int frpw_test_pnp(struct pi_adapter *pi)
-
-/*  returns chip_type:   0 = Xilinx, 1 = ASIC   */
-
-{	int olddelay, a, b;
+{
+	int olddelay, a, b;
 
 #ifdef FRPW_HARD_RESET
         w0(0); w2(8); udelay(50); w2(0xc);   /* parallel bus reset */
@@ -200,65 +209,70 @@ static int frpw_test_pnp(struct pi_adapter *pi)
         w0(pi->saved_r0);
         w2(pi->saved_r2);
 
-	return ((~a&0x40) && (b&0x40));
+	return ((~a & 0x40) && (b & 0x40));
 } 
 
-/* We use the pi->private to remember the result of the PNP test.
-   To make this work, private = port*2 + chip.  Yes, I know it's
-   a hack :-(
-*/
-
+/*
+ * We use the pi->private to remember the result of the PNP test.
+ * To make this work, private = port*2 + chip.  Yes, I know it's a hack :-(
+ */
 static int frpw_test_proto(struct pi_adapter *pi)
-
-{       int     j, k, r;
-	int	e[2] = {0,0};
+{
+	int j, k, r;
+	int e[2] = { 0, 0 };
 	char scratch[512];
 
-	if ((pi->private>>1) != pi->port)
-	   pi->private = frpw_test_pnp(pi) + 2*pi->port;
+	if ((pi->private >> 1) != pi->port)
+		pi->private = frpw_test_pnp(pi) + 2*pi->port;
 
-	if (((pi->private%2) == 0) && (pi->mode > 2)) {
-		dev_dbg(&pi->dev, "frpw: Xilinx does not support mode %d\n", pi->mode);
-	   return 1;
+	if (((pi->private & 0x1) == 0) && (pi->mode > 2)) {
+		dev_dbg(&pi->dev,
+			"frpw: Xilinx does not support mode %d\n", pi->mode);
+		return 1;
 	}
 
-	if (((pi->private%2) == 1) && (pi->mode == 2)) {
+	if (((pi->private & 0x1) == 1) && (pi->mode == 2)) {
 		dev_dbg(&pi->dev, "frpw: ASIC does not support mode 2\n");
-	   return 1;
+		return 1;
 	}
 
 	frpw_connect(pi);
-	for (j=0;j<2;j++) {
-                frpw_write_regr(pi,0,6,0xa0+j*0x10);
-                for (k=0;k<256;k++) {
-                        frpw_write_regr(pi,0,2,k^0xaa);
-                        frpw_write_regr(pi,0,3,k^0x55);
-                        if (frpw_read_regr(pi,0,2) != (k^0xaa)) e[j]++;
-                        }
-                }
+	for (j = 0; j < 2; j++) {
+		frpw_write_regr(pi, 0, 6, 0xa0 + j * 0x10);
+		for (k = 0; k < 256; k++) {
+			frpw_write_regr(pi, 0, 2, k ^ 0xaa);
+			frpw_write_regr(pi, 0, 3, k ^ 0x55);
+			if (frpw_read_regr(pi, 0, 2) != (k ^ 0xaa))
+				e[j]++;
+		}
+	}
 	frpw_disconnect(pi);
 
 	frpw_connect(pi);
-        frpw_read_block_int(pi,scratch,512,0x10);
-        r = 0;
-        for (k=0;k<128;k++) if (scratch[k] != k) r++;
+	frpw_read_block_int(pi, scratch, 512, 0x10);
+	r = 0;
+	for (k = 0; k < 128; k++) {
+		if (scratch[k] != k)
+			r++;
+	}
 	frpw_disconnect(pi);
 
-	dev_dbg(&pi->dev, "frpw: port 0x%x, chip %ld, mode %d, test=(%d,%d,%d)\n",
-	       pi->port, (pi->private%2), pi->mode, e[0], e[1], r);
+	dev_dbg(&pi->dev,
+		"frpw: port 0x%x, chip %ld, mode %d, test=(%d,%d,%d)\n",
+		pi->port, (pi->private%2), pi->mode, e[0], e[1], r);
 
-        return (r || (e[0] && e[1]));
+	return r || (e[0] && e[1]);
 }
 
-
 static void frpw_log_adapter(struct pi_adapter *pi)
 
-{       char    *mode_string[6] = {"4-bit","8-bit","EPP",
-				   "EPP-8","EPP-16","EPP-32"};
+{
+	char *mode[6] = { "4-bit", "8-bit", "EPP", "EPP-8", "EPP-16", "EPP-32"};
 
-	dev_info(&pi->dev, "Freecom (%s) adapter at 0x%x, mode %d (%s), delay %d\n",
-		((pi->private % 2) == 0) ? "Xilinx" : "ASIC",
-		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+	dev_info(&pi->dev,
+		 "Freecom (%s) adapter at 0x%x, mode %d (%s), delay %d\n",
+		 ((pi->private & 0x1) == 0) ? "Xilinx" : "ASIC",
+		 pi->port, pi->mode, mode[pi->mode], pi->delay);
 }
 
 static struct pi_protocol frpw = {
-- 
2.40.1

