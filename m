Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC0EC71153
	for <linux-ide@archiver.kernel.org>; Mon,  4 Sep 2023 20:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjIDUCN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 4 Sep 2023 16:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjIDUCN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Sep 2023 16:02:13 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Sep 2023 13:02:10 PDT
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B93BBD
        for <linux-ide@vger.kernel.org>; Mon,  4 Sep 2023 13:02:10 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id dFefqC0Qrv5KTdFegqYMk4; Mon, 04 Sep 2023 21:54:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693857278;
        bh=S1+Rkq+ROd/7LSdXHx0aBQcEpBzXY0817GAhloPvxCk=;
        h=From:To:Cc:Subject:Date;
        b=rLTpoOqY0dmETWh4mpir9NldYiYrRCXA+2Q4dYXexIdb1wn+DpUS838TIf6k5V3mq
         9NVp4sQbuWo1ouYxxs/5zZazgopPg2leDo1alKzPv5L7U/ePAJOXsnzPhko3Ly6STa
         jqwHwcQyiakU9rniBTYLTMfeLCRBP2KpQgaT84s1mmK8gbJuBUadJwPsheXwP5/OrP
         sFtIWhU8I2qNSyvH1ffNb3L0oFMSNchAvMv3yNQkdnJ0iZXRlyCMFIr/r6ePcV2ZPp
         3d+Sjzcw/wCePPEBFCJePhOoqhOElwOVXbJ00QLweLCTXl5YJ1wWNqN7nRYv2eSZog
         jsQSgbNd1JzBg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 04 Sep 2023 21:54:38 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-ide@vger.kernel.org
Subject: [PATCH] ata: sata_mv: Fix incorrect string length computation in mv_dump_mem()
Date:   Mon,  4 Sep 2023 21:54:36 +0200
Message-Id: <1a35e114a3dcc33053ca7cca41cb06b8426d8c40.1693857262.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

snprintf() returns the "number of characters which *would* be generated for
the given input", not the size *really* generated.

In order to avoid too large values for 'o' (and potential negative values
for "sizeof(linebuf) o") use scnprintf() instead of snprintf().

Note that given the "w < 4" in the for loop, the buffer can NOT
overflow, but using the *right* function is always better.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/ata/sata_mv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index d105db5c7d81..45e48d653c60 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1255,8 +1255,8 @@ static void mv_dump_mem(struct device *dev, void __iomem *start, unsigned bytes)
 
 	for (b = 0; b < bytes; ) {
 		for (w = 0, o = 0; b < bytes && w < 4; w++) {
-			o += snprintf(linebuf + o, sizeof(linebuf) - o,
-				      "%08x ", readl(start + b));
+			o += scnprintf(linebuf + o, sizeof(linebuf) - o,
+				       "%08x ", readl(start + b));
 			b += sizeof(u32);
 		}
 		dev_dbg(dev, "%s: %p: %s\n",
-- 
2.34.1

