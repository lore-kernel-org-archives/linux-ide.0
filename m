From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [BK PATCHES] ide-dev-2.6 update
Date: Fri, 29 Oct 2004 23:08:23 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200410292308.23266.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:3269 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S263592AbUJ2VFx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Oct 2004 17:05:53 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:34217 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S100400AbUJ2VFw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Oct 2004 23:05:52 +0200
Received: from chello062179088136.chello.pl ([62.179.88.136]:65291 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S48892AbUJ2VED (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Fri, 29 Oct 2004 23:04:03 +0200
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org


Hi Andrew,

ide-dev-2.6 has been rebuilt.
[ If anyone keeps local copy please erase and re-clone. ]

Not much is left after syncing with -linus.

Please do a

	bk pull bk://bart.bkbits.net/ide-dev-2.6

this will update the following files:

 drivers/ide/pci/hpt34x.h       |   29 ---------------
 Documentation/ide.txt          |    7 ---
 drivers/ide/Kconfig            |   20 ----------
 drivers/ide/arm/icside.c       |    5 ++
 drivers/ide/ide-disk.c         |    9 +---
 drivers/ide/ide-probe.c        |    4 +-
 drivers/ide/ide-proc.c         |   31 ++++++++++------
 drivers/ide/ide-taskfile.c     |   38 ++++++++++----------
 drivers/ide/ide.c              |   31 +++++++---------
 drivers/ide/pci/atiixp.c       |    6 +--
 drivers/ide/pci/cs5520.c       |    2 -
 drivers/ide/pci/cs5530.c       |    1 
 drivers/ide/pci/hpt34x.c       |   17 +++++++--
 drivers/ide/pci/pdc202xx_new.h |    6 ---
 drivers/ide/pci/pdc202xx_old.h |   17 ---------
 drivers/ide/pci/triflex.c      |    8 +---
 drivers/ide/ppc/pmac.c         |    7 ---
 drivers/ide/setup-pci.c        |   76 +++++++++--------------------------------
 include/linux/hdreg.h          |    6 ++-
 include/linux/ide.h            |   11 ++---
 20 files changed, 109 insertions(+), 222 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/10/29 1.2351)
   [ide] add data_len to ide_task_t
   
   From: Jens Axboe <axboe@suse.de>
   
   bart: also kill ide_diag_taskfile()

<bzolnier@trik.(none)> (04/10/29 1.2350)
   [ide] obsolete "enable DMA by default" config options
   
   CONFIG_IDEDMA_PCI_AUTO and CONFIG_IDEDMA_ICS_AUTO
   
   Host drivers should deal with broken hardware themselves.
   Warn if DMA support is enabled but "enable DMA by default" is not.

<bzolnier@trik.(none)> (04/10/29 1.2349)
   [ide] obsolete some command line parameters
   
   "hdx=autotune", "hdx=noautotune":
   * should be handled by host drivers needing them
   
   "idex=autotune", "idex=noautotune":
   * should die
   
   "idex=ata66":
   * should be handled by host drivers needing it
   
   "idex=dma":
   * works only for: cs5220.c, generic.c, hpt366.c, triflex.c
   * DMA should be used by default
   
   "idex=reset", "idex=serialize":
   * host drivers should set these settings when needed
   
   "idex=base[,ctl[,irq]]":
   * host drivers should auto-detect correct settings
   * ordering should be controlled by user-space
   
   "ide0=four":
   * should be handled by ide-generic driver

<bzolnier@trik.(none)> (04/10/29 1.2348)
   [ide] ignore BIOS enable bits for Promise controllers
   
   There are no Promise binary drivers for 2.6.x kernels so:
   * ignore BIOS enable bits completely
   * remove CONFIG_PDC202XX_FORCE
   * kill IDEPCI_FLAG_FORCE_PDC hack

<bzolnier@trik.(none)> (04/10/29 1.2347)
   [ide] obsolete /proc/ide/hd?/settings
   
   Majority of these settings is also available through ioctls.
   We will deal with the rest during deprecation period.

<bzolnier@trik.(none)> (04/10/29 1.2346)
   [ide] kill /proc/ide/hd?/settings:number
   
   drive->dn is used mainly for programming timings and shouldn't be touched.

<bzolnier@trik.(none)> (04/10/29 1.2345)
   [ide] kill /proc/ide/hd?/settings:lun
   
   drive->lun is always zero in init_gendisk().

<bzolnier@trik.(none)> (04/10/29 1.2344)
   [ide] kill /proc/ide/hd?/settings:address & HDIO_[GET,SET]_ADDRESS ioctls
   
   ide-disk driver always uses LBA48 when available so
   messing with drive->addressing should be prohibited.

<bzolnier@trik.(none)> (04/10/29 1.2343)
   [ide] triflex: simplify triflex_config_drive_for_dma()

<bzolnier@trik.(none)> (04/10/29 1.2342)
   [ide] atiixp: simplify atiixp_config_drive_for_dma()

<bzolnier@trik.(none)> (04/10/29 1.2341)
   [ide] ide-disk: enable stroke by default
   
   From: Jens Axboe <axboe@suse.de>
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2340)
   [ide] make destroy_proc_ide_interfaces static
   
   destroy_proc_ide_interfaces is only used inside ide-proc.c;
   so lets make it static.
   
   Signed-off-by: Arjan van de Ven <arjan@infradead.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2339)
   [ide] kill IDEPCI_FLAG_FORCE_MASTER
   
   cs5530 overrides hwif->autodma anyway.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2338)
   [ide] setup-pci: simplify autodma logic
   
   Do not set hwif->autodma in ide_pci_setup_ports().
   All DMA capable PCI host drivers override it.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2337)
   [ide] setup-pci: small ide_get_or_set_dma_base() cleanup
   
   * hwif->dma_base is set in ->init_iops() for MMIO
   * if !dma_base then dma_base is really equal to zero
   * remove dead code from simplex check
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2336)
   [ide] pmac: kill CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
   
   DMA is always used by default (->autodma is never checked).
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2335)
   [ide] hpt34x: kill hpt34x.h
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2334)
   [ide] remove hwif from /proc/ide/ as part of ide_unregister_hwif()
   
   Original patch from Mark Lord <lkml@rtr.ca>.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2333)
   [ide] PIO bugfix
   
   We need to k[un]map_atomic() the current page not the first page
   of the scatterlist segment.  Fixes OOPS when using HIGHMEM.
   
   Big thanks to Randy Dunlap for a lot of debugging/testing.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
