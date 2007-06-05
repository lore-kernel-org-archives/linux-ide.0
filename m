From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH] remove unused variable in pata_isapnp
Date: Tue, 5 Jun 2007 22:33:29 +0900
Message-ID: <20070605223329.5bdce4f0.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mfo31.po.2iij.net ([210.128.50.52]:16587 "EHLO
	mfo31.po.2iij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762155AbXFEOIj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jun 2007 10:08:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: yoichi_yuasa@tripeaks.co.jp

Hi,

This patch has removed unused variable in pata_ispnp.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/ata/pata_isapnp.c mips/drivers/ata/pata_isapnp.c
--- mips-orig/drivers/ata/pata_isapnp.c	2007-06-03 21:09:15.580982000 +0900
+++ mips/drivers/ata/pata_isapnp.c	2007-06-03 21:13:57.362592250 +0900
@@ -77,7 +77,6 @@ static int isapnp_init_one(struct pnp_de
 	struct ata_host *host;
 	struct ata_port *ap;
 	void __iomem *cmd_addr, *ctl_addr;
-	int rc;
 
 	if (pnp_port_valid(idev, 0) == 0)
 		return -ENODEV;
