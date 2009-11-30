From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/6] ATA driver updates
Date: Mon, 30 Nov 2009 13:22:37 +0000
Message-ID: <20091130132005.27236.77890.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50825 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752276AbZK3NmN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Nov 2009 08:42:13 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org, davem@davemloft.net

(Cc'd Davem as the piccolo driver touches the drivers/ide/ide-pci-generic.c
 to update the PCI identifiers and keep them all in sync with the name
 corrections as pointed out by Bartlomiej)

---

Alan Cox (6):
      pata_piccolo: Driver for old Toshiba chipsets
      pata_ali: Fix regression with old devices
      pata: Update experimental tags
      cmd64x: implement serialization as per notes
      pata_sis: Implement MWDMA for the UDMA 133 capable chips
      pata_via: Blacklist some combinations of Transcend Flash and via


 drivers/ata/Kconfig           |   39 +++++++----
 drivers/ata/Makefile          |    1 
 drivers/ata/ata_generic.c     |    5 +
 drivers/ata/pata_ali.c        |    4 +
 drivers/ata/pata_cmd64x.c     |  116 ++++++++++++++++++++++++++++++++--
 drivers/ata/pata_piccolo.c    |  140 +++++++++++++++++++++++++++++++++++++++++
 drivers/ata/pata_sis.c        |   91 ++++++++++++++++++++-------
 drivers/ata/pata_via.c        |   27 ++++++++
 drivers/ide/ide-pci-generic.c |    3 +
 include/linux/pci_ids.h       |    7 +-
 10 files changed, 382 insertions(+), 51 deletions(-)
 create mode 100644 drivers/ata/pata_piccolo.c

-- 
"The IETF already has more than enough RFCs that codify the obvious, make
stupidity illegal, support truth, justice, and the IETF way, and generally
demonstrate the author is a brilliant and valuable Contributor to The
Standards Process." -- Vernon Schryver

