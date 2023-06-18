Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8030EB64D9
	for <linux-ide@archiver.kernel.org>; Sun, 18 Jun 2023 03:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjFRDFK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 17 Jun 2023 23:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjFRDFK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jun 2023 23:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3AEE4D
        for <linux-ide@vger.kernel.org>; Sat, 17 Jun 2023 20:05:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C54B960F07
        for <linux-ide@vger.kernel.org>; Sun, 18 Jun 2023 03:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5657C433C8;
        Sun, 18 Jun 2023 03:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687057508;
        bh=AgZvLEviYkDIVWq6xJdrpxCAGWOJfNw1EBM+Rt3CY6w=;
        h=From:To:Subject:Date:From;
        b=N+xf5gUeY8kWyBWPEKwIG11M3PQH7K4qmDPhmINLwwF4Oo0MoX9hTAJHzJE6gq6oT
         Oi08nXCUyQqRp0tkbQVYiP7Ib6wyA55NijIKtCBuxoqnLT7OY62JHQAS26IdJP5noj
         wqyBIKbVV2bcJRVJHy3ZKWIFkkfsjxPQnb6y8780Vqbs1XJ2qeSOIltNZwwTMG4iRz
         QgkxUMdlCt2qxqSTGRYmDjyUTDd5X+dICo+y3AxJ6UcpGRcoxRhz4HlCNx+eI84IEm
         hJ380D+gkFPH3ECNHUibFNBl1ugxRGq6a4/Ga8FHzds5p3DnDQdWZ1nnbdcw7MBRHQ
         BRESmrgVbnxjg==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.4-rc7
Date:   Sun, 18 Jun 2023 12:05:06 +0900
Message-Id: <20230618030506.293308-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 7f875850f20a42f488840c9df7af91ef7db2d576:

  ata: libata-scsi: Use correct device no in ata_find_dev() (2023-05-30 08:08:18 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.4-rc7

for you to fetch changes up to 6aa0365a3c8512587fffd42fe438768709ddef8e:

  ata: libata-scsi: Avoid deadlock on rescan after device resume (2023-06-18 12:00:49 +0900)

----------------------------------------------------------------
ata fixes for 6.4-rc7

 - Avoid deadlocks on resume from sleep by delaying scsi rescan until
   the scsi device is also fully resumed.

----------------------------------------------------------------
Damien Le Moal (1):
      ata: libata-scsi: Avoid deadlock on rescan after device resume

 drivers/ata/libata-core.c |  3 ++-
 drivers/ata/libata-eh.c   |  2 +-
 drivers/ata/libata-scsi.c | 22 +++++++++++++++++++++-
 include/linux/libata.h    |  2 +-
 4 files changed, 25 insertions(+), 4 deletions(-)
