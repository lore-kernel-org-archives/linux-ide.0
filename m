From: Jeff Garzik <jgarzik@pobox.com>
Subject: [SATA] libata-dev queue updated
Date: Mon, 18 Oct 2004 19:52:24 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041018235224.GA24433@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:40924 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267840AbUJRX4f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Oct 2004 19:56:35 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Added Bart's ATAPI work and Albert's port of Promise PATA driver.

BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.9-libata1-dev1.patch.bz2

The libata-dev patch requires the libata-2.6 patch queue, which is
	bk://gkernel.bkbits.net/libata-2.6
		or
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.9-libata1.patch.bz2

This will update the following files:

 drivers/pci/quirks.c         |    4 
 drivers/scsi/Kconfig         |   16 
 drivers/scsi/Makefile        |    2 
 drivers/scsi/ahci.c          | 1023 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c   |  273 +++++++++--
 drivers/scsi/libata-scsi.c   |  465 +++++++++++++++++--
 drivers/scsi/libata.h        |    7 
 drivers/scsi/pata_pdc2027x.c |  758 +++++++++++++++++++++++++++++++
 drivers/scsi/sata_promise.c  |   56 ++
 drivers/scsi/sata_sil.c      |    2 
 drivers/scsi/sata_vsc.c      |    8 
 include/linux/ata.h          |   37 -
 include/linux/libata.h       |   18 
 include/scsi/scsi.h          |    3 
 14 files changed, 2545 insertions(+), 127 deletions(-)

through these ChangeSets:

<albertcc:tw.ibm.com>:
  o [libata] add driver for Promise PATA 2027x

<andyw:pobox.com>:
  o [libata scsi] support 12-byte passthru CDB
  o [libata scsi] passthru CDB check condition processing
  o T10/04-262 ATA pass thru - patch

<erikbenada:yahoo.ca>:
  o [libata sata_promise] support PATA ports on SATA controllers

<lsml:rtr.ca>:
  o Export ata_scsi_simulate() for use by non-libata drivers

Bartlomiej Zolnierkiewicz:
  o make ATAPI PIO work
  o arbitrary size ATAPI PIO support bugfixes
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

