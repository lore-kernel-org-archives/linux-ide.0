Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465FBC4332F
	for <linux-ide@archiver.kernel.org>; Sun, 13 Nov 2022 20:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiKMUeB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 13 Nov 2022 15:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiKMUeA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 13 Nov 2022 15:34:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B001262E;
        Sun, 13 Nov 2022 12:33:59 -0800 (PST)
Message-ID: <20221113202428.374088146@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668371638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GT/G9vK93mYpvzZdTpl6h6K4LTwENiZbMbRH6Qg8/+A=;
        b=i5ON7/T9CK+x6BaaPX0ib3fI7p5Xyl0PdQzaUz3wqpgNCMpJygjT8EOCpSIte1rmDZdT98
        Dxg9w2ACknjtLt5VOOg6V4UWlSGgfVW1m9t8hRkgT40X5Lzn0ZumV6XtvdYxH91U/aN4f7
        4bnsIosfAm3Jki1/JUbYXFE8w5/y0kR6zWoDp17xh7JMT8ObRvKRkW6rGYnt2tIEWYh4U8
        5aRYDDRfuuuzGkJ4g31NF2wsqzDqonuOkv1QLV0QUF1Et2rsPgJlVpkS62vm9uIFPYj+qV
        G1LCazcY8WhFUzMH6Bzy20Xnt61TRTOdtKUj1hyDHTDpdRvQ3UwSWsFyVA24CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668371638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GT/G9vK93mYpvzZdTpl6h6K4LTwENiZbMbRH6Qg8/+A=;
        b=91QWuMdBPKzbVai5jiM9l05feXw5wsOIcvebbKgZMv/lAnIPg8ReG3wJCUBWz+0QFe6vAq
        tf2jsE9ExI6bKUDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Subject: [patch 02/10] ata: ahci: Remove linux/msi.h include
References: <20221113201935.776707081@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 13 Nov 2022 21:33:57 +0100 (CET)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Nothing in this file needs anything from linux/msi.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/ahci.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -26,7 +26,6 @@
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/gfp.h>
-#include <linux/msi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>

