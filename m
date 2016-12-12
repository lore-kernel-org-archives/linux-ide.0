From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.10-rc1
Date: Mon, 12 Dec 2016 13:32:09 -0500
Message-ID: <20161212183209.GE13864@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35066 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750696AbcLLScL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Dec 2016 13:32:11 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Linus.

* Adam added opt-in ATA command priority support.

* There are machines which hide multiple nvme devices behind an ahci
  BAR.  Dan Williams proposed a solution to force-switch the mode but
  deemed too hackishd.  People are gonna discuss the proper way to
  handle the situation in nvme standard meetings.  For now, detect and
  warn about the situation.

* Low level driver specific changes.

Thanks.

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.10

for you to fetch changes up to aecec8b60422118b52e3347430ba9382e57d6d76:

  ahci: warn about remapped NVMe devices (2016-12-05 14:31:24 -0500)

----------------------------------------------------------------
Adam Manzanares (4):
      block: Add iocontext priority to request
      ata: Enabling ATA Command Priorities
      ata: ATA Command Priority Disabled By Default
      ata: set ncq_prio_enabled iff device has support

Christoph Hellwig (2):
      nvme: move NVMe class code to pci_ids.h
      ahci: warn about remapped NVMe devices

Dan Williams (1):
      ahci-remap.h: add ahci remapping definitions

Tang Yuantian (1):
      ahci: qoriq: added ls1046a platform support

Vladimir Zapolskiy (4):
      pata: imx: sort headers out
      pata: imx: set controller PIO mode with .set_piomode callback
      pata: imx: add support of setting timings for PIO modes
      pata: imx: support controller modes up to PIO4

 block/blk-core.c           |  4 ++-
 drivers/ata/ahci.c         | 39 ++++++++++++++++++++++
 drivers/ata/ahci_qoriq.c   | 16 +++++++--
 drivers/ata/libahci.c      |  1 +
 drivers/ata/libata-core.c  | 35 +++++++++++++++++++-
 drivers/ata/libata-scsi.c  | 80 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h       |  2 +-
 drivers/ata/pata_imx.c     | 82 ++++++++++++++++++++++++++++++++--------------
 drivers/nvme/host/pci.c    |  3 --
 include/linux/ahci-remap.h | 28 ++++++++++++++++
 include/linux/ata.h        |  6 ++++
 include/linux/blkdev.h     | 14 ++++++++
 include/linux/libata.h     |  5 +++
 include/linux/pci_ids.h    |  2 ++
 14 files changed, 282 insertions(+), 35 deletions(-)
 create mode 100644 include/linux/ahci-remap.h
