Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B421BC4332F
	for <linux-ide@archiver.kernel.org>; Thu,  9 Nov 2023 23:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjKIXIg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Nov 2023 18:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIXIf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Nov 2023 18:08:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEB04231
        for <linux-ide@vger.kernel.org>; Thu,  9 Nov 2023 15:08:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9EAC433C8;
        Thu,  9 Nov 2023 23:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699571313;
        bh=WcRTJ9KsBYxG3RB3pQtOwHdVwRsmaiu3luVG59LyoGw=;
        h=From:To:Subject:Date:From;
        b=J3zRO+Itb3DXX/w7W5W0Wk8cQ6+2+PGoESazqKuzlcWf58UzqcU2QnnCXfUT9p41W
         abGq1+Exof9TDQGFUaGCImZd32bl50uS6RjcZz9DuCH42d6/5aaPRgKCP0WZR314FX
         2A41yY8tbSyQTDAWJHpNcBKzxQPiytmxA8hqzKpKOqaiCzUxreBNTNokeVf6PdLuCr
         +rCm+kdTKfvT6zuA1tti09doeYGKp8yxr5bZ7UCqAFxqkr04v+2JYDO0VILOcawZ7B
         9rWER7fHwT4r4gPT15ZcZeylrH5Y18nenhXlgntVA2Mf9m0uimmWIJoCJ4HKSYT2B3
         /b2JfBtxOe1Ng==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.7-rc1-2
Date:   Fri, 10 Nov 2023 08:08:21 +0900
Message-ID: <20231109230831.141450-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 13d88ac54ddd1011b6e94443958e798aa06eb835:

  Merge tag 'vfs-6.7.fsid' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs (2023-11-07 12:11:26 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.7-rc1-2

for you to fetch changes up to 99bce5182d8fe90e5c57e9d99f831baaa94f90cb:

  ata: pata_gayle: Convert to platform remove callback returning void (2023-11-08 09:00:49 +0900)

----------------------------------------------------------------
ata fixes for 6.7-rc1

 - Revert a change in ata_pci_shutdown_one() to suspend disks on
   shutdown as this is now done using the manage_shutdown scsi device
   flag (from me).

 - Change the pata_falcon and pata_gayle drivers to stop using
   module_platform_driver_probe(). This makes these drivers more inline
   with all other drivers (allowing bind/unbind) and suppress a
   compilation warning (from Uwe).

 - Convert the pata_falcon and pata_gayle drivers to the new
   .remove_new() void-return callback. These 2 drivers are the last ones
   needing this change (from Uwe).

----------------------------------------------------------------
Damien Le Moal (1):
      ata: libata-core: Fix ata_pci_shutdown_one()

Uwe Kleine-König (4):
      ata: pata_falcon: Stop using module_platform_driver_probe()
      ata: pata_gayle: Stop using module_platform_driver_probe()
      ata: pata_falcon: Convert to platform remove callback returning void
      ata: pata_gayle: Convert to platform remove callback returning void

 drivers/ata/libata-core.c | 16 +---------------
 drivers/ata/pata_falcon.c | 11 +++++------
 drivers/ata/pata_gayle.c  | 11 +++++------
 3 files changed, 11 insertions(+), 27 deletions(-)
