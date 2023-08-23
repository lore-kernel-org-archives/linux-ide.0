Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE54C3DA6F
	for <linux-ide@archiver.kernel.org>; Wed, 23 Aug 2023 22:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbjHWWwx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Aug 2023 18:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbjHWWwk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Aug 2023 18:52:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B7C1AD
        for <linux-ide@vger.kernel.org>; Wed, 23 Aug 2023 15:52:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 912E5639F3
        for <linux-ide@vger.kernel.org>; Wed, 23 Aug 2023 22:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5128CC433C8;
        Wed, 23 Aug 2023 22:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692831157;
        bh=IpiebaQwflq2c24uSd60kjn7ZQ7qw8zQ7PBoEryojh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oH6mkeZd1/96o8FfgOZ4/eaTBzSiH9nGCR1vqN5JLeTcpMe8ualwyYs6+sN6X7RAw
         mlJ5GE3igAJTUP7g7nR25wurIeRKW6jDri0Igas5rOBzCfuQhqW5Ja3xwwZREMGrtA
         MkSUSjGLdowjf3IrKwnf2brcDvRI2+WtOj5lIj5aOMA2IbootKFPavCmnnzHJWHfzj
         O19RdBdxRaAtxI8JKxzwGmZ2aHdUo7ft9fJTLk7bI69r5bNV/G9rO/+wbUZTaBQzoY
         zfglQypoR+MemHCIzfkWvLHbl+atFyGiWhIkW5Yv7pgqQD9WnzJgrQavWWNd6whnS/
         pbl/md4lioaog==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 2/2] ata: sata_gemini: Add missing MODULE_DESCRIPTION
Date:   Thu, 24 Aug 2023 07:52:33 +0900
Message-ID: <20230823225234.36354-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823225234.36354-1-dlemoal@kernel.org>
References: <20230823225234.36354-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add the missing MODULE_DESCRIPTION() to avoid warnings such as:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/ata/sata_gemini.o

when compiling with W=1.

Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/sata_gemini.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 6bc3bffa83cd..400b22ee99c3 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -425,6 +425,7 @@ static struct platform_driver gemini_sata_driver = {
 };
 module_platform_driver(gemini_sata_driver);
 
+MODULE_DESCRIPTION("low level driver for Cortina Systems Gemini SATA bridge");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.41.0

