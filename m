From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata changes for v4.11-rc1
Date: Tue, 21 Feb 2017 17:12:36 -0500
Message-ID: <20170221221236.GD8260@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35422 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753003AbdBUWMi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Feb 2017 17:12:38 -0500
Received: by mail-yw0-f193.google.com with SMTP id l16so10708575ywb.2
        for <linux-ide@vger.kernel.org>; Tue, 21 Feb 2017 14:12:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello, Linus.

libata changes for v4.11-rc1.

* Bartlomiej added pata_falcon.
* Christoph is trying to remove use of static 4k buf.  It's still WIP.
* Config cleanup around HAS_DMA.
* Other fixes and driver-specific changes.

This pull causes a silent conflict between the following two commits.

* 7e11aabd48eb ("ata: add Atari Falcon PATA controller driver") - this tree
* aebf526b53ae ("block: fold cmd_type into the REQ_OP_ space") - block tree

The former adds derference of request->cmd_type and the latter removes
that field and replaces its use with accessors.  The conflict can be
fixed by replacing "cmd->request->cmd_type == REQ_TYPE_FS" test in
pata_falcon.c with "!blk_rq_is_passthrough(cmd->request)".  I'm
attaching the fix patch from Bartlomiej.

Thanks.

The following changes since commit 064c3db9c564cc5be514ac21fb4aa26cc33db746:

  ata: sata_mv:- Handle return value of devm_ioremap. (2017-01-06 15:45:32 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.11

for you to fetch changes up to 73b2951414f661e22dc4b88e4e6590c9406cf822:

  ata: pata_of_platform: using of_property_read_u32() helper (2017-01-24 11:15:01 -0500)

----------------------------------------------------------------
Andy Shevchenko (1):
      ata: sata_mv: Convert to devm_ioremap_resource()

Arnd Bergmann (1):
      ahci: imx: fix building without hwmon or thermal

Bartlomiej Zolnierkiewicz (3):
      ata: allow subsystem to be used on m68k arch
      ata: pass queued command to ->sff_data_xfer method
      ata: add Atari Falcon PATA controller driver

Christoph Hellwig (6):
      libata: avoid global response buffer in atapi_qc_complete
      libata: move struct ata_scsi_args to libata-scsi.c
      libata: remove the done callback from ata_scsi_args
      libata: call ->scsi_done from ata_scsi_simulate
      libata: don't call ata_scsi_rbuf_fill for command without a response buffer
      libata: switch to dynamic allocation instead of ata_scsi_rbuf

Csaba Kertesz (1):
      ahci: imx: Add imx53 SATA temperature sensor support

Darren Stevens (2):
      libata-sff: Don't scan disabled ports when checking for legacy mode.
      pata_atiixp: Don't use unconnected secondary port on SB600/SB700

Geert Uytterhoeven (7):
      ata: SATA_MV should depend on HAS_DMA
      ata: SATA_HIGHBANK should depend on HAS_DMA
      ata: ATA_BMDMA should depend on HAS_DMA
      ata: AHCI and other non-SFF native drivers should depend on HAS_DMA
      libata: Make ata_sg_clean() static again
      libata: Protect DMA core code by #ifdef CONFIG_HAS_DMA
      libata-eh: Use switch() instead of sparse array for protocol strings

Kefeng Wang (1):
      ata: pata_of_platform: using of_property_read_u32() helper

Michał Kępień (1):
      ata: ahci_xgene: free structure returned by acpi_get_object_info()

Tang Yuantian (3):
      ahci: qoriq: added a condition to enable dma coherence
      ahci: qoriq: report error when ecc register address is missing in dts
      ahci: qoriq: added ls2088a platforms support

Tejun Heo (3):
      Merge branch 'for-4.10-fixes' into for-4.11
      Revert "libata: switch to dynamic allocation instead of ata_scsi_rbuf"
      pata_octeon_cf: remove unused local variables from octeon_cf_set_piomode()

Uwe Kleine-König (1):
      ata: sata_mv: fix module license specification

 drivers/ata/Kconfig            |  19 +++-
 drivers/ata/Makefile           |   1 +
 drivers/ata/ahci_imx.c         | 196 +++++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci_qoriq.c       |  35 ++++++--
 drivers/ata/ahci_xgene.c       |   6 +-
 drivers/ata/libata-core.c      |  61 +++++++------
 drivers/ata/libata-eh.c        |  44 ++++++---
 drivers/ata/libata-scsi.c      |  97 ++++++++------------
 drivers/ata/libata-sff.c       |  45 ++++++----
 drivers/ata/libata.h           |   8 --
 drivers/ata/pata_at91.c        |   6 +-
 drivers/ata/pata_atiixp.c      |   5 ++
 drivers/ata/pata_bf54x.c       |   7 +-
 drivers/ata/pata_ep93xx.c      |   4 +-
 drivers/ata/pata_falcon.c      | 184 ++++++++++++++++++++++++++++++++++++++
 drivers/ata/pata_ixp4xx_cf.c   |   4 +-
 drivers/ata/pata_legacy.c      |  15 ++--
 drivers/ata/pata_octeon_cf.c   |  20 ++---
 drivers/ata/pata_of_platform.c |   9 +-
 drivers/ata/pata_pcmcia.c      |   6 +-
 drivers/ata/pata_samsung_cf.c  |   4 +-
 drivers/ata/sata_mv.c          |  15 ++--
 drivers/ata/sata_rcar.c        |   4 +-
 include/linux/libata.h         |   8 +-
 24 files changed, 612 insertions(+), 191 deletions(-)
 create mode 100644 drivers/ata/pata_falcon.c

-- 
tejun

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-pata_falcon-build-fix-for-block-layer-changes.patch"

>From 57cee661f97369660077a0d62764dfa50e0a0b5a Mon Sep 17 00:00:00 2001
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 21 Feb 2017 17:11:23 -0500
Subject: [PATCH] pata_falcon: build fix for block layer changes

commit aebf526b53ae ("block: fold cmd_type into the REQ_OP_
space") from the block tree removes cmd_type so pata_falcon
needs the following trivial update to make it build again.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/pata_falcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 7826408..5b0c57d 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -54,7 +54,7 @@ static unsigned int pata_falcon_data_xfer(struct ata_queued_cmd *qc,
 	bool swap = 1;
 
 	if (dev->class == ATA_DEV_ATA && cmd && cmd->request &&
-	    cmd->request->cmd_type == REQ_TYPE_FS)
+	    !blk_rq_is_passthrough(cmd->request))
 		swap = 0;
 
 	/* Transfer multiple of 2 bytes */
-- 
2.9.3


--d6Gm4EdcadzBjdND--
