From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.2-rc3
Date: Fri, 24 Jul 2015 16:07:52 -0400
Message-ID: <20150724200752.GA3585@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35926 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbbGXUHz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Jul 2015 16:07:55 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello, Linus.

A couple important fixes.

* A block layer change which removed restriction on max transfer size
  led to silent data corruption on some devices.  A new quirk is added
  to restore the old size limit for the reported device.  If it gets
  reported on more devices, we might have to consider restoring the
  restriction for ATA devices by default.

* There finally is a SSD which is confirmed to cause data corruption
  on TRIM regardless of which flavor is used.  A new quirk is added
  and the device is blacklisted.

* Other device-specific workarounds.

Thanks.

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.2-fixes

for you to fetch changes up to 9051bd393cf25e76dfb45409792719a854661500:

  libata: Do not blacklist M510DC (2015-07-16 12:15:45 -0400)

----------------------------------------------------------------
Aleksei Mamlin (1):
      libata: add ATA_HORKAGE_BROKEN_FPDMA_AA quirk for HP 250GB SATA disk VB0250EAVER

Arne Fitzenreiter (2):
      libata: add ATA_HORKAGE_NOTRIM
      libata: force disable trim for SuperSSpeed S238

David Milburn (1):
      libata: add ATA_HORKAGE_MAX_SEC_1024 to revert back to previous max_sectors limit

Lior Amsalem (1):
      ata: pmp: add quirk for Marvell 4140 SATA PMP

Martin K. Petersen (1):
      libata: Do not blacklist M510DC

Mikulas Patocka (1):
      libata: increase the timeout when setting transfer mode

 drivers/ata/libata-core.c      | 21 ++++++++++++++++++---
 drivers/ata/libata-pmp.c       |  7 +++++++
 drivers/ata/libata-scsi.c      |  3 ++-
 drivers/ata/libata-transport.c |  2 ++
 include/linux/ata.h            |  1 +
 include/linux/libata.h         |  2 ++
 6 files changed, 32 insertions(+), 4 deletions(-)

-- 
tejun
