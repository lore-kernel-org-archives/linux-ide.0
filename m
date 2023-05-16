Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63196C7EE2A
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjEPNH2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjEPNGz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71DB4EE7
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17C82639FD
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEC3C4339B;
        Tue, 16 May 2023 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242381;
        bh=WjDT+9TngP4ymQ+niuDR6TaYLchWafGNrzBsDXiY8EI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDvnOUMSP58os4yyZ0srD2ySgt96AHZxVUBAx5QQfpZmwxDiixb6CVKZNyezO/UtZ
         Jfxf6xDXLz4ZqtPX0eKGcwH1AKNYR4OgvaNs3VGN409+0ZYbyDCLQ61M93XZ4zINSr
         Yc8zAUUxpIkjd92+uYdKmu9xBg9CvbchpVLawkmI/hvE0ZKpHoSg4XvvHy04AdUCJi
         oC85zLDukhXpZr+5xu1eMHM7l1D8udcrOq02UdNDLlKyxdtOoeLGysRg4nWU9sau63
         3lshupr5Cq0aO7nvkE6lmDNVF3qFF0BojL+pZvfrin1OfPTqPTbdsKzzE0CQ2j2bhG
         W/Du08IQsV6jA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 12/13] ata: pata_parport: Fix on20 module code indentation and style
Date:   Tue, 16 May 2023 22:06:10 +0900
Message-Id: <20230516130611.109932-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the on20 pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/on20.c | 149 ++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 67 deletions(-)

diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
index 276ace12d490..34e69da2bec8 100644
--- a/drivers/ata/pata_parport/on20.c
+++ b/drivers/ata/pata_parport/on20.c
@@ -1,10 +1,10 @@
-/* 
-	on20.c	(c) 1996-8  Grant R. Guenther <grant@torque.net>
-		            Under the terms of the GNU General Public License.
-
-        on20.c is a low-level protocol driver for the
-        Onspec 90c20 parallel to IDE adapter. 
-*/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (c) 1996-1998  Grant R. Guenther <grant@torque.net>
+ *
+ * on20.c is a low-level protocol driver for the
+ * Onspec 90c20 parallel to IDE adapter.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -15,99 +15,114 @@
 #include <asm/io.h>
 #include "pata_parport.h"
 
-#define op(f)	w2(4);w0(f);w2(5);w2(0xd);w2(5);w2(0xd);w2(5);w2(4);
-#define vl(v)	w2(4);w0(v);w2(5);w2(7);w2(5);w2(4);
-
-#define j44(a,b)  (((a>>4)&0x0f)|(b&0xf0))
-
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
-*/
-
-static int on20_read_regr(struct pi_adapter *pi, int cont, int regr)
-
-{	int h,l, r ;
+#define op(f)					\
+	do {					\
+		w2(4); w0(f); w2(5); w2(0xd);	\
+		w2(5); w2(0xd); w2(5); w2(4);	\
+	} while (0)
 
-        r = (regr<<2) + 1 + cont;
+#define vl(v)					\
+	do {					\
+		w2(4); w0(v); w2(5);		\
+		w2(7); w2(5); w2(4);		\
+	} while (0)
 
-        op(1); vl(r); op(0);
+#define j44(a, b)	(((a >> 4) & 0x0f) | (b & 0xf0))
 
-	switch (pi->mode)  {
-
-        case 0:  w2(4); w2(6); l = r1();
-                 w2(4); w2(6); h = r1();
-                 w2(4); w2(6); w2(4); w2(6); w2(4);
-		 return j44(l,h);
-
-	case 1:  w2(4); w2(0x26); r = r0(); 
-                 w2(4); w2(0x26); w2(4);
-		 return r;
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
 
+static int on20_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int h, l, r;
+
+	r = (regr << 2) + 1 + cont;
+
+	op(1); vl(r); op(0);
+
+	switch (pi->mode) {
+	case 0:
+		w2(4); w2(6); l = r1();
+		w2(4); w2(6); h = r1();
+		w2(4); w2(6); w2(4); w2(6); w2(4);
+		return j44(l, h);
+	case 1:
+		w2(4); w2(0x26); r = r0();
+		w2(4); w2(0x26); w2(4);
+		return r;
 	}
+
 	return -1;
-}	
+}
 
 static void on20_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = (regr << 2) + 1 + cont;
 
-{	int r;
-
-	r = (regr<<2) + 1 + cont;
-
-	op(1); vl(r); 
-	op(0); vl(val); 
+	op(1); vl(r);
+	op(0); vl(val);
 	op(0); vl(val);
 }
 
 static void on20_connect(struct pi_adapter *pi)
-
-{	pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
-
-	w2(4);w0(0);w2(0xc);w2(4);w2(6);w2(4);w2(6);w2(4); 
-	if (pi->mode) { op(2); vl(8); op(2); vl(9); }
-	       else   { op(2); vl(0); op(2); vl(8); }
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+
+	w2(4); w0(0); w2(0xc); w2(4); w2(6); w2(4); w2(6); w2(4);
+	if (pi->mode) {
+		op(2); vl(8); op(2); vl(9);
+	} else {
+		op(2); vl(0); op(2); vl(8);
+	}
 }
 
 static void on20_disconnect(struct pi_adapter *pi)
-
-{	w2(4);w0(7);w2(4);w2(0xc);w2(4);
-        w0(pi->saved_r0);
-        w2(pi->saved_r2);
-} 
+{
+	w2(4); w0(7); w2(4); w2(0xc); w2(4);
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
 
 static void on20_read_block(struct pi_adapter *pi, char *buf, int count)
-
-{	int     k, l, h; 
+{
+	int k, l, h;
 
 	op(1); vl(1); op(0);
 
-	for (k=0;k<count;k++) 
-	    if (pi->mode) {
-		w2(4); w2(0x26); buf[k] = r0();
-	    } else {
-		w2(6); l = r1(); w2(4);
-		w2(6); h = r1(); w2(4);
-		buf[k] = j44(l,h);
-	    }
+	for (k = 0; k < count; k++) {
+		if (pi->mode) {
+			w2(4); w2(0x26); buf[k] = r0();
+		} else {
+			w2(6); l = r1(); w2(4);
+			w2(6); h = r1(); w2(4);
+			buf[k] = j44(l, h);
+		}
+	}
 	w2(4);
 }
 
 static void on20_write_block(struct pi_adapter *pi, char *buf, int count)
-
-{	int	k;
+{
+	int k;
 
 	op(1); vl(1); op(0);
 
-	for (k=0;k<count;k++) { w2(5); w0(buf[k]); w2(7); }
+	for (k = 0; k < count; k++) {
+		w2(5); w0(buf[k]); w2(7);
+	}
 	w2(4);
 }
 
 static void on20_log_adapter(struct pi_adapter *pi)
+{
+	char *mode_string[2] = { "4-bit", "8-bit" };
 
-{       char    *mode_string[2] = {"4-bit","8-bit"};
-
-	dev_info(&pi->dev, "OnSpec 90c20 at 0x%x, mode %d (%s), delay %d\n",
-		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+	dev_info(&pi->dev,
+		 "OnSpec 90c20 at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol on20 = {
-- 
2.40.1

