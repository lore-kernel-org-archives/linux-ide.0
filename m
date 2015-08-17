From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.2-rc7
Date: Mon, 17 Aug 2015 15:47:48 -0400
Message-ID: <20150817194748.GB21075@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33633 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbbHQTry (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Aug 2015 15:47:54 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hello, Linus.

Three minor device-specific fixes and revert of NCQ autosense added
during this -rc1.  It turned out that NCQ autosense as currently
implemented interferes with the usual error handling behavior.  It
will be revisited in the near future.

Thanks.

The following changes since commit 9051bd393cf25e76dfb45409792719a854661500:

  libata: Do not blacklist M510DC (2015-07-16 12:15:45 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.2-fixes

for you to fetch changes up to f9114d357858c1429dcde022706db7443918f49f:

  ata: ahci_brcmstb: Fix misuse of IS_ENABLED (2015-08-06 14:30:07 -0400)

----------------------------------------------------------------
Axel Lin (1):
      ata: ahci_brcmstb: Fix misuse of IS_ENABLED

Florian Fainelli (1):
      ata: ahci_brcmstb: Fix warnings with CONFIG_PM_SLEEP=n

Tejun Heo (3):
      Revert "libata-eh: Set 'information' field for autosense"
      Revert "libata: Implement support for sense data reporting"
      Revert "libata: Implement NCQ autosense"

Tomer Barletz (1):
      sata_sx4: Check return code from pdc20621_i2c_read()

 drivers/ata/ahci_brcmstb.c |   6 ++-
 drivers/ata/libata-core.c  |  24 ++---------
 drivers/ata/libata-eh.c    | 105 +--------------------------------------------
 drivers/ata/libata-scsi.c  |  21 +--------
 drivers/ata/libata.h       |   6 +--
 drivers/ata/sata_sx4.c     |  16 +++++--
 drivers/scsi/scsi_error.c  |  31 -------------
 include/linux/ata.h        |  18 --------
 include/scsi/scsi_eh.h     |   1 -
 9 files changed, 24 insertions(+), 204 deletions(-)
