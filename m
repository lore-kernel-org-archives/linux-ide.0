Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D033C71153
	for <linux-ide@archiver.kernel.org>; Wed, 23 Aug 2023 22:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbjHWWwx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Aug 2023 18:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238852AbjHWWwj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Aug 2023 18:52:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA061A5
        for <linux-ide@vger.kernel.org>; Wed, 23 Aug 2023 15:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9FF263AB7
        for <linux-ide@vger.kernel.org>; Wed, 23 Aug 2023 22:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662D4C433C9;
        Wed, 23 Aug 2023 22:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692831157;
        bh=Ci6WSR+6wAD2dKpl+tA9pbSjFewcFg2oFUTZIbYPmm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrHRADnwHdsY3vg+VCOisdu1wpDV4JbzaQa1S+hJj2JbCGyKDKH5cIoyX+MVzn/LP
         llfL1Ti+h9VNZkTpJhsee3PKw06hMBM0SrLX4VL9aV60bk2JrYnHk0UEAHHUzGC7uS
         mdss1tTtBqD/RG2q/MhvgTWRJ/AxYOp1aNzhg4Rzl5+9qOLBQ0uIO9rtLc9J9uopMK
         BdKQRiQ6iVt0MTbj1EsFhxJ6EaTzeiqVHT+dnPXTcT2tXIvHZGQ7Aa56JFAAUELIBn
         t4eA9SvmViJSmC6HPAUuVdOf1oBPgQ5fxGT1gOWCu+WnMQ6YtQJhAPLQrCZZ+Z+hmS
         q1iPJ1TpoaNZQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-ide@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 1/2] ata: pata_ftide010: Add missing MODULE_DESCRIPTION
Date:   Thu, 24 Aug 2023 07:52:32 +0900
Message-ID: <20230823225234.36354-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823225234.36354-1-dlemoal@kernel.org>
References: <20230823225234.36354-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add the missing MODULE_DESCRIPTION() to avoid warnings such as:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/ata/pata_ftide010.o

when compiling with W=1.

Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/pata_ftide010.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index d77ee40115aa..4d6ef90ccc77 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -560,6 +560,7 @@ static struct platform_driver pata_ftide010_driver = {
 };
 module_platform_driver(pata_ftide010_driver);
 
+MODULE_DESCRIPTION("low level driver for Faraday Technology FTIDE010");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.41.0

