Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0434AC77B75
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjEPNGx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjEPNGg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246DB83E1
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71794639DF
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745D6C433D2;
        Tue, 16 May 2023 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242373;
        bh=5ExuRmJHLwUVBlHSSL9kB19gJJw9WQAfrRBZY3af0zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXohbSI+zrq0ELjR7aSDat3IVSBkhL+pDaWak29lp0z9IyF37kpqJuHdMJC/4szzW
         XwDt8LKXXolRm12tFxabw7CCgvmppusX3NIkDpgteJQJqi6EoWJlSidoi3BfWD8sfX
         prekWxTEY/qITV/Sa1uOeCfvH+qlCqPygvCrveyknNc90sCYBEzo5gGnx1vMXkncNf
         GAV7GpYBb9iOsWBgwr8SBIWESJsO1/sOWRlrLno0LtmVZ7ZU/z4WSpVGt2oEbeeyoV
         e8bZ1o5CxpTDPshgWW82OqLtoqaKbmhLQaSuUbEAf1B1EsO36ILny4jwf+Tv8DeAP1
         Z4oGMJQ97x7MQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 01/13] ata: pata_parport: Fix aten module code indentation and style
Date:   Tue, 16 May 2023 22:05:59 +0900
Message-Id: <20230516130611.109932-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the aten pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/aten.c | 103 ++++++++++++++++----------------
 1 file changed, 53 insertions(+), 50 deletions(-)

diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
index 1bd248c42f8b..8328a49a95ef 100644
--- a/drivers/ata/pata_parport/aten.c
+++ b/drivers/ata/pata_parport/aten.c
@@ -1,13 +1,12 @@
-/* 
-        aten.c  (c) 1997-8  Grant R. Guenther <grant@torque.net>
-                            Under the terms of the GNU General Public License.
-
-	aten.c is a low-level protocol driver for the ATEN EH-100
-	parallel port adapter.  The EH-100 supports 4-bit and 8-bit
-        modes only.  There is also an EH-132 which supports EPP mode
-        transfers.  The EH-132 is not yet supported.
-
-*/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (c) 1997-8  Grant R. Guenther <grant@torque.net>
+ *
+ * aten.c is a low-level protocol driver for the ATEN EH-100
+ * parallel port adapter.  The EH-100 supports 4-bit and 8-bit
+ * modes only.  There is also an EH-132 which supports EPP mode
+ * transfers.  The EH-132 is not yet supported.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -20,36 +19,36 @@
 
 #define j44(a,b)                ((((a>>4)&0x0f)|(b&0xf0))^0x88)
 
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
-*/
-
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
 static int  cont_map[2] = { 0x08, 0x20 };
 
 static void aten_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
-
-{	int r;
-
-	r = regr + cont_map[cont] + 0x80;
+{
+	int r = regr + cont_map[cont] + 0x80;
 
 	w0(r); w2(0xe); w2(6); w0(val); w2(7); w2(6); w2(0xc);
 }
 
 static int aten_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int  a, b, r;
 
-{	int  a, b, r;
-
-        r = regr + cont_map[cont] + 0x40;
+	r = regr + cont_map[cont] + 0x40;
 
 	switch (pi->mode) {
 
-        case 0: w0(r); w2(0xe); w2(6); 
+	case 0:
+		w0(r); w2(0xe); w2(6);
 		w2(7); w2(6); w2(0);
 		a = r1(); w0(0x10); b = r1(); w2(0xc);
 		return j44(a,b);
 
-        case 1: r |= 0x10;
-		w0(r); w2(0xe); w2(6); w0(0xff); 
+	case 1:
+		r |= 0x10;
+		w0(r); w2(0xe); w2(6); w0(0xff);
 		w2(0x27); w2(0x26); w2(0x20);
 		a = r0();
 		w2(0x26); w2(0xc);
@@ -59,27 +58,30 @@ static int aten_read_regr(struct pi_adapter *pi, int cont, int regr)
 }
 
 static void aten_read_block(struct pi_adapter *pi, char *buf, int count)
-
-{	int  k, a, b, c, d;
+{
+	int  k, a, b, c, d;
 
 	switch (pi->mode) {
 
-	case 0:	w0(0x48); w2(0xe); w2(6);
-		for (k=0;k<count/2;k++) {
+	case 0:
+		w0(0x48); w2(0xe); w2(6);
+		for (k = 0; k < count / 2; k++) {
 			w2(7); w2(6); w2(2);
 			a = r1(); w0(0x58); b = r1();
 			w2(0); d = r1(); w0(0x48); c = r1();
-			buf[2*k] = j44(c,d);
-			buf[2*k+1] = j44(a,b);
+			buf[2 * k] = j44(c, d);
+			buf[2 * k + 1] = j44(a, b);
 		}
 		w2(0xc);
 		break;
 
-	case 1: w0(0x58); w2(0xe); w2(6);
-		for (k=0;k<count/2;k++) {
+	case 1:
+		w0(0x58); w2(0xe); w2(6);
+		for (k = 0; k < count / 2; k++) {
 			w2(0x27); w2(0x26); w2(0x22);
 			a = r0(); w2(0x20); b = r0();
-			buf[2*k] = b; buf[2*k+1] = a;
+			buf[2 * k] = b;
+			buf[2 * k + 1] = a;
 		}
 		w2(0x26); w2(0xc);
 		break;
@@ -87,36 +89,37 @@ static void aten_read_block(struct pi_adapter *pi, char *buf, int count)
 }
 
 static void aten_write_block(struct pi_adapter *pi, char *buf, int count)
-
-{	int k;
+{
+	int k;
 
 	w0(0x88); w2(0xe); w2(6);
-	for (k=0;k<count/2;k++) {
-		w0(buf[2*k+1]); w2(0xe); w2(6);
-		w0(buf[2*k]); w2(7); w2(6);
+	for (k = 0; k < count / 2; k++) {
+		w0(buf[2 * k + 1]); w2(0xe); w2(6);
+		w0(buf[2 * k]); w2(7); w2(6);
 	}
 	w2(0xc);
 }
 
 static void aten_connect(struct pi_adapter *pi)
-
-{       pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
-	w2(0xc);	
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(0xc);
 }
 
 static void aten_disconnect(struct pi_adapter *pi)
-
-{       w0(pi->saved_r0);
-        w2(pi->saved_r2);
-} 
+{
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
+}
 
 static void aten_log_adapter(struct pi_adapter *pi)
+{
+	char *mode_string[2] = { "4-bit", "8-bit" };
 
-{       char    *mode_string[2] = {"4-bit","8-bit"};
-
-	dev_info(&pi->dev, "ATEN EH-100 at 0x%x, mode %d (%s), delay %d\n",
-		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+	dev_info(&pi->dev,
+		 "ATEN EH-100 at 0x%x, mode %d (%s), delay %d\n",
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol aten = {
-- 
2.40.1

