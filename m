Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568C7C4743D
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 06:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE90611BD
	for <linux-ide@archiver.kernel.org>; Tue,  8 Jun 2021 06:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhFHGGW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:06:22 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:38422 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhFHGGV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jun 2021 02:06:21 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 286432AD5E; Tue,  8 Jun 2021 02:04:25 -0400 (EDT)
Message-Id: <cover.1623131194.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 0/2] Use libata platform drivers to replace deprecated m68k IDE drivers
Date:   Tue, 08 Jun 2021 15:46:34 +1000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        "Joshua Thompson" <funaho@jurai.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        "Richard Zidlicky" <rz@linux-m68k.org>,
        "Michael Schmitz" <schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch series allows m68k platforms to switch from deprecated IDE
drivers to libata drivers.

Changed since v1:
 - Added reviewed-by and tested-by tags.
 - Improved commit logs.


Finn Thain (2):
  m68k/mac: Replace macide driver with generic platform drivers
  m68k/q40: Replace q40ide driver with pata_falcon and falconide

 arch/m68k/atari/config.c          |  12 +--
 arch/m68k/configs/mac_defconfig   |   1 -
 arch/m68k/configs/multi_defconfig |   2 -
 arch/m68k/configs/q40_defconfig   |   2 +-
 arch/m68k/mac/config.c            |  24 +++--
 arch/m68k/q40/config.c            |  37 +++++--
 drivers/ata/Kconfig               |   6 +-
 drivers/ata/pata_falcon.c         |  62 ++++++++---
 drivers/ide/Kconfig               |  32 +-----
 drivers/ide/Makefile              |   2 -
 drivers/ide/falconide.c           |  75 ++++++++-----
 drivers/ide/macide.c              | 161 ----------------------------
 drivers/ide/q40ide.c              | 168 ------------------------------
 13 files changed, 151 insertions(+), 433 deletions(-)
 delete mode 100644 drivers/ide/macide.c
 delete mode 100644 drivers/ide/q40ide.c

-- 
2.26.3

