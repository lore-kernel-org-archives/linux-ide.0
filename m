From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/4] ata: ahci_brcmstb: ALPM support
Date: Thu,  7 Jan 2016 16:03:29 -0800
Message-ID: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36561 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbcAHAE3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jan 2016 19:04:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Florian Fainelli <f.fainelli@gmail.com>

Hi Tejun,

This patch series contains a bunch of changes to the Broadcom AHCI driver
to support ALPM, disable DIPM (not supported) and updates the core libata
to account for driver-specific ALPM-resume procedure.

The last patch in this series allows some particular drivers, which are known
not to need the debounce delay while resuming SATA links to skip these, which
yields a faster resume time.

This is against your ata/for-next branch, thanks!

Danesh Petigara (4):
  ata: ahci_brcmstb: enable support for ALPM
  ata: ahci_brcmstb: disable DIPM support
  drivers: ata: wake port before DMA stop for ALPM
  libata: skip debounce delay on link resume

 drivers/ata/ahci.h         |  6 ++++++
 drivers/ata/ahci_brcmstb.c | 40 ++++++++++++++++++++++++++++++++++-
 drivers/ata/libahci.c      | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c  |  4 +++-
 include/linux/libata.h     |  5 +++++
 5 files changed, 105 insertions(+), 2 deletions(-)

-- 
2.1.0

