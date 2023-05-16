Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2017C77B7A
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjEPNG5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjEPNGi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B98691
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEE3A639E9
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20D9C433D2;
        Tue, 16 May 2023 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242375;
        bh=b7mBa2n9YZRrcCRPEa44ygZQ3UMVNOZiViWIwLhyw48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDNPGcToaHtd1XV72x/hAXcSiyzlUW7NX/bm4Il1G2z+3X9Ew5cNf8hnbTdf6B+zd
         v+K4+4GYBdilA9ppE+bo1EZ93ZO43wmmkXfZGdeGrikFpKAvlrCLmzQ43bO2+1CXNr
         7gkTY2f6TgAGdMrLQ7vGwcEM4s6bap33tDfuMRYs11rrlfaD87WVpBWJzmT78duOXD
         XSod+JXzv3XD2+dN4YOOA9tXS0McAxAM0NYyzh5OYPAGuRCAFiG+16nA2raCYhpzWF
         +RFx8HSovGAvHUQLvBIjjy0EKBK1tygWz7kbSdZvAgHjYjTPcLg6zPCqWl7X2ftRJw
         EPvqAAySTIorg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 03/13] ata: pata_parport: Fix comm module code indentation and style
Date:   Tue, 16 May 2023 22:06:01 +0900
Message-Id: <20230516130611.109932-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the comm pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/comm.c | 238 ++++++++++++++++----------------
 1 file changed, 122 insertions(+), 116 deletions(-)

diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index 4c2f9ad60ad8..cc5485bd0a5b 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -1,12 +1,11 @@
-/* 
-        comm.c    (c) 1997-8  Grant R. Guenther <grant@torque.net>
-                              Under the terms of the GNU General Public License.
-
-	comm.c is a low-level protocol driver for some older models
-	of the DataStor "Commuter" parallel to IDE adapter.  Some of
-	the parallel port devices marketed by Arista currently
-	use this adapter.
-*/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (c) 1997-1998  Grant R. Guenther <grant@torque.net>
+ *
+ * comm.c is a low-level protocol driver for some older models of the DataStor
+ * "Commuter" parallel to IDE adapter. Some of the parallel port devices
+ * marketed by Arista currently use this adapter.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -17,165 +16,172 @@
 #include <asm/io.h>
 #include "pata_parport.h"
 
-/* mode codes:  0  nybble reads, 8-bit writes
-                1  8-bit reads and writes
-                2  8-bit EPP mode
-*/
+/*
+ * mode codes:  0  nybble reads, 8-bit writes
+ *              1  8-bit reads and writes
+ *              2  8-bit EPP mode
+ */
 
-#define j44(a,b)	(((a>>3)&0x0f)|((b<<1)&0xf0))
+#define j44(a, b)	(((a >> 3) & 0x0f) | ((b << 1) & 0xf0))
 
 #define P1	w2(5);w2(0xd);w2(0xd);w2(5);w2(4);
 #define P2	w2(5);w2(7);w2(7);w2(5);w2(4);
 
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
-*/
-
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
 static int  cont_map[2] = { 0x08, 0x10 };
 
 static int comm_read_regr(struct pi_adapter *pi, int cont, int regr)
-
-{       int     l, h, r;
+{
+	int l, h, r;
 
         r = regr + cont_map[cont];
 
-        switch (pi->mode)  {
+	switch (pi->mode) {
+	case 0:
+		w0(r); P1; w0(0);
+		w2(6); l = r1(); w0(0x80); h = r1(); w2(4);
+		return j44(l, h);
 
-        case 0: w0(r); P1; w0(0);
-        	w2(6); l = r1(); w0(0x80); h = r1(); w2(4);
-                return j44(l,h);
-
-        case 1: w0(r+0x20); P1; 
-        	w0(0); w2(0x26); h = r0(); w2(4);
-                return h;
+	case 1:
+		w0(r+0x20); P1;
+		w0(0); w2(0x26); h = r0(); w2(4);
+		return h;
 
 	case 2:
 	case 3:
-        case 4: w3(r+0x20); (void)r1();
-        	w2(0x24); h = r4(); w2(4);
-                return h;
+	case 4:
+		w3(r+0x20); (void)r1();
+		w2(0x24); h = r4(); w2(4);
+		return h;
+	}
 
-        }
-        return -1;
-}       
+	return -1;
+}
 
 static void comm_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = regr + cont_map[cont];
 
-{       int  r;
-
-        r = regr + cont_map[cont];
-
-        switch (pi->mode)  {
-
-        case 0:
-        case 1: w0(r); P1; w0(val); P2;
+	switch (pi->mode) {
+	case 0:
+	case 1:
+		w0(r); P1; w0(val); P2;
 		break;
-
 	case 2:
 	case 3:
-        case 4: w3(r); (void)r1(); w4(val);
-                break;
-        }
+	case 4:
+		w3(r); (void)r1(); w4(val);
+		break;
+	}
 }
 
 static void comm_connect(struct pi_adapter *pi)
-
-{       pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
-        w2(4); w0(0xff); w2(6);
-        w2(4); w0(0xaa); w2(6);
-        w2(4); w0(0x00); w2(6);
-        w2(4); w0(0x87); w2(6);
-        w2(4); w0(0xe0); w2(0xc); w2(0xc); w2(4);
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(4); w0(0xff); w2(6);
+	w2(4); w0(0xaa); w2(6);
+	w2(4); w0(0x00); w2(6);
+	w2(4); w0(0x87); w2(6);
+	w2(4); w0(0xe0); w2(0xc); w2(0xc); w2(4);
 }
 
 static void comm_disconnect(struct pi_adapter *pi)
 
-{       w2(0); w2(0); w2(0); w2(4); 
+{
+	w2(0); w2(0); w2(0); w2(4);
 	w0(pi->saved_r0);
-        w2(pi->saved_r2);
-} 
+	w2(pi->saved_r2);
+}
 
 static void comm_read_block(struct pi_adapter *pi, char *buf, int count)
-
-{       int     i, l, h;
-
-        switch (pi->mode) {
-        
-        case 0: w0(0x48); P1;
-                for(i=0;i<count;i++) {
-                        w0(0); w2(6); l = r1();
-                        w0(0x80); h = r1(); w2(4);
-                        buf[i] = j44(l,h);
-                }
-                break;
-
-        case 1: w0(0x68); P1; w0(0);
-                for(i=0;i<count;i++) {
-                        w2(0x26); buf[i] = r0(); w2(0x24);
-                }
+{
+	int i, l, h;
+
+	switch (pi->mode) {
+	case 0:
+		w0(0x48); P1;
+		for (i = 0; i < count; i++) {
+			w0(0); w2(6); l = r1();
+			w0(0x80); h = r1(); w2(4);
+			buf[i] = j44(l, h);
+		}
+		break;
+	case 1:
+		w0(0x68); P1; w0(0);
+		for (i = 0; i < count; i++) {
+			w2(0x26);
+			buf[i] = r0();
+			w2(0x24);
+		}
 		w2(4);
 		break;
-		
-	case 2: w3(0x68); (void)r1(); w2(0x24);
-		for (i=0;i<count;i++) buf[i] = r4();
+	case 2:
+		w3(0x68); (void)r1(); w2(0x24);
+		for (i = 0; i < count; i++)
+			buf[i] = r4();
+		w2(4);
+		break;
+	case 3:
+		w3(0x68); (void)r1(); w2(0x24);
+		for (i = 0; i < count / 2; i++)
+			((u16 *)buf)[i] = r4w();
+		w2(4);
+		break;
+	case 4:
+		w3(0x68); (void)r1(); w2(0x24);
+		for (i = 0; i < count / 4; i++)
+			((u32 *)buf)[i] = r4l();
 		w2(4);
 		break;
-
-        case 3: w3(0x68); (void)r1(); w2(0x24);
-                for (i=0;i<count/2;i++) ((u16 *)buf)[i] = r4w();
-                w2(4);
-                break;
-
-        case 4: w3(0x68); (void)r1(); w2(0x24);
-                for (i=0;i<count/4;i++) ((u32 *)buf)[i] = r4l();
-                w2(4);
-                break;
-		
 	}
 }
 
 /* NB: Watch out for the byte swapped writes ! */
-
 static void comm_write_block(struct pi_adapter *pi, char *buf, int count)
-
-{       int	k;
-
-        switch (pi->mode) {
-
-        case 0:
-        case 1: w0(0x68); P1;
-        	for (k=0;k<count;k++) {
-                        w2(5); w0(buf[k^1]); w2(7);
-                }
-                w2(5); w2(4);
-                break;
-
-        case 2: w3(0x48); (void)r1();
-                for (k=0;k<count;k++) w4(buf[k^1]);
-                break;
-
-        case 3: w3(0x48); (void)r1();
+{
+	int k;
+
+	switch (pi->mode) {
+	case 0:
+	case 1:
+		w0(0x68); P1;
+		for (k = 0; k < count; k++) {
+			w2(5);
+			w0(buf[k ^ 1]);
+			w2(7);
+		}
+		w2(5); w2(4);
+		break;
+	case 2:
+		w3(0x48); (void)r1();
+		for (k = 0; k < count; k++)
+			w4(buf[k ^ 1]);
+		break;
+	case 3:
+		w3(0x48); (void)r1();
 		for (k = 0; k < count / 2; k++)
 			w4w(swab16(((u16 *)buf)[k]));
-                break;
-
-        case 4: w3(0x48); (void)r1();
+		break;
+	case 4:
+		w3(0x48); (void)r1();
 		for (k = 0; k < count / 4; k++)
 			w4l(swab16(((u16 *)buf)[2 * k]) |
 			    swab16(((u16 *)buf)[2 * k + 1]) << 16);
-                break;
-
-
+		break;
         }
 }
 
 static void comm_log_adapter(struct pi_adapter *pi)
 
-{       char    *mode_string[5] = {"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
+{       char *mode_string[5] = { "4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
 
-	dev_info(&pi->dev, "DataStor Commuter at 0x%x, mode %d (%s), delay %d\n",
-		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+	dev_info(&pi->dev,
+		 "DataStor Commuter at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol comm = {
-- 
2.40.1

