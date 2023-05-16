Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE9FC77B75
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjEPNHD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjEPNGj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF3661A8
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 855AB639EC
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8776FC4339B;
        Tue, 16 May 2023 13:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242376;
        bh=McO4BrBanpl/+6ykFAyscyJKKB6Uz1XFy+ax4VP6lnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqmdAM7uvOj3xsKz7b3/tbIyww2sBjU7HJa48PpUoTEpHwLlBD3oric1BoX3ArplC
         4VEVsQ11wtYcwwq+P6XxM7h6JDekjlpCJ1OEFGK5CoK524Y6HZbZV96HxVe0Uls221
         XyZ+5Ve+xQKVPy7KlsyrmiBGiJOaW3iDRfxhDL/grqAW59u1XbrR9jvyA+A4q64FOH
         XSQ5lUuBqnzvWNU9xTVakSw88+6HMAaK2IxZZTCcZ36Jn7SlUPFB/ile25zqN0FbW8
         aExDh0MWhBgYBD66nbSryhqJH7j7wsszwWUWP2Y/GVz42UXt9eMkW9uiXtF0A1tyrf
         SGuJbvS0TCDdg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 04/13] ata: pata_parport: Fix dstr module code indentation and style
Date:   Tue, 16 May 2023 22:06:02 +0900
Message-Id: <20230516130611.109932-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the dstr pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/dstr.c | 285 +++++++++++++++++---------------
 1 file changed, 154 insertions(+), 131 deletions(-)

diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
index 2524684be206..368d7c7962a9 100644
--- a/drivers/ata/pata_parport/dstr.c
+++ b/drivers/ata/pata_parport/dstr.c
@@ -1,11 +1,10 @@
-/* 
-        dstr.c    (c) 1997-8  Grant R. Guenther <grant@torque.net>
-                              Under the terms of the GNU General Public License.
-
-        dstr.c is a low-level protocol driver for the 
-        DataStor EP2000 parallel to IDE adapter chip.
-
-*/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (c) 1997-1998  Grant R. Guenther <grant@torque.net>
+ *
+ * dstr.c is a low-level protocol driver for the DataStor EP2000 parallel
+ * to IDE adapter chip.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -16,178 +15,202 @@
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
 
-#define j44(a,b)  (((a>>3)&0x07)|((~a>>4)&0x08)|((b<<1)&0x70)|((~b)&0x80))
+#define j44(a, b)  (((a >> 3) & 0x07) | ((~a >> 4) & 0x08) | \
+		    ((b << 1) & 0x70) | ((~b) & 0x80))
 
 #define P1	w2(5);w2(0xd);w2(5);w2(4);
 #define P2	w2(5);w2(7);w2(5);w2(4);
 #define P3      w2(6);w2(4);w2(6);w2(4);
 
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
-*/
-
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
 static int  cont_map[2] = { 0x20, 0x40 };
 
 static int dstr_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int a, b, r;
 
-{       int     a, b, r;
-
-        r = regr + cont_map[cont];
+	r = regr + cont_map[cont];
 
 	w0(0x81); P1;
-	if (pi->mode) { w0(0x11); } else { w0(1); }
+	if (pi->mode)
+		w0(0x11);
+	else
+		w0(1);
 	P2; w0(r); P1;
 
-        switch (pi->mode)  {
-
-        case 0: w2(6); a = r1(); w2(4); w2(6); b = r1(); w2(4);
-                return j44(a,b);
-
-        case 1: w0(0); w2(0x26); a = r0(); w2(4);
-                return a;
-
+	switch (pi->mode) {
+	case 0:
+		w2(6); a = r1(); w2(4); w2(6); b = r1(); w2(4);
+		return j44(a, b);
+	case 1:
+		w0(0); w2(0x26); a = r0(); w2(4);
+		return a;
 	case 2:
 	case 3:
-        case 4: w2(0x24); a = r4(); w2(4);
-                return a;
+	case 4:
+		w2(0x24); a = r4(); w2(4);
+		return a;
+	}
 
-        }
-        return -1;
-}       
+	return -1;
+}
 
 static void dstr_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int  r = regr + cont_map[cont];
 
-{       int  r;
-
-        r = regr + cont_map[cont];
-
-	w0(0x81); P1; 
-	if (pi->mode >= 2) { w0(0x11); } else { w0(1); }
+	w0(0x81); P1;
+	if (pi->mode >= 2)
+		w0(0x11);
+	else
+		w0(1);
 	P2; w0(r); P1;
-	
-        switch (pi->mode)  {
 
-        case 0:
-        case 1: w0(val); w2(5); w2(7); w2(5); w2(4);
+	switch (pi->mode)  {
+	case 0:
+	case 1:
+		w0(val); w2(5); w2(7); w2(5); w2(4);
 		break;
-
 	case 2:
 	case 3:
-        case 4: w4(val); 
-                break;
-        }
+	case 4:
+		w4(val);
+		break;
+	}
 }
 
-#define  CCP(x)  w0(0xff);w2(0xc);w2(4);\
-		 w0(0xaa);w0(0x55);w0(0);w0(0xff);w0(0x87);w0(0x78);\
-		 w0(x);w2(5);w2(4);
+#define  CCP(x)						\
+	do {						\
+		w0(0xff); w2(0xc); w2(4);		\
+		w0(0xaa); w0(0x55); w0(0); w0(0xff);	\
+		w0(0x87); w0(0x78);			\
+		w0(x); w2(5); w2(4);			\
+	} while (0)
 
 static void dstr_connect(struct pi_adapter *pi)
-
-{       pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
-        w2(4); CCP(0xe0); w0(0xff);
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(4); CCP(0xe0); w0(0xff);
 }
 
 static void dstr_disconnect(struct pi_adapter *pi)
-
-{       CCP(0x30);
-        w0(pi->saved_r0);
-        w2(pi->saved_r2);
-} 
+{
+	CCP(0x30);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
 
 static void dstr_read_block(struct pi_adapter *pi, char *buf, int count)
-
-{       int     k, a, b;
+{
+	int k, a, b;
 
         w0(0x81); P1;
-        if (pi->mode) { w0(0x19); } else { w0(9); }
+	if (pi->mode)
+		w0(0x19);
+	else
+		w0(9);
 	P2; w0(0x82); P1; P3; w0(0x20); P1;
 
-        switch (pi->mode) {
-
-        case 0: for (k=0;k<count;k++) {
-                        w2(6); a = r1(); w2(4);
-                        w2(6); b = r1(); w2(4);
-                        buf[k] = j44(a,b);
-                } 
-                break;
-
-        case 1: w0(0);
-                for (k=0;k<count;k++) {
-                        w2(0x26); buf[k] = r0(); w2(0x24);
-                }
-                w2(4);
-                break;
-
-        case 2: w2(0x24); 
-                for (k=0;k<count;k++) buf[k] = r4();
-                w2(4);
-                break;
-
-        case 3: w2(0x24); 
-                for (k=0;k<count/2;k++) ((u16 *)buf)[k] = r4w();
-                w2(4);
-                break;
-
-        case 4: w2(0x24); 
-                for (k=0;k<count/4;k++) ((u32 *)buf)[k] = r4l();
-                w2(4);
-                break;
-
-        }
+	switch (pi->mode) {
+	case 0:
+		for (k = 0; k < count; k++) {
+			w2(6); a = r1(); w2(4);
+			w2(6); b = r1(); w2(4);
+			buf[k] = j44(a, b);
+		}
+		break;
+	case 1:
+		w0(0);
+		for (k = 0; k < count; k++) {
+			w2(0x26);
+			buf[k] = r0();
+			w2(0x24);
+		}
+		w2(4);
+		break;
+	case 2:
+		w2(0x24);
+		for (k = 0; k < count; k++)
+			buf[k] = r4();
+		w2(4);
+		break;
+	case 3:
+		w2(0x24);
+		for (k = 0; k < count / 2; k++)
+			((u16 *)buf)[k] = r4w();
+		w2(4);
+		break;
+	case 4:
+		w2(0x24);
+		for (k = 0; k < count / 4; k++)
+			((u32 *)buf)[k] = r4l();
+		w2(4);
+		break;
+	}
 }
 
 static void dstr_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
 
-{       int	k;
-
-        w0(0x81); P1;
-        if (pi->mode) { w0(0x19); } else { w0(9); }
-        P2; w0(0x82); P1; P3; w0(0x20); P1;
-
-        switch (pi->mode) {
-
-        case 0:
-        case 1: for (k=0;k<count;k++) {
-                        w2(5); w0(buf[k]); w2(7);
-                }
-                w2(5); w2(4);
-                break;
+	w0(0x81); P1;
+	if (pi->mode)
+		w0(0x19);
+	else
+		w0(9);
+	P2; w0(0x82); P1; P3; w0(0x20); P1;
 
-        case 2: w2(0xc5);
-                for (k=0;k<count;k++) w4(buf[k]);
+	switch (pi->mode) {
+	case 0:
+	case 1:
+		for (k = 0; k < count; k++) {
+			w2(5);
+			w0(buf[k]);
+			w2(7);
+		}
+		w2(5); w2(4);
+		break;
+	case 2:
+		w2(0xc5);
+		for (k = 0; k < count; k++)
+			w4(buf[k]);
 		w2(0xc4);
-                break;
-
-        case 3: w2(0xc5);
-                for (k=0;k<count/2;k++) w4w(((u16 *)buf)[k]);
-                w2(0xc4);
-                break;
-
-        case 4: w2(0xc5);
-                for (k=0;k<count/4;k++) w4l(((u32 *)buf)[k]);
-                w2(0xc4);
-                break;
-
-        }
+		break;
+	case 3:
+		w2(0xc5);
+		for (k = 0; k < count / 2; k++)
+			w4w(((u16 *)buf)[k]);
+		w2(0xc4);
+		break;
+	case 4:
+		w2(0xc5);
+		for (k = 0; k < count / 4; k++)
+			w4l(((u32 *)buf)[k]);
+		w2(0xc4);
+		break;
+	}
 }
 
-
 static void dstr_log_adapter(struct pi_adapter *pi)
 
-{       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
-				   "EPP-16","EPP-32"};
+{
+	char *mode_string[5] = { "4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
 
-	dev_info(&pi->dev, "DataStor EP2000 at 0x%x, mode %d (%s), delay %d\n",
-		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+	dev_info(&pi->dev,
+		 "DataStor EP2000 at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol dstr = {
-- 
2.40.1

