From: Jeff Garzik <jgarzik@pobox.com>
Subject: [SATA] status report, libata-dev queue updated
Date: Fri, 5 Nov 2004 05:00:49 -0500
Message-ID: <20041105100049.GA31653@havoc.gtf.org>
Reply-To: linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:28547 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262632AbUKEKAu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Nov 2004 05:00:50 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Updated hardware and software SATA status reports:
	http://linux.yyz.us/sata/sata-status.html
	http://linux.yyz.us/sata/software-status.html

BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.10-rc1-bk14-libata1-dev1.patch.bz2

This will update the following files:

 drivers/scsi/Kconfig         |    8 
 drivers/scsi/Makefile        |    1 
 drivers/scsi/libata-core.c   |   38 ++
 drivers/scsi/libata-scsi.c   |  409 +++++++++++++++++++++++++
 drivers/scsi/libata.h        |    2 
 drivers/scsi/pata_pdc2027x.c |  694 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_promise.c  |   56 +++
 include/linux/ata.h          |    1 
 include/linux/libata.h       |    2 
 include/scsi/scsi.h          |    3 
 10 files changed, 1203 insertions(+), 11 deletions(-)

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
  o libata-scsi: get-identity ioctl support

Brad Campbell:
  o libata basic detection and errata for PATA->SATA bridges

Jeff Garzik:
  o [libata sata_promise] fix merge bugs
  o [libata] fix build breakage
  o [libata] fix SATA->PATA bridge detect compile breakage
  o [libata] fix printk warning

John W. Linville:
  o libata: SMART support via ATA pass-thru

