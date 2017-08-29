From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.13-rc7
Date: Tue, 29 Aug 2017 11:04:18 -0700
Message-ID: <20170829180418.GT491396@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37159 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdH2SEX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 29 Aug 2017 14:04:23 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

Late fixes for libata.  There's a minor platform driver fix but the
important one is READ LOG PAGE.

This is a new ATA command which is used to test some optional features
but it broke probing of some devices - they locked up instead of
failing the unknown command.  Chritoph tried blacklisting, but, after
finding out there are multiple devices which fail this way, backed off
to testing feature bit in IDENTIFY data first, which is a bit lossy
(we can miss features on some devices) but should be a lot safer.

Thanks.

The following changes since commit 2f60e1ab2f0e148e82cb53c539ad003ffc9b9bd0:

  libata: fix a couple of doc build warnings (2017-07-31 08:03:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.13-fixes

for you to fetch changes up to 2aca392398384f8a2f339f4c661a1699f4f2e2eb:

  Revert "libata: quirk read log on no-name M.2 SSD" (2017-08-29 08:36:58 -0700)

----------------------------------------------------------------
Christoph Hellwig (2):
      libata: quirk read log on no-name M.2 SSD
      libata: check for trusted computing in IDENTIFY DEVICE data

Christophe JAILLET (1):
      sata: ahci-da850: Fix some error handling paths in 'ahci_da850_probe()'

Tejun Heo (1):
      Revert "libata: quirk read log on no-name M.2 SSD"

 drivers/ata/ahci_da850.c  |  8 ++++++--
 drivers/ata/libata-core.c |  3 +++
 include/linux/ata.h       | 10 +++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

-- 
tejun
