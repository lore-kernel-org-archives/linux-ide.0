Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477ABCD37BB
	for <linux-ide@archiver.kernel.org>; Sat, 16 Sep 2023 12:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjIPMTA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 16 Sep 2023 08:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbjIPMSs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 16 Sep 2023 08:18:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2FC18E
        for <linux-ide@vger.kernel.org>; Sat, 16 Sep 2023 05:18:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2416C433C8;
        Sat, 16 Sep 2023 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694866723;
        bh=MK9RIWmDSpdRdCNm7J3Nuu4i8MzR92DK5iSuM01uvrw=;
        h=From:To:Subject:Date:From;
        b=PwYhooCbGVkMXtdQfy5/pjOeycVOhAb+TEkAX/oG9Dy3oFWTbjLEFanV5n5gRkoMo
         tQCXqt8z1qfN8aLlI9o+ChKFXyuL9JxNMy8DAqZxiegh+GZr2QWcrQ1axO55anXluB
         Ax1juaO0iFK8NwKkqhTsqFS/fSu+qySju6EvxGT9JYVdF6OdOOg28bt8d2AFR4WkHk
         b+1fnln2KPYb7zvYR8/iuIDmiuuW+0i5A5tyFV2+RfUdqOHQ8t04Jrd0M4FEROOgx5
         0eq1csjgE+Pl+592cflq730saC32jG6tadeBz9wMOREC8SPKs4+FCxjk9cQ/+obDSK
         U5B0M7J4+uplA==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.6-rc2
Date:   Sat, 16 Sep 2023 21:18:41 +0900
Message-ID: <20230916121841.778684-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-rc2

for you to fetch changes up to 5e35a9ac3fe3a0d571b899a16ca84253e53dc70c:

  ata: libata-core: fetch sense data for successful commands iff CDL enabled (2023-09-16 21:12:19 +0900)

Fixes for the "no start on resume" libata suspend/resume mess posted late in the
6.5 cycle are still under test and will be sent next week if all goes well.

----------------------------------------------------------------
ata changes for 6.6-rc2

 - Fix link power management transitions to disallow unsupported
   states (Niklas).

 - A small string handling fix for the sata_mv driver (Christophe).

 - Clear port pending interrupts before reset, as per AHCI
   specifications (Szuying). Followup fixes for this one are to not
   clear ATA_PFLAG_EH_PENDING in ata_eh_reset() to allow EH to
   continue on with other actions recorded with error interrupts
   triggered before EH completes. A~Nd an additional fix to avoid
   thawing a port twice in EH (Niklas).

 - Small code style fixes in the pata_parport driver to silence the
   build bot as it keeps complaining about bad indentation (me).

 - A fix for the recent CDL code to avoid fetching sense data for
   successful commands when not necessary for correct operation
   (Niklas).

----------------------------------------------------------------
Christophe JAILLET (1):
      ata: sata_mv: Fix incorrect string length computation in mv_dump_mem()

Damien Le Moal (1):
      ata: pata_parport: Fix code style issues

Niklas Cassel (4):
      ata: libata: disallow dev-initiated LPM transitions to unsupported states
      ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
      ata: libata-eh: do not thaw the port twice in ata_eh_reset()
      ata: libata-core: fetch sense data for successful commands iff CDL enabled

Szuying Chen (1):
      ata: libahci: clear pending interrupt status

 drivers/ata/ahci.c              |  9 +++++++++
 drivers/ata/libahci.c           | 35 +++++++++++++++++++++++------------
 drivers/ata/libata-core.c       |  7 ++-----
 drivers/ata/libata-eh.c         | 16 +++-------------
 drivers/ata/libata-sata.c       | 19 ++++++++++++++++---
 drivers/ata/pata_parport/comm.c |  9 ++++-----
 drivers/ata/sata_mv.c           |  4 ++--
 include/linux/libata.h          |  4 ++++
 8 files changed, 63 insertions(+), 40 deletions(-)
