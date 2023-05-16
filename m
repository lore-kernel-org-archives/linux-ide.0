Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B473C7EE25
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjEPNH1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjEPNGz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB87D19D
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63A81639FE
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B18C433D2;
        Tue, 16 May 2023 13:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242380;
        bh=UNKXjjakTgeG0j49zR6q4PRblr8Z45RiiPZq7Xd7PMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pv2WkSM2V4bI+SPgTsiw+Li1MqLzVrjS4wdloZ2/CmBF8GxRC7Xn5sDcI+fyEgBRY
         gA+jbeyeYrfBf84FGE5WNEsoKRF3eBSk5GhD8/6vjZ4yEHwJw7j8KcX86OuCuOiU3k
         AF01Ot1PDvdrPKqwCZUar5r+fT7uLWjj/wMtu6wPXjlIMOiGgYjVixI9bGCEllrbSv
         mRcFCYZ6kgnagbL/KHPgynH4BXJuRdX1sc416CDUYWJFMBKJWL1d2xNQ7jw7SKaBAY
         VgwC5Dook7VPsSsoJ8+eyrx46j4mWW87W92QQm4uh4Sfzw+A5U+zd1Ixw6gj3TWrkk
         nhI07EHiTVyHw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 11/13] ata: pata_parport: Fix ktti module code indentation and style
Date:   Tue, 16 May 2023 22:06:09 +0900
Message-Id: <20230516130611.109932-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the ktti pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/ktti.c | 85 ++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
index 4890b1f12348..bca6c20ef617 100644
--- a/drivers/ata/pata_parport/ktti.c
+++ b/drivers/ata/pata_parport/ktti.c
@@ -1,12 +1,11 @@
-/* 
-        ktti.c        (c) 1998  Grant R. Guenther <grant@torque.net>
-                          Under the terms of the GNU General Public License.
-
-	ktti.c is a low-level protocol driver for the KT Technology
-	parallel port adapter.  This adapter is used in the "PHd" 
-        portable hard-drives.  As far as I can tell, this device
-	supports 4-bit mode _only_.  
-
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (c) 1998  Grant R. Guenther <grant@torque.net>
+ *
+ * ktti.c is a low-level protocol driver for the KT Technology
+ * parallel port adapter.  This adapter is used in the "PHd"
+ * portable hard-drives.  As far as I can tell, this device
+ * supports 4-bit mode _only_.
 */
 
 #include <linux/module.h>
@@ -18,80 +17,76 @@
 #include <asm/io.h>
 #include "pata_parport.h"
 
-#define j44(a,b)                (((a>>4)&0x0f)|(b&0xf0))
+#define j44(a, b)	(((a >> 4) & 0x0f) | (b & 0xf0))
 
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
-*/
-
-static int  cont_map[2] = { 0x10, 0x08 };
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
+static int cont_map[2] = { 0x10, 0x08 };
 
 static void ktti_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r = regr + cont_map[cont];
 
-{	int r;
-
-	r = regr + cont_map[cont];
-
-	w0(r); w2(0xb); w2(0xa); w2(3); w2(6); 
+	w0(r); w2(0xb); w2(0xa); w2(3); w2(6);
 	w0(val); w2(3); w0(0); w2(6); w2(0xb);
 }
 
 static int ktti_read_regr(struct pi_adapter *pi, int cont, int regr)
-
-{	int  a, b, r;
+{
+	int a, b, r;
 
         r = regr + cont_map[cont];
 
-        w0(r); w2(0xb); w2(0xa); w2(9); w2(0xc); w2(9); 
+	w0(r); w2(0xb); w2(0xa); w2(9); w2(0xc); w2(9);
 	a = r1(); w2(0xc);  b = r1(); w2(9); w2(0xc); w2(9);
-	return j44(a,b);
-
+	return j44(a, b);
 }
 
 static void ktti_read_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k, a, b;
 
-{	int  k, a, b;
-
-	for (k=0;k<count/2;k++) {
+	for (k = 0; k < count / 2; k++) {
 		w0(0x10); w2(0xb); w2(0xa); w2(9); w2(0xc); w2(9);
 		a = r1(); w2(0xc); b = r1(); w2(9);
-		buf[2*k] = j44(a,b);
+		buf[2*k] = j44(a, b);
 		a = r1(); w2(0xc); b = r1(); w2(9);
-		buf[2*k+1] = j44(a,b);
+		buf[2*k+1] = j44(a, b);
 	}
 }
 
 static void ktti_write_block(struct pi_adapter *pi, char *buf, int count)
+{
+	int k;
 
-{	int k;
-
-	for (k=0;k<count/2;k++) {
+	for (k = 0; k < count / 2; k++) {
 		w0(0x10); w2(0xb); w2(0xa); w2(3); w2(6);
-		w0(buf[2*k]); w2(3);
-		w0(buf[2*k+1]); w2(6);
+		w0(buf[2 * k]); w2(3);
+		w0(buf[2 * k + 1]); w2(6);
 		w2(0xb);
 	}
 }
 
 static void ktti_connect(struct pi_adapter *pi)
-
-{       pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
-	w2(0xb); w2(0xa); w0(0); w2(3); w2(6);	
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(0xb); w2(0xa); w0(0); w2(3); w2(6);
 }
 
 static void ktti_disconnect(struct pi_adapter *pi)
-
-{       w2(0xb); w2(0xa); w0(0xa0); w2(3); w2(4);
+{
+	w2(0xb); w2(0xa); w0(0xa0); w2(3); w2(4);
 	w0(pi->saved_r0);
-        w2(pi->saved_r2);
-} 
+	w2(pi->saved_r2);
+}
 
 static void ktti_log_adapter(struct pi_adapter *pi)
-
 {
 	dev_info(&pi->dev, "KT adapter at 0x%x, delay %d\n",
-		pi->port, pi->delay);
+		 pi->port, pi->delay);
 }
 
 static struct pi_protocol ktti = {
-- 
2.40.1

