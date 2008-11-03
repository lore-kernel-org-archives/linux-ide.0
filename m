From: Tejun Heo <tj@kernel.org>
Subject: [PATCHSET #upstream-fixes] patches which fell off the crack during maintainership handover
Date: Mon,  3 Nov 2008 19:01:01 +0900
Message-ID: <1225706469-27870-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60491 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668AbYKCKBU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 05:01:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org


Hello, Jeff.

This patchset contains eight patches that I collected for 2.6.28 while
you were away.  Unfortunately, the handover to you didn't work out too
well and these got forgotten.  This patchset contains the following
eight patches.

  0001-Hibernation-Introduce-system_entering_hibernation.patch
  0002-DMI-Introduce-dmi_first_match-to-make-the-interface.patch
  0003-SATA-Blacklisting-of-systems-that-spin-off-disks-du.patch
  0004-SATA-AHCI-Blacklist-system-that-spins-off-disks-dur.patch
  0005-SATA-Sil-Blacklist-system-that-spins-off-disks-duri.patch
  0006-SATA-PIIX-Blacklist-system-that-spins-off-disks-dur.patch
  0007-libata-Fix-a-potential-race-condition-in-ata_scsi_p.patch
  0008-libata-implement-ATA_HORKAGE_ATAPI_MOD16_DMA-and-ap.patch

0001-0006 are to fix the long-standing double spindown problems on
certain laptops.  0007 fixes a potential race condition and 0008
implements a workaround for a strange device.  These missed rc1 window
but they're all fixes or workarounds for weird hardware so I think
they qualify.

Thanks.

 drivers/ata/ahci.c          |   32 +++++++++++++++++++
 drivers/ata/ata_piix.c      |   34 ++++++++++++++++++++
 drivers/ata/libata-core.c   |    4 +-
 drivers/ata/libata-scsi.c   |   27 ++++++++++++----
 drivers/ata/sata_sil.c      |   36 ++++++++++++++++++++-
 drivers/firmware/dmi_scan.c |   74 ++++++++++++++++++++++++++++++++------------
 include/linux/dmi.h         |    1 
 include/linux/libata.h      |    4 ++
 include/linux/suspend.h     |    2 +
 kernel/power/disk.c         |   10 +++++
 10 files changed, 197 insertions(+), 27 deletions(-)

--
tejun
