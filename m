From: Jeff Garzik <jgarzik@pobox.com>
Subject: [SATA] libata-dev queue updated
Date: Fri, 15 Oct 2004 20:44:04 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041016004404.GA31393@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:5082 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S268051AbUJPAoI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Oct 2004 20:44:08 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Updates:  adds Bart's ATAPI work.

BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.9-rc4-libata2-dev2.patch.bz2

The patch depends on the changes currently in the libata-2.6 queue,
	bk pull bk://gkernel.bkbits.net/libata-2.6
		or
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.9-rc4-libata2.patch.bz2

This will update the following files:

 drivers/pci/quirks.c        |    4 
 drivers/scsi/Kconfig        |    8 
 drivers/scsi/Makefile       |    1 
 drivers/scsi/ahci.c         | 1023 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c  |  246 ++++++++--
 drivers/scsi/libata-scsi.c  |  465 ++++++++++++++++++--
 drivers/scsi/libata.h       |    7 
 drivers/scsi/sata_promise.c |   56 ++
 drivers/scsi/sata_sil.c     |    2 
 drivers/scsi/sata_vsc.c     |    8 
 include/linux/ata.h         |   37 -
 include/linux/libata.h      |   18 
 include/scsi/scsi.h         |    3 
 13 files changed, 1759 insertions(+), 119 deletions(-)

through these ChangeSets:

<andyw:pobox.com>:
  o [libata scsi] support 12-byte passthru CDB
  o [libata scsi] passthru CDB check condition processing
  o T10/04-262 ATA pass thru - patch

<erikbenada:yahoo.ca>:
  o [libata sata_promise] support PATA ports on SATA controllers

<lsml:rtr.ca>:
  o Export ata_scsi_simulate() for use by non-libata drivers

Bartlomiej Zolnierkiewicz:
  o [libata] arbitrary size ATAPI PIO support
  o REQUEST_SENSE support for ATAPI

Brad Campbell:
  o libata basic detection and errata for PATA->SATA bridges

Jeff Garzik:
  o Fix build breakage related to hand-merging Brad Campbell's and Mark Lord's changes.
  o [libata] fix printk warning
  o [ata piix] enable ICH5/6 combined mode quirk based on BLK_DEV_IDE_SATA
  o [libata ahci] more updates
  o [libata ahci] fix several bugs
  o [libata] add AHCI driver

Jeremy Higdon:
  o per-port LED control for sata_vsc

John W. Linville:
  o libata: SMART support via ATA pass-thru

