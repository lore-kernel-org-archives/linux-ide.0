From: Jeff Garzik <jgarzik@pobox.com>
Subject: [SATA] libata-2.4 backport queue updated
Date: Thu, 10 Mar 2005 14:26:50 -0500
Message-ID: <42309F7A.6090207@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000505040601020808010001"
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64673 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262962AbVCJT1N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Mar 2005 14:27:13 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000505040601020808010001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Updated libata 2.4.x branch to 2.4.30-pre3.

Patch URL, BK URL, and list of changes attached.

	Jeff



--------------000505040601020808010001
Content-Type: text/plain;
 name="libata-2.4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-2.4.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/libata-2.4

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.30-pre3-libata1.patch.bz2

This will update the following files:

 Documentation/DocBook/Makefile    |    2 
 Documentation/DocBook/libata.tmpl |    5 ++
 drivers/pci/quirks.c              |   85 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ahci.c               |   15 +++++-
 drivers/scsi/ata_piix.c           |    3 -
 drivers/scsi/libata-core.c        |   24 ++++++++--
 include/linux/ioport.h            |    1 
 kernel/ksyms.c                    |    1 
 kernel/resource.c                 |   10 ++++
 9 files changed, 138 insertions(+), 8 deletions(-)

through these ChangeSets:

Arjan van de Ven:
  o [libata ata_piix] Use standard headers from include/scsi, not drivers/scsi

Brett Russ:
  o AHCI: fix fatal error int handling

Jason Gaston:
  o [PCI] update SATA PCI quirk for Intel ICH7

Jeff Garzik:
  o [libata ahci] support ->tf_read hook
  o [PCI, libata] Fix "combined mode" PCI quirk for ICH6
  o [libata ata_piix] re-enable combined mode support
  o [libata ata_piix] ->qc_prep hook
  o [libata ata_piix] fix DocBook docs
  o [libata ata_piix] add ->bmdma_setup hook
  o [libata] re-merge the rest of the 2.4 junk


--------------000505040601020808010001--
