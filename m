Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11634C47094
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 09:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FA861182
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 09:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFJJcc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:32:32 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33290 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhFJJcc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jun 2021 05:32:32 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 495CE2C2D0; Thu, 10 Jun 2021 05:30:34 -0400 (EDT)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <16c5ed1120bfb7dcd64899c08d9ff36ad75f434d.1623317311.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] ide/falconide: Avoid build failure when CONFIG_ATARI=n
Date:   Thu, 10 Jun 2021 19:28:31 +1000
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When building the driver for a q40-only configuration, the atari-only code
has to be elided to avoid a linker error:

m68k-linux-ld: drivers/ide/falconide.o: in function `falconide_get_lock':
falconide.c:(.text+0x1c2): undefined reference to `stdma_lock'
m68k-linux-ld: drivers/ide/falconide.o: in function `falconide_release_lock':
falconide.c:(.text+0x20c): undefined reference to `stdma_release'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-m68k@lists.linux-m68k.org
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 9658506fbf8c ("m68k/q40: Replace q40ide driver with pata_falcon and falconide")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
This change relates to commit 9658506fbf8c ("m68k/q40: Replace q40ide driver
with pata_falcon and falconide") which is found on the for-5.14/libata branch
in Jens' repo. Therefore this 'fixes' tag is not yet relevant to mainline.
---
 drivers/ide/falconide.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ide/falconide.c b/drivers/ide/falconide.c
index fce68412b3c9..a73a9dc17e4d 100644
--- a/drivers/ide/falconide.c
+++ b/drivers/ide/falconide.c
@@ -25,6 +25,7 @@
 
 #define DRV_NAME "falconide"
 
+#ifdef CONFIG_ATARI
     /*
      *  falconide_intr_lock is used to obtain access to the IDE interrupt,
      *  which is shared between several drivers.
@@ -49,6 +50,7 @@ static void falconide_get_lock(irq_handler_t handler, void *data)
 		falconide_intr_lock = 1;
 	}
 }
+#endif
 
 static void falconide_input_data(ide_drive_t *drive, struct ide_cmd *cmd,
 				 void *buf, unsigned int len)
@@ -92,8 +94,10 @@ static const struct ide_tp_ops falconide_tp_ops = {
 };
 
 static const struct ide_port_info falconide_port_info = {
+#ifdef CONFIG_ATARI
 	.get_lock		= falconide_get_lock,
 	.release_lock		= falconide_release_lock,
+#endif
 	.tp_ops			= &falconide_tp_ops,
 	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_SERIALIZE |
 				  IDE_HFLAG_NO_DMA,
-- 
2.26.3

