Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AA9C0015E
	for <linux-ide@archiver.kernel.org>; Sat, 29 Jul 2023 01:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjG2BFG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Jul 2023 21:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbjG2BFD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jul 2023 21:05:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A248271D
        for <linux-ide@vger.kernel.org>; Fri, 28 Jul 2023 18:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B2BF62210
        for <linux-ide@vger.kernel.org>; Sat, 29 Jul 2023 00:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DE6C433C7;
        Sat, 29 Jul 2023 00:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690592173;
        bh=ZL93ecGBPKquopCcdsI+IBKaPU31VvdVMNVnaSYyijQ=;
        h=From:To:Subject:Date:From;
        b=J4Id5u85sf6yjl8oZNZi+Ib+ZLY2eY1FiXALAaZJyxcIvKq+4HAyyL3evwLzcEqCH
         e/JXoXYKyoIQqzQoDCsybzN4txbiem/VVdvKEOXABcUvKtH18WNnxRUA2fo+ZUiwky
         hwm6+DBeoCkieKJcA9LzxKPzmLjEUDDoxT0k39W8p4ma7o9o/qaG+di+6HKRb4B+hA
         TUE0yHObTgu7Q6FSSI3SVEY9ZR+ZgIVXKEKnhgw36il4P/LkADU7dFEZQP91UIosMg
         iwj3rmEUl0oA6jCFYIq3t3ZtZBUX4aP0+Hi1SMQjC/7r/5+ZdEAnkdMHr1IwVM4owz
         GIbhnIbBImgLg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.5-rc4
Date:   Sat, 29 Jul 2023 09:56:12 +0900
Message-ID: <20230729005612.424560-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit cec148c2476a6e06cf8190b20de81f98983b53ca:

  ata: pata_parport: Add missing protocol modules description (2023-07-17 08:30:41 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.5-rc4

for you to fetch changes up to 3ac873c76d79f055e1712754d9f2e90e41582f04:

  ata: libata-core: fix when to fetch sense data for successful commands (2023-07-28 11:30:34 +0900)

----------------------------------------------------------------
ata fixes for 6.5-rc4

 - Fix error message output in the pata_arasan_cf driver (Minjie).

 - Fix invalid error return in the pata_octeon_cf driver initialization
   (Yingliang).

 - Fix a compilation warning due to a missing static function
   declaration in the pata_ns87415 driver (Arnd).

 - Fix the condition evaluating when to fetch sense data for successful
   completions, which should be done only when command duration limits
   are being used (Niklas).

----------------------------------------------------------------
Arnd Bergmann (1):
      ata: pata_ns87415: mark ns87560_tf_read static

Minjie Du (1):
      ata: pata_arasan_cf: Use dev_err_probe() instead dev_err() in data_xfer()

Niklas Cassel (1):
      ata: libata-core: fix when to fetch sense data for successful commands

Yang Yingliang (1):
      ata: pata_octeon_cf: fix error return code in octeon_cf_probe()

 drivers/ata/libata-core.c    | 4 ++--
 drivers/ata/pata_arasan_cf.c | 3 ++-
 drivers/ata/pata_ns87415.c   | 2 +-
 drivers/ata/pata_octeon_cf.c | 6 +++---
 4 files changed, 8 insertions(+), 7 deletions(-)
