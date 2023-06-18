Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9766EB64D9
	for <linux-ide@archiver.kernel.org>; Sun, 18 Jun 2023 02:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjFRC6P (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 17 Jun 2023 22:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjFRC6P (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jun 2023 22:58:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2BF197
        for <linux-ide@vger.kernel.org>; Sat, 17 Jun 2023 19:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5061560F07
        for <linux-ide@vger.kernel.org>; Sun, 18 Jun 2023 02:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1BAC433C0;
        Sun, 18 Jun 2023 02:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687057092;
        bh=62wBZEtLIWlLSIFl79LHF4TstWZXWSE12U0m30WYC7s=;
        h=From:To:Subject:Date:From;
        b=JNQt/70OUSx1U5fvb5dpy9Hz2aU5giGwHYJo8MRnujkuMYpLtN5IwRHZuEoEoyuoN
         /KbRidGFFGrDVzH+8X+8JujWc8wvs5aCd+N2MDFRUzasTLpBheylzqBCG6tMJCzipK
         C/Tr394kBaDY/HciUVTZVgRDhW5kXuxxCufQJwm+ZOo9P27qoOMsuusdTwaD2/pOEz
         YIq3/U5JjSpWPK9aoAtgk1UtqI0zfk8ohyUej1w63LrQxLRLhOe+sgP8JwDdhgghQb
         ddb6ID2fl7lNcXqm679aPO1lpBCv+M/7LDANdcYfBxkSeMhmRLFH3lrLQu+fhTPk41
         swh0cciRJY9HQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.4-rc7
Date:   Sun, 18 Jun 2023 11:58:11 +0900
Message-Id: <20230618025811.292922-1-dlemoal@kernel.org>
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

for you to fetch changes up to 1f219070f4a87ea43fab65f133d0957adbfd2390:

  ata: libata-scsi: Avoid deadlock on rescan after device resume (2023-06-18 11:53:31 +0900)

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
