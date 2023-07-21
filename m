Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FE5EB64DD
	for <linux-ide@archiver.kernel.org>; Fri, 21 Jul 2023 01:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGUBj7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Jul 2023 21:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGUBj6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Jul 2023 21:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D01B269A
        for <linux-ide@vger.kernel.org>; Thu, 20 Jul 2023 18:39:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF09A61BF4
        for <linux-ide@vger.kernel.org>; Fri, 21 Jul 2023 01:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E6AC433C7;
        Fri, 21 Jul 2023 01:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689903596;
        bh=Fi1rp6fGyWhpYEVKTbT516euVENGgmGeJTe47ruDXjg=;
        h=From:To:Subject:Date:From;
        b=Dr9Z8845mT3TufjFIPZqxErRmk0jeG5GxdpomB63CJAJV2BMjd0BrOdvWiRrngIaM
         xihTEYBJllvs53ZXxeauM/85y85kp/UOCqk1S8WlsrlSpoGlaoqh8RcTmzyGpltGT9
         luS9b/anKiZ02/4zOUYa5Dl8Gb/mHY1GyNrjBaVYz4ukrb4EqQF+AyrI/BOL/uLWTW
         HFTBlUW+mUk8RwAHXp40vJBuwKorcFLOanx7EN5ct4Ha211mxkfVpp3xazljzw1uC4
         9EUDMcF1YsUIW7iH4Yul+MT9LnYWO9N+B7OzftGKb8xJtb6Yy/eYJZpwEWxFG8AWNb
         edS9A3zpifTHw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.5-rc3
Date:   Fri, 21 Jul 2023 10:39:54 +0900
Message-ID: <20230721013954.37605-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.5-rc3

for you to fetch changes up to cec148c2476a6e06cf8190b20de81f98983b53ca:

  ata: pata_parport: Add missing protocol modules description (2023-07-17 08:30:41 +0900)

----------------------------------------------------------------
ata fixes for 6.5-rc3

 - Add missing MODULE_DESCRIPTION() in the many of the protocol modules
   for the pata_parport driver to avoid compilation warnings with "make
   W=1".

----------------------------------------------------------------
Damien Le Moal (1):
      ata: pata_parport: Add missing protocol modules description

 drivers/ata/pata_parport/aten.c  | 2 ++
 drivers/ata/pata_parport/bpck.c  | 2 ++
 drivers/ata/pata_parport/bpck6.c | 3 ++-
 drivers/ata/pata_parport/comm.c  | 2 ++
 drivers/ata/pata_parport/dstr.c  | 2 ++
 drivers/ata/pata_parport/epat.c  | 3 +++
 drivers/ata/pata_parport/epia.c  | 3 +++
 drivers/ata/pata_parport/fit2.c  | 3 +++
 drivers/ata/pata_parport/fit3.c  | 3 +++
 drivers/ata/pata_parport/friq.c  | 2 ++
 drivers/ata/pata_parport/frpw.c  | 2 ++
 drivers/ata/pata_parport/kbic.c  | 3 +++
 drivers/ata/pata_parport/ktti.c  | 2 ++
 drivers/ata/pata_parport/on20.c  | 2 ++
 drivers/ata/pata_parport/on26.c  | 2 ++
 15 files changed, 35 insertions(+), 1 deletion(-)
