From: Jeff Garzik <jgarzik@pobox.com>
Subject: [SATA] libata-dev queue updated
Date: Sat, 30 Oct 2004 12:15:35 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041030161535.GA13271@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:14006 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261187AbUJ3QTn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Oct 2004 12:19:43 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Still got a couple more patches in the inbox, not yet committed.

BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch:

	Too slack to make one today.

This will update the following files:

 drivers/scsi/Kconfig         |    8 
 drivers/scsi/Makefile        |    1 
 drivers/scsi/ahci.c          |    9 
 drivers/scsi/libata-core.c   |   38 ++
 drivers/scsi/libata-scsi.c   |  409 +++++++++++++++++++++++++
 drivers/scsi/libata.h        |    2 
 drivers/scsi/pata_pdc2027x.c |  694 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_promise.c  |  104 ++++--
 include/linux/ata.h          |    1 
 include/linux/libata.h       |    7 
 include/scsi/scsi.h          |    3 
 11 files changed, 1232 insertions(+), 44 deletions(-)

through these ChangeSets:

<albertcc:tw.ibm.com>:
  o [libata pdc2027x] fix incorrect pio and mwdma masks
  o [libata pdc2027x] remove quirks and ROM enable
  o [libata] add driver for Promise PATA 2027x

<andyw:pobox.com>:
  o [libata scsi] support 12-byte passthru CDB
  o [libata scsi] passthru CDB check condition processing
  o T10/04-262 ATA pass thru - patch

<erikbenada:yahoo.ca>:
  o [libata sata_promise] support PATA ports on SATA controllers

<tobias.lorenz:gmx.net>:
  o [libata sata_promise] s/sata/ata/
  o libata-scsi: get-identity ioctl support

Brad Campbell:
  o libata basic detection and errata for PATA->SATA bridges

Jeff Garzik:
  o [libata] fix build breakage
  o [libata] cosmetic libata.h changes to make merging with 2.4 easier
  o [libata] fix SATA->PATA bridge detect compile breakage
  o [libata] fix printk warning

John W. Linville:
  o libata: SMART support via ATA pass-thru

Nishanth Aravamudan:
  o scsi/ahci: replace schedule_timeout() with msleep()/ssleep()

