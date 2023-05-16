Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF67AC7EE25
	for <linux-ide@archiver.kernel.org>; Tue, 16 May 2023 13:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjEPNGx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 16 May 2023 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjEPNGh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2023 09:06:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1839868D
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 06:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DAED639E8
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2023 13:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293CBC4339B;
        Tue, 16 May 2023 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242374;
        bh=sYB3GlWUSLU70nkLo1kfFES/PdyvwXrF6yYUgb3x4c8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssVji+mTQwwt3Tl//3QPEOEcg/GRbUqTsfUVh//93yVhN0p6JtBRNMvEeqdbpB0GZ
         /mAWpctL49g9SLV/e7FKXCz7dkAZ/dmhizPp8HAJGEn6XMFmPZAjGDk79/BQnAKPhY
         XfxRg05wtUoQcV0A5m6OAmCfk+IdFS4lquk5Y3uMIw03NvhdOV8SJ6qzW6ZOOgadgS
         MDgOEjQsBghuG/sqB8oyoRg71KB6tf1YR+SoT5SO7xr1/6/RjFYkt/MzWJB0rB06Ui
         Xb57S0NnH8btlFpLWZ/+Av1Pg7S1R0Lrk6KESjRpm+nrKQglGfjuVqoXvI+gyBydMj
         9uReaPfO5s7xw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 02/13] ata: pata_parport: Fix bpck6 module code indentation and style
Date:   Tue, 16 May 2023 22:06:00 +0900
Message-Id: <20230516130611.109932-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516130611.109932-1-dlemoal@kernel.org>
References: <20230516130611.109932-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Fix the header, indentation and coding style in the bpck6 pata parport
protocol module to suppress warnings from smatch and other static code
analyzers.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_parport/bpck6.c | 67 +++++++++++++++++---------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 76febd07a9bb..c6dbd14120d1 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -1,15 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-	backpack.c (c) 2001 Micro Solutions Inc.
-		Released under the terms of the GNU General Public license
-
-	backpack.c is a low-level protocol driver for the Micro Solutions
-		"BACKPACK" parallel port IDE adapter
-		(Works on Series 6 drives)
-
-	Written by: Ken Hahn     (linux-dev@micro-solutions.com)
-	            Clive Turvey (linux-dev@micro-solutions.com)
-
-*/
+ * (c) 2001 Micro Solutions Inc.
+ *
+ * backpack.c is a low-level protocol driver for the Micro Solutions
+ * "BACKPACK" parallel port IDE adapter (works on Series 6 drives).
+ *
+ * Written by: Ken Hahn (linux-dev@micro-solutions.com)
+ *             Clive Turvey (linux-dev@micro-solutions.com)
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -326,11 +324,14 @@ static int bpck6_open(struct pi_adapter *pi)
 	if (j != k)
 		goto fail;
 
-	if (i & 4)	// EPP
+	if (i & 4) {
+		/* EPP */
 		parport_frob_control(pi->pardev->port,
 			PARPORT_CONTROL_SELECT | PARPORT_CONTROL_INIT, 0);
-	else				// PPC/ECP
+	} else {
+		/* PPC/ECP */
 		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT, 0);
+	}
 
 	pi->private = 0;
 
@@ -347,17 +348,20 @@ static int bpck6_open(struct pi_adapter *pi)
 	parport_write_control(pi->pardev->port, pi->saved_r2);
 	parport_write_data(pi->pardev->port, pi->saved_r0);
 
-	return 0; // FAIL
+	return 0;
 }
 
 static void bpck6_deselect(struct pi_adapter *pi)
 {
-	if (mode_map[pi->mode] & 4)	// EPP
+	if (mode_map[pi->mode] & 4) {
+		/* EPP */
 		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_INIT,
-							PARPORT_CONTROL_INIT);
-	else								// PPC/ECP
+				     PARPORT_CONTROL_INIT);
+	} else {
+		/* PPC/ECP */
 		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT,
-							PARPORT_CONTROL_SELECT);
+				     PARPORT_CONTROL_SELECT);
+	}
 
 	parport_write_data(pi->pardev->port, pi->saved_r0);
 	parport_write_control(pi->pardev->port,
@@ -386,7 +390,8 @@ static void bpck6_disconnect(struct pi_adapter *pi)
 	bpck6_deselect(pi);
 }
 
-static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
+/* check for 8-bit port */
+static int bpck6_test_port(struct pi_adapter *pi)
 {
 	dev_dbg(&pi->dev, "PARPORT indicates modes=%x for lp=0x%lx\n",
 		pi->pardev->port->modes, pi->pardev->port->base);
@@ -413,28 +418,26 @@ static int bpck6_probe_unit(struct pi_adapter *pi)
 
 	dev_dbg(&pi->dev, "ppc_open returned %2x\n", out);
 
-  	if(out)
- 	{
+	if (out) {
 		bpck6_deselect(pi);
 		dev_dbg(&pi->dev, "leaving probe\n");
 		pi->mode = saved_mode;
-               return(1);
+		return 1;
 	}
-  	else
-  	{
-		dev_dbg(&pi->dev, "Failed open\n");
-		pi->mode = saved_mode;
-    		return(0);
-  	}
+
+	dev_dbg(&pi->dev, "Failed open\n");
+	pi->mode = saved_mode;
+
+	return 0;
 }
 
 static void bpck6_log_adapter(struct pi_adapter *pi)
 {
-	char *mode_string[5]=
-		{"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
+	char *mode_string[5] = { "4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32" };
 
-	dev_info(&pi->dev, "Micro Solutions BACKPACK Drive unit %d at 0x%x, mode:%d (%s), delay %d\n",
-		pi->unit, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+	dev_info(&pi->dev,
+		 "Micro Solutions BACKPACK Drive unit %d at 0x%x, mode:%d (%s), delay %d\n",
+		 pi->unit, pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol bpck6 = {
-- 
2.40.1

