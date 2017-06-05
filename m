From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.12-rc4
Date: Mon, 5 Jun 2017 16:21:34 -0400
Message-ID: <20170605202134.GC9399@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33407 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdFEUVh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jun 2017 16:21:37 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

libata fixes for v4.12-rc4.

* Revert of sata_mv devm_ioremap_resource() conversion.  It made init
  fail if there are overlapping resources which led to detection
  failures on some setups.

* A workaround for an Acer laptop which sometimes reports corrupt port
  map.

* Other non-critical fixes.

Thanks.

The following changes since commit a95cfad947d5f40cfbf9ad3019575aac1d8ac7a6:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2017-05-15 15:50:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.12-fixes

for you to fetch changes up to f7cf69ae171592d133c69b9adaa5de7cfb6038ea:

  libata: fix error checking in in ata_parse_force_one() (2017-05-31 14:26:26 -0400)

----------------------------------------------------------------
Andrew Lunn (1):
      Revert "ata: sata_mv: Convert to devm_ioremap_resource()"

Arvind Yadav (1):
      ata: sata_rcar: Handle return value of clk_prepare_enable

Sui Chen (1):
      ahci: Acer SA5-271 SSD Not Detected Fix

Tejun Heo (1):
      libata: fix error checking in in ata_parse_force_one()

Thomas Petazzoni (1):
      ata: libahci: properly propagate return value of platform_get_irq()

 drivers/ata/ahci.c             | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/ata/libahci_platform.c |  5 +++--
 drivers/ata/libata-core.c      |  2 +-
 drivers/ata/sata_mv.c          | 13 ++++++++-----
 drivers/ata/sata_rcar.c        | 15 ++++++++++++---
 5 files changed, 62 insertions(+), 11 deletions(-)

-- 
tejun
