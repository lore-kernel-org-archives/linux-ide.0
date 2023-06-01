Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B1BC77B73
	for <linux-ide@archiver.kernel.org>; Thu,  1 Jun 2023 00:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjFAAyF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 31 May 2023 20:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjFAAyF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 31 May 2023 20:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F60139
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2023 17:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1688A64039
        for <linux-ide@vger.kernel.org>; Thu,  1 Jun 2023 00:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EF2C43442;
        Thu,  1 Jun 2023 00:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685580843;
        bh=K4Rzt0oYnWd1xGZK6oEiHS1ZT0ccWZVGrcqUFOxSCDc=;
        h=From:To:Subject:Date:From;
        b=NiA5o3PH5446DvF3jc5DRL8mTBUGbDfNoa4QxXdu5rwpUhA2tmmWPFvlJK4oxUN7H
         UcthSMTcN3BFt6J78TwhYUJzd6M97gwe/tUoiaTR0nw5wHMvOASgDovtCNeeGeR7Rd
         X/BVBfyJ8XxLgTPBNJPolekWRIbu7+NhYHeS3IRj47sLorlJ0yUkx3xxvgGGfmDei2
         kKYo9DxetLfytFXQ/5acbRbcr/KjB+NzDq17oCwu468eO0vhV92uYVD8XfFGV40el6
         wrEH68h04PoPzW33S249YK9e11wyK2NS016P4nJdb0L1TymBxvUlcq+iBS8XZg+qT1
         QSdyoHyM2ltAA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.4-rc5
Date:   Thu,  1 Jun 2023 09:54:01 +0900
Message-Id: <20230601005401.3298-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit a7844528722619d2f97740ae5ec747afff18c4be:

  dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries (2023-05-15 07:27:57 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.4-rc5

for you to fetch changes up to 7f875850f20a42f488840c9df7af91ef7db2d576:

  ata: libata-scsi: Use correct device no in ata_find_dev() (2023-05-30 08:08:18 +0900)

----------------------------------------------------------------
ata fixes for 6.4-rc5

 * Fix ata_find_dev() use of the device number to find a struct
   ata_device for a port. This addresses issues with some passthrough
   commands with libsas managed devices.

----------------------------------------------------------------
Damien Le Moal (1):
      ata: libata-scsi: Use correct device no in ata_find_dev()

 drivers/ata/libata-scsi.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)
