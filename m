Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8652C433ED
	for <linux-ide@archiver.kernel.org>; Fri, 14 May 2021 21:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4D46143F
	for <linux-ide@archiver.kernel.org>; Fri, 14 May 2021 21:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhENVgE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 14 May 2021 17:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233163AbhENVgE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 14 May 2021 17:36:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68E22613C5;
        Fri, 14 May 2021 21:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621028092;
        bh=giFp79N7GzU5bE/Dhc1OIKO7f9yTRPmxlB6XSTEIJgI=;
        h=From:To:Cc:Subject:Date:From;
        b=mm0fiPkbvlCnEeQ0fEWQyGtvUD9HmKoctDfFdE5J+BM8mcNh9YD+tvMZhDf0Upmpp
         RSCh9ggbOMri8zRcCyZCxbxsTPZxUrvHDFenxwvT66BZWNkLU5Rx+O8Y2iMqNzLNwW
         RS/STUtwh4j/gLM35u2kPw764DMMN3Da2J0gS6d6aiEsJj6hDPi98RZInugSrh1kYq
         wIHqbkd7/Xya9IJNJH5J6dLprB+92ewXBzV1V0U6k6CXIzuPxXP489P7AxVZN1wNi4
         DPcRyT1OjguiOCOAj65hH12wDaWyhnqSijpjpU2GlrhSr/RUR2o8Wo2tSHOrirlb13
         O7Ze/mHkopdgw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sata: fsl: fix DPRINTK format string
Date:   Fri, 14 May 2021 23:33:57 +0200
Message-Id: <20210514213402.691436-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Printing an __iomem pointer as %x produces a warning:

drivers/ata/sata_fsl.c: In function 'fsl_sata_set_irq_coalescing':
drivers/ata/sata_fsl.c:316:17: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'void *' [-Werror=format=]
  316 |         DPRINTK("ICC register status: (hcr base: 0x%x) = 0x%x\n",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  317 |                         hcr_base, ioread32(hcr_base + ICC));
      |                         ~~~~~~~~
      |                         |
      |                         void *

It's not clear why that pointer should be printed here, but if we do,
then using %p is the way to avoid the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/sata_fsl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index d55ee244d693..e5838b23c9e0 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -313,7 +313,7 @@ static void fsl_sata_set_irq_coalescing(struct ata_host *host,
 
 	DPRINTK("interrupt coalescing, count = 0x%x, ticks = %x\n",
 			intr_coalescing_count, intr_coalescing_ticks);
-	DPRINTK("ICC register status: (hcr base: 0x%x) = 0x%x\n",
+	DPRINTK("ICC register status: (hcr base: %p) = 0x%x\n",
 			hcr_base, ioread32(hcr_base + ICC));
 }
 
-- 
2.29.2

