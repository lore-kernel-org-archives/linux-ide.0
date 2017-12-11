From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.15-rc3
Date: Mon, 11 Dec 2017 13:51:44 -0800
Message-ID: <20171211215144.GP2421075@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35688 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbdLKVvr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2017 16:51:47 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Linus.

Nothing too interesting.  David Milburn improved a corner case
misbehavior during hotplug.  Other than that, minor driver-specific
fixes.

Thanks.

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.15-fixes

for you to fetch changes up to 2dc0b46b5ea30f169b0b272253ea846a5a281731:

  libata: sata_down_spd_limit should return if driver has not recorded sstatus speed (2017-12-04 13:57:03 -0800)

----------------------------------------------------------------
Albert Pool (1):
      ata: mediatek: Fix typo in module description

Arvind Yadav (2):
      pata_pdc2027x: Remove unnecessary error check
      pata_pdc2027x : make pdc2027x_*_timing structures const

David Milburn (1):
      libata: sata_down_spd_limit should return if driver has not recorded sstatus speed

Matthias Brugger (1):
      ahci: mtk: Change driver name to ahci-mtk

Yuantian Tang (1):
      ahci: qoriq: refine port register configuration

 drivers/ata/ahci_mtk.c      |  6 +++---
 drivers/ata/ahci_qoriq.c    | 12 ++++++++++++
 drivers/ata/libata-core.c   | 12 +++++++++---
 drivers/ata/pata_pdc2027x.c | 16 ++++++----------
 4 files changed, 30 insertions(+), 16 deletions(-)

-- 
tejun
