From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata sata_dwc_460ex changes for v4.7-rc1
Date: Mon, 23 May 2016 11:09:34 -0400
Message-ID: <20160523150934.GB5873@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33556 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbcEWPJg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2016 11:09:36 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>

Hello, Linus.

Patches to bring sata_dwc_460ex up to snuff.  It's a separate pull
request because it depends on dmaengine dw platform changes which are
now in mainline.

Thanks.

The following changes since commit 3a14c66d43d018baed96ceb74f9ab548878c09b8:

  dmaengine: dw: pass platform data via struct dw_dma_chip (2016-05-02 15:31:05 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.7-dw

for you to fetch changes up to 7598469a6184e1017a77ebe78b5b66c52a6afc1c:

  ata: dwc: add DMADEVICES dependency (2016-05-12 12:04:13 -0400)

----------------------------------------------------------------
Andy Shevchenko (11):
      ata: sata_dwc_460ex: set dma_boundary to 0x1fff
      ata: sata_dwc_460ex: burst size must be in items not bytes
      ata: sata_dwc_460ex: DMA is always a flow controller
      ata: sata_dwc_460ex: select only core part of DMA driver
      ata: sata_dwc_460ex: don't call ata_sff_qc_issue() on DMA commands
      ata: sata_dwc_460ex: correct HOSTDEV{P}_FROM_*() macros
      ata: sata_dwc_460ex: switch to new dmaengine_terminate_* API
      ata: sata_dwc_460ex: use devm_ioremap
      ata: sata_dwc_460ex: supply physical address of FIFO to DMA
      ata: sata_dwc_460ex: make debug messages neat
      powerpc/4xx: Device tree update for the 460ex DWC SATA

Arnd Bergmann (1):
      ata: dwc: add DMADEVICES dependency

Christian Lamparter (1):
      ata: sata_dwc_460ex: fix crash on offline links without an attached drive

Mans Rullgard (11):
      ata: sata_dwc_460ex: remove incorrect locking
      ata: sata_dwc_460ex: skip dma setup for non-dma commands
      ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
      ata: sata_dwc_460ex: add phy support
      ata: sata_dwc_460ex: get rid of global data
      ata: sata_dwc_460ex: remove empty libata callback
      ata: sata_dwc_460ex: get rid of some pointless casts
      ata: sata_dwc_460ex: get rid of incorrect cast
      ata: sata_dwc_460ex: add __iomem to register base pointer
      ata: sata_dwc_460ex: use readl/writel_relaxed()
      ata: sata_dwc_460ex: tidy up sata_dwc_clear_dmacr()

 arch/powerpc/boot/dts/canyonlands.dts |  15 +-
 drivers/ata/Kconfig                   |  13 +-
 drivers/ata/sata_dwc_460ex.c          | 552 +++++++++++++++++-----------------
 3 files changed, 306 insertions(+), 274 deletions(-)

-- 
tejun
