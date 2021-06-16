Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5BBC48BE5
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 13:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BB161356
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 13:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhFPNvf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhFPNvd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2021 09:51:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFB4C061574;
        Wed, 16 Jun 2021 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FMWvGRuwohYEWT60Xs3SNXFuVN9yohix5OohuODqhyc=; b=br6x+NzkKsABPjh4jOMQRt+Zjs
        gkdBwBVrSRYcH9YV1BCMRs6gxXgSvR4t+dk0VfWfxUcx2En6qoLLVbtkpsJIn8zYOSX5MaFnlf+AC
        s4BYfkNSUFiHCLm3ZcCww+RvneOVfXyAfuLBX8amyd9zZemo0reYeT2uJr9azat6P9I9CsNHEEdDZ
        CmwHfSySJeALbsd4d3uhC5pUpUHCINLOSsFRnpY5MZElh0Sb9XXS+5tAA1bhHNBsOeGDIaPOD+Rid
        n5k0mgTuzhGTEIpQR22LwdrLS1wcqaP8RQrmNjGMsTfgGhT6EX79eRjnXHZhxYh+/Ozc7L4iXfFCL
        EWgrOXcA==;
Received: from [2001:4bb8:19b:fdce:84d:447:81f0:ca60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltVu1-0085zL-Mk; Wed, 16 Jun 2021 13:48:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 3/6] ARM: disable CONFIG_IDE in footbridge_defconfig
Date:   Wed, 16 Jun 2021 15:46:55 +0200
Message-Id: <20210616134658.1471835-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616134658.1471835-1-hch@lst.de>
References: <20210616134658.1471835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

footbridge_defconfig enables CONFIG_IDE but no actual host controller
driver, so just drop it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/configs/footbridge_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 2aa3ebeb89d7..7a32de51f0fa 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -64,7 +64,6 @@ CONFIG_PARIDE_ON26=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_IDE=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_VENDOR_3COM=y
-- 
2.30.2

