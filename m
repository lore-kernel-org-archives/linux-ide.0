Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2463C7EE23
	for <linux-ide@archiver.kernel.org>; Sun, 21 May 2023 11:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjEULva (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 21 May 2023 07:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjEULt7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 21 May 2023 07:49:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2AD1AC
        for <linux-ide@vger.kernel.org>; Sun, 21 May 2023 04:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0896B60E04
        for <linux-ide@vger.kernel.org>; Sun, 21 May 2023 11:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15722C433D2;
        Sun, 21 May 2023 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684669654;
        bh=b51C70U0H+DZWrUcCkAOeb38MuDexJlD0kJO2GcQjDA=;
        h=From:To:Subject:Date:From;
        b=bUZCJuL+h+yb7tp+UO1C38edAurKY7a+TOctokHAdCk31EmgzRHWs9anLOMRWSwZT
         RlSgEk92Wg7hk9ZTSHK7mK7+FH6fHn2H2b0nNA+jsAirQgCMGbY+zQtG48kR/h3EIA
         x5shHuJ5wuVBzJO9VxDOcNfiscVMtaWJur2SN5vpWjhr8ihB641fgy6g1kMs34BxSi
         5ATTBQiZgvo7l2yPKZZ8IcnrYL5yY5AASPDeGjLNZWoLHysGJSrJdLF4lMrTWlQ+hy
         rzEWtTAcO1XKvuNfIPcWaJghDrpOKVSX3b+urAsvbJ0ggmcVDI4VTnW45rRGuB5qNP
         XKbAh72TJ1DjA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.4-rc3
Date:   Sun, 21 May 2023 20:47:32 +0900
Message-Id: <20230521114732.2290216-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.4-rc3

for you to fetch changes up to a7844528722619d2f97740ae5ec747afff18c4be:

  dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries (2023-05-15 07:27:57 +0900)

----------------------------------------------------------------
ata fixes for 6.4-rc3

 * Fix DT binding for the ahci-ceva driver to fully describe all iommus,
   from Michal.

----------------------------------------------------------------
Michal Simek (1):
      dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries

 Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
