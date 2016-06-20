From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/6] libata: Fixup ATA NCQ NON-DATA commands
Date: Mon, 20 Jun 2016 13:39:10 +0200
Message-ID: <1466422756-126637-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35399 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754685AbcFTLyE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Jun 2016 07:54:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

Hi Tejun,

Damien pointed out that we're not handling ATA NCQ NON-Data commands
correctly. This patchset fixes this.

As usual, comments and reviews are welcome.

Hannes Reinecke (6):
  libata: use ata_is_ncq() accessors
  libsas: use ata_is_ncq() and ata_has_dma() accessors
  ata: add ata_is_fpdma() accessor
  ata: fixup ATA_PROT_NODATA
  libata-eh: decode all taskfile protocols
  ata: Handle ATA NCQ NO-DATA commands correctly

 drivers/ata/libahci.c         |  2 +-
 drivers/ata/libata-core.c     |  8 ++++----
 drivers/ata/libata-eh.c       |  8 ++++++--
 drivers/ata/libata-scsi.c     |  9 ++++++---
 drivers/ata/sata_dwc_460ex.c  |  2 ++
 drivers/ata/sata_fsl.c        |  4 ++--
 drivers/ata/sata_mv.c         |  5 ++---
 drivers/ata/sata_nv.c         | 11 +++++------
 drivers/scsi/libsas/sas_ata.c |  9 ++-------
 include/linux/ata.h           |  1 +
 include/linux/libata.h        |  8 ++++++++
 include/trace/events/libata.h |  1 +
 12 files changed, 40 insertions(+), 28 deletions(-)

-- 
1.8.5.6

