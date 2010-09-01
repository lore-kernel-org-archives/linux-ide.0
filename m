From: Tejun Heo <tj@kernel.org>
Subject: [PATCHSET #upstream] libata: reimplement LPM support
Date: Wed,  1 Sep 2010 17:50:03 +0200
Message-ID: <1283356208-1884-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35949 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755891Ab0IAPu1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Sep 2010 11:50:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Hello,

This patchset reimplement LPM support so that it's better integrated
with the rest of libata and supports more than just ALPM.  After the
patchset, DIPM works on ahci w/o ALPM support, host link of PMP can
use both H/DIPM and fan-out links supports DIPM, and ata_piix w/ SIDPR
also supports DIPM.

Adding DIPM support for other controllers should be easy and DIPM
actually works better than ALPM because DIPM implements sane timeout
before entering powersave mode and thus doesn't hurt throughput like
ALPM does.

Tested with intel and JMB ahci's, ich8 ata_piix, SIMG and marvell
PMPs.  SATA bus analyzer was used to verify links are actually
entering and coming out of powersave mode.

This patchset contains the following five patches

 0001-libata-clean-up-lpm-related-symbols-and-sysfs-show-s.patch
 0002-libata-implement-sata_link_scr_lpm-and-make-ata_dev_.patch
 0003-libata-reimplement-link-power-management.patch
 0004-libata-implement-LPM-support-for-port-multipliers.patch
 0005-ata_piix-implement-LPM-support.patch

and available in the folloing git tree

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git lpm

with the following changes.

 drivers/ata/ahci.c          |    3 
 drivers/ata/ahci.h          |    3 
 drivers/ata/ahci_platform.c |    3 
 drivers/ata/ata_piix.c      |   24 +++
 drivers/ata/libahci.c       |  160 ++++++-------------------
 drivers/ata/libata-core.c   |  276 +++++++++++---------------------------------
 drivers/ata/libata-eh.c     |  173 ++++++++++++++++++++++++---
 drivers/ata/libata-pmp.c    |   48 +++++++
 drivers/ata/libata-scsi.c   |   73 ++++-------
 drivers/ata/libata.h        |   12 +
 include/linux/libata.h      |   42 +++---
 11 files changed, 397 insertions(+), 420 deletions(-)

Thanks.

--
tejun
