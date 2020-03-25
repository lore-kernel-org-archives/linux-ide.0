Return-Path: <SRS0=f0ic=5K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46E4C43331
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 23:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DD520714
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 23:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCYX7a (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:59:30 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51254 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgCYX73 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 25 Mar 2020 19:59:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 25A7A1A0725;
        Thu, 26 Mar 2020 00:59:28 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E33671A0705;
        Thu, 26 Mar 2020 00:59:27 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 2898F4040F;
        Wed, 25 Mar 2020 16:59:27 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [linux-next PATCH] ata: sata_fsl: fix a compile error
Date:   Wed, 25 Mar 2020 18:59:21 -0500
Message-Id: <20200325235921.22431-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

drivers/ata/sata_fsl.c: In function 'sata_fsl_init_controller':
drivers/ata/sata_fsl.c:1365:15: error: 'ap' undeclared (first use in this function)
  ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
               ^

Fixes: b3f06231 ("sata_fsl: move DPRINTK to ata debugging")

Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/ata/sata_fsl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 45c15c4e9f8a..c43a97d63e6c 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1340,6 +1340,7 @@ static int sata_fsl_init_controller(struct ata_host *host)
 {
 	struct sata_fsl_host_priv *host_priv = host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
+	struct ata_port *ap = host->ports[0];
 	u32 temp;
 
 	/*
-- 
2.17.1

