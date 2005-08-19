From: Jeff Garzik <jgarzik@pobox.com>
Subject: [git] libata-dev queue updated
Date: Thu, 18 Aug 2005 23:54:37 -0400
Message-ID: <20050819035437.GA18324@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932557AbVHSDyj@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org



I finally got around to creating something that has been missing since
BitKeeper disappeared, and something that Andrew has been wanting
from me for a while:  an amalgamation of all the libata-dev branches
that I maintain internally.

First, a bit of background.  Most patches I receive are dumped
into the 'upstream' branch of libata-dev.git.  However, some patches
require more development or review before they are ready for upstream.
In such cases, patches are divided into branches by category: ncq (NCQ
queueing support), chs-support (C/H/S support), adma (new ADMA driver),
sil24 (new Silicon Image 312x driver), passthru (ATA passthrough/SMART
support), etc.

All these branches are terribly useful to me.  Dividing the changes
up in this manner means that some less-cooked changes can stay in the
git repository, while I can forward important changes to Andrew/Linus
immediately.  The downside is that this system leaves people with a
confusing set of branches.

The solution is something that I maintained during the BitKeeper
days, the "ALL" branch.  As the name implies, this branch contains
all the branches in libata-dev.git.  The creation of this branch also
facilitates the creation of a single downloadable patch (see below)
that users can easily patch into their kernel, without having to
learn git.


To Andrew Morton specifically:  Please replace all git-libata-* patches
with the content of the 'ALL' branch.  You can simply pull the 'ALL'
branch, and ignore all others.


The following is the current contents of the libata-dev queue's ALL
branch, which is a superset of all other branches in the repository:

git users:   'ALL' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.13-rc6-git10-libata1.patch.bz2



 drivers/scsi/Kconfig         |   26 +
 drivers/scsi/Makefile        |    3 
 drivers/scsi/ahci.c          |    2 
 drivers/scsi/ata_adma.c      |  786 ++++++++++++++++++++++++++++++++++
 drivers/scsi/ata_piix.c      |   14 
 drivers/scsi/libata-core.c   |  284 ++++++++++--
 drivers/scsi/libata-scsi.c   |  984 ++++++++++++++++++++++++++++++++++---------
 drivers/scsi/libata.h        |    5 
 drivers/scsi/pata_pdc2027x.c |  847 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_nv.c       |   21 
 drivers/scsi/sata_promise.c  |   56 ++
 drivers/scsi/sata_qstor.c    |    2 
 drivers/scsi/sata_sil.c      |    4 
 drivers/scsi/sata_sil24.c    |  785 ++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_sis.c      |    2 
 drivers/scsi/sata_svw.c      |   10 
 drivers/scsi/sata_sx4.c      |  138 +++---
 drivers/scsi/sata_uli.c      |    2 
 drivers/scsi/sata_via.c      |    2 
 drivers/scsi/sata_vsc.c      |    2 
 include/linux/ata.h          |   16 
 include/linux/libata.h       |    9 
 include/linux/pci_ids.h      |    1 
 include/scsi/scsi.h          |    3 
 24 files changed, 3671 insertions(+), 333 deletions(-)



Albert Lee:
  [libata] C/H/S support, for older devices
  [libata] add driver for Promise PATA 2027x
  libata-dev-2.6: pdc2027x add ata_scsi_ioctl
  libata-dev-2.6: pdc2027x change comments
  libata-dev-2.6: pdc2027x move the PLL counter reading code
  libata-dev-2.6: pdc2027x PLL input clock detection fix
  libata ata_data_xfer() fix
  libata handle the case when device returns/needs extra data
  libata-dev: Convert pdc2027x from PIO to MMIO
  libata-dev: pdc2027x use "long" for counter data type
  libata-dev: pdc2027x ATAPI DMA lost irq problem workaround

Daniel Drake:
  sata_nv: Support MCP51/MCP55 device IDs

Douglas Gilbert:
  [libata scsi] add START STOP UNIT translation

Erik Benada:
  [libata sata_promise] support PATA ports on SATA controllers

Jason Gaston:
  ahci: AHCI mode SATA patch for Intel ICH7-M DH

Jeff Garzik:
  [libata] add new driver ata_adma
  [libata adma] enable PCI MWI during controller initialization
  [libata] ATA passthru (arbitrary ATA command execution)
  [libata] ata_adma: update for recent ->host_stop() API changes
  [libata] pata_pdc2027x: update for recent ->host_stop() API changes
  libata: Update 'passthru' branch for latest libata
  libata: trim trailing whitespace.

Tejun Heo:
  SATA: rewritten sil24 driver
  sil24: add FIXME comment above ata_device_add
  sil24: remove irq disable code on spurious interrupt
  sil24: add testing for PCI fault
  sil24: move error handling out of hot interrupt path
  sil24: remove PORT_TF
  sil24: replace pp->port w/ ap->ioaddr.cmd_addr
  sil24: fix PORT_CTRL_STAT constants
  sil24: add more comments for constants
