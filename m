Return-Path: <SRS0=7pxr=6W=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E8EC38A2A
	for <linux-ide@archiver.kernel.org>; Fri,  8 May 2020 05:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873B120870
	for <linux-ide@archiver.kernel.org>; Fri,  8 May 2020 05:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgEHFy5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 8 May 2020 01:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgEHFy5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 8 May 2020 01:54:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29E2C05BD43
        for <linux-ide@vger.kernel.org>; Thu,  7 May 2020 22:54:56 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jWvyJ-0008Mt-HJ; Fri, 08 May 2020 07:54:55 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jWvyI-0002DP-Ux; Fri, 08 May 2020 07:54:54 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] ata: sata_nv: use enum values as array indeces
Date:   Fri,  8 May 2020 07:54:52 +0200
Message-Id: <20200508055452.8469-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-ide@vger.kernel.org
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Positions of the entries in nv_port_info[] must be consistent to enum
nv_host_type. Ensure this by using the enum as array index directly.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/ata/sata_nv.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 20190f66ced9..25c53fa17b33 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -520,8 +520,7 @@ struct nv_pi_priv {
 	&(struct nv_pi_priv){ .irq_handler = _irq_handler, .sht = _sht }
 
 static const struct ata_port_info nv_port_info[] = {
-	/* generic */
-	{
+	[GENERIC] = {
 		.flags		= ATA_FLAG_SATA,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
@@ -529,8 +528,7 @@ static const struct ata_port_info nv_port_info[] = {
 		.port_ops	= &nv_generic_ops,
 		.private_data	= NV_PI_PRIV(nv_generic_interrupt, &nv_sht),
 	},
-	/* nforce2/3 */
-	{
+	[NFORCE2] = {
 		.flags		= ATA_FLAG_SATA,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
@@ -538,8 +536,7 @@ static const struct ata_port_info nv_port_info[] = {
 		.port_ops	= &nv_nf2_ops,
 		.private_data	= NV_PI_PRIV(nv_nf2_interrupt, &nv_sht),
 	},
-	/* ck804 */
-	{
+	[CK804] = {
 		.flags		= ATA_FLAG_SATA,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
@@ -547,8 +544,7 @@ static const struct ata_port_info nv_port_info[] = {
 		.port_ops	= &nv_ck804_ops,
 		.private_data	= NV_PI_PRIV(nv_ck804_interrupt, &nv_sht),
 	},
-	/* ADMA */
-	{
+	[ADMA] = {
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NCQ,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
@@ -556,8 +552,7 @@ static const struct ata_port_info nv_port_info[] = {
 		.port_ops	= &nv_adma_ops,
 		.private_data	= NV_PI_PRIV(nv_adma_interrupt, &nv_adma_sht),
 	},
-	/* MCP5x */
-	{
+	[MCP5x] = {
 		.flags		= ATA_FLAG_SATA,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
@@ -565,8 +560,7 @@ static const struct ata_port_info nv_port_info[] = {
 		.port_ops	= &nv_generic_ops,
 		.private_data	= NV_PI_PRIV(nv_generic_interrupt, &nv_sht),
 	},
-	/* SWNCQ */
-	{
+	[SWNCQ] = {
 		.flags	        = ATA_FLAG_SATA | ATA_FLAG_NCQ,
 		.pio_mask	= NV_PIO_MASK,
 		.mwdma_mask	= NV_MWDMA_MASK,
-- 
2.26.2

