From: Robert Richter <rric@kernel.org>
Subject: [PATCH v4 0/3] AHCI: Add generic MSI-X interrupt support to SATA PCI driver
Date: Sun, 31 May 2015 13:55:16 +0200
Message-ID: <1433073319-13796-1-git-send-email-rric@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36893 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbbEaLz3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 May 2015 07:55:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Richter <rrichter@cavium.com>

From: Robert Richter <rrichter@cavium.com>

This patch set adds generic support for MSI-X interrupts to the SATA
PCI driver.

The first 2 patches rework the code, one splits msi and intx code into
separate functions, the other changes interrupt initialization to
store the irq number in the ahci data structure (struct
ahci_host_priv). Both changes are needed to implement MSI-X support in
the last 3rd patch.

v4:
 * removed implementation of ahci_init_intx()
 * improved patch descriptions
 * rebased onto libata/for-4.2

v3:
 * store irq number in struct ahci_host_priv
 * change initialization order from msix-msi-intx to msi-msix-intx
 * improve comments in ahci_init_msix()
 * improve error message in ahci_init_msix()
 * do not enable MSI-X if MSI is actively disabled for the device

v2:
 * determine irq vector from pci_dev->msi_list


Robert Richter (3):
  ahci: Move interrupt enablement code to a separate function
  ahci: Store irq number in struct ahci_host_priv
  AHCI: Add generic MSI-X interrupt support to SATA PCI driver

 drivers/ata/acard-ahci.c       |   4 +-
 drivers/ata/ahci.c             | 133 ++++++++++++++++++++++++++++++++++++-----
 drivers/ata/ahci.h             |   4 +-
 drivers/ata/libahci.c          |  16 +++--
 drivers/ata/libahci_platform.c |   4 +-
 drivers/ata/sata_highbank.c    |   3 +-
 6 files changed, 135 insertions(+), 29 deletions(-)

-- 
2.1.1

