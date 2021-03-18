Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A37FC433DB
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 04:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D2464F24
	for <linux-ide@archiver.kernel.org>; Thu, 18 Mar 2021 04:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhCRE7K (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 18 Mar 2021 00:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhCRE66 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2021 00:58:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3DC06174A;
        Wed, 17 Mar 2021 21:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=L1MdjYTi2n4oXruPPLItSIBx3Lt+VryCl8tiBAxtv8E=; b=IwrMxVNnBxFU+AM3P+h/O02Qu5
        ej+Isb+8oFBXMas7NoyhmcN57AoPpjTq2JYmDkCMPaOU/8XjGWpLCrGiJXYGytxI9VLhyUebC5x1I
        FXGC1A9E1LzUSGfl3Y1UjsD5/pd7k9gmcPwzQIeaqgSIGc56Q6F/w/MwSdE/Pd8YeEXDtTPaKsDkm
        9tBX+n+9EPqc6HLYuduN0LInArssnhvxs8j073YQAA4ckQnYycYlvRjLXL9r+XdQjBYZ5Y0ZH95Ua
        4B5SiGcc6fDLwevh6/v/74ldAdndgHhemIdLi7xIyWIzej1xDZWpaWsN6eO5N5gb9f7DsaOrz+ULQ
        zv40puSg==;
Received: from [2001:4bb8:18c:bb3:e1cf:ad2f:7ff7:7a0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMkjO-002ZEw-OJ; Thu, 18 Mar 2021 04:58:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/10] MIPS: disable CONFIG_IDE in sb1250_swarm_defconfig
Date:   Thu, 18 Mar 2021 05:57:00 +0100
Message-Id: <20210318045706.200458-5-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210318045706.200458-1-hch@lst.de>
References: <20210318045706.200458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

sb1250_swarm_defconfig enables CONFIG_IDE but no actual host controller
driver, so just drop CONFIG_IDE, CONFIG_BLK_DEV_IDECD and
CONFIG_BLK_DEV_IDETAPE as they are useless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/configs/sb1250_swarm_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index bb0b1b22ebe164..96a94ebf05bf08 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -49,9 +49,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=9220
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_IDETAPE=y
 CONFIG_RAID_ATTRS=m
 CONFIG_NETDEVICES=y
 CONFIG_MACVLAN=m
-- 
2.30.1

