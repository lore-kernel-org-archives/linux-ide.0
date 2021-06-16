Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497B5C48BE8
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 13:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3586115B
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 13:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhFPNuf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhFPNub (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2021 09:50:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E29C061574;
        Wed, 16 Jun 2021 06:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Z+oR1lwZ5IVn0dnTrGxb+exbJ0+qehkMzxmqgtGxNvI=; b=RAwvMhDSv5zEPuUFnlcjK0EpWx
        7ELUChd4L54thQuMRzOg2zfS9RqpTgw/vyBawI9J7tgEeEXISKTcbroT/wmiPeYf0srNgEQ4u+h5d
        2R70JlxF7sTRJkUBKF97ugLWAKjTqTocZhJhtw+a0g6kJsxwdIHpPTsZSD5brN33mdE3cFB1bAjGp
        A2qb42n8QRUl3Nvj5f8tWzrZpySKjz7AlZeIBVLWdWqvVkAgzzJ39derG3lZVGmLhUMjOH00AYvCF
        VuMwmfMZzxHwbZzJodWg0WqVn9qi5ea5T9rFE/NX7klFU2acZfny9mUMnGrY9suphG97KLwMrsJJp
        v3rgGvTw==;
Received: from [2001:4bb8:19b:fdce:84d:447:81f0:ca60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltVtJ-0085vk-MB; Wed, 16 Jun 2021 13:47:45 +0000
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
Subject: [PATCH 2/6] alpha: use libata instead of the legacy ide driver
Date:   Wed, 16 Jun 2021 15:46:54 +0200
Message-Id: <20210616134658.1471835-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616134658.1471835-1-hch@lst.de>
References: <20210616134658.1471835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Switch the alpha defconfig from the legacy ide driver to libata.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/configs/defconfig | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/configs/defconfig b/arch/alpha/configs/defconfig
index 724c4075df40..dd2dd9f0861f 100644
--- a/arch/alpha/configs/defconfig
+++ b/arch/alpha/configs/defconfig
@@ -25,19 +25,18 @@ CONFIG_PNP=y
 CONFIG_ISAPNP=y
 CONFIG_BLK_DEV_FD=y
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_IDE_GENERIC=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_ALI15X3=y
-CONFIG_BLK_DEV_CMD64X=y
-CONFIG_BLK_DEV_CY82C693=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_AIC7XXX=m
 CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
 # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
+CONFIG_ATA=y
+# CONFIG_SATA_PMP is not set
+CONFIG_PATA_ALI=y
+CONFIG_PATA_CMD64X=y
+CONFIG_PATA_CYPRESS=y
+CONFIG_ATA_GENERIC=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
 CONFIG_NET_ETHERNET=y
-- 
2.30.2

