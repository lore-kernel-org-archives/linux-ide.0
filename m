From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [BK PATCHES] ide-dev-2.6 update
Date: Fri, 21 Jan 2005 21:02:39 +0100
Message-ID: <58cb370e0501211202372c9b1b@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:34080 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262491AbVAUUCk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Jan 2005 15:02:40 -0500
Received: by wproxy.gmail.com with SMTP id 68so32116wra
        for <linux-ide@vger.kernel.org>; Fri, 21 Jan 2005 12:02:39 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>

Hi,

ide-dev-2.6 tree has been resurrected.  It now contains first bunch
of fixes needed for converting IDE device drivers to driver-model.

NOTE: If you have a local copy of the tree please re-clone it, thanks.

BK users:

	bk pull bk://bart.bkbits.net/ide-dev-2.6

This will update the following files:

 drivers/ide/Kconfig            |    8 -
 drivers/ide/ide-cd.c           |   42 --------
 drivers/ide/ide-default.c      |    7 -
 drivers/ide/ide-disk.c         |  194 -----------------------------------------
 drivers/ide/ide-floppy.c       |    1 
 drivers/ide/ide-io.c           |  159 ++++++++++++++++++++++++++++++++-
 drivers/ide/ide-iops.c         |   20 ++++
 drivers/ide/ide-probe.c        |   62 ++++++++++++-
 drivers/ide/ide-tape.c         |   18 +--
 drivers/ide/ide-taskfile.c     |    6 -
 drivers/ide/ide.c              |   26 -----
 drivers/ide/pci/pdc202xx_new.h |    6 -
 drivers/ide/pci/pdc202xx_old.h |   17 ---
 drivers/ide/setup-pci.c        |   15 ---
 drivers/scsi/ide-scsi.c        |    1 
 include/linux/ide.h            |    6 -
 16 files changed, 243 insertions(+), 345 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (05/01/21 1.2142)
   [ide] kill ide_driver_t->pre_reset
   
   Add ide_drive_t->post_reset flag and use it to signal post reset
   condition to the ide-tape driver (the only user of ->pre_reset).

<bzolnier@trik.(none)> (05/01/21 1.2141)
   [ide] fix some rare ide-default vs ide-disk races
   
   Some rare races between ide-default and ide-disk are possible, i.e.:
   * ide-default is used, I/O request is triggered (ie. /proc/ide/hd?/identify),
     drive->special is cleared silently (so CHS is not initialized properly),
     ide-disk is loaded and fails if drive uses CHS
   * ide-disk is used, drive is resetted, ide-disk is unloaded, ide-default
     takes control over drive and on the first I/O request silently clears
    drive->special without restoring settings
   
   Fix them by moving idedisk_{special,pre_reset}() and company to IDE core.

<bzolnier@trik.(none)> (05/01/21 1.2140)
   [ide] generic Power Management for IDE devices
   
   Move PM code from ide-cd.c and ide-disk.c to IDE core so:
   * PM is supported for other ATAPI devices (floppy, tape)
   * PM is supported even if specific driver is not loaded

<bzolnier@trik.(none)> (05/01/21 1.2139)
   [ide] fix drive->ready_stat for ATAPI
   
   ATAPI devices ignore DRDY bit so drive->ready_stat must be set to zero.
   It is currently done by device drivers (including ide-default fake driver)
   but for PMAC driver it is too late as wait_for_ready() may be called during
   probe: probe_hwif()->pmac_ide_dma_check()->pmac_ide_{mdma,udma}_enable()->
   ->pmac_ide_do_setfeature()->wait_for_ready().
   
   Fixup drive->ready_stat just after detecting ATAPI device.

<bzolnier@trik.(none)> (05/01/21 1.2138)
   [ide] ignore BIOS enable bits for Promise controllers
   
   Since there are no Promise binary drivers for 2.6.x kernels:
   * ignore BIOS enable bits completely
   * remove CONFIG_PDC202XX_FORCE
   * kill IDEPCI_FLAG_FORCE_PDC hack
