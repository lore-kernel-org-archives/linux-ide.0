From: Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/3] Initial ZAC support
Date: Wed,  5 Nov 2014 13:08:19 +0100
Message-ID: <1415189302-108476-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47822 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754066AbaKEMIY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Nov 2014 07:08:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <jbottomley@parallels.com>
Cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>

Hi all,

this patchset updates the ATA stack to correctly detect
host-managed ZAC devices.

Hannes Reinecke (3):
  libsas: use ata_dev_classify()
  libata: Implement ATA_DEV_ZAC
  libata-scsi: Update SATL for ZAC drives

 drivers/ata/libata-core.c           | 20 +++++++----
 drivers/ata/libata-eh.c             |  7 ++--
 drivers/ata/libata-scsi.c           | 30 +++++++++++++++--
 drivers/ata/libata-transport.c      |  1 +
 drivers/scsi/aic94xx/aic94xx_task.c | 10 +++---
 drivers/scsi/isci/request.c         |  4 +--
 drivers/scsi/libsas/sas_ata.c       | 66 +++++++------------------------------
 drivers/scsi/mvsas/mv_sas.c         |  4 +--
 drivers/scsi/pm8001/pm8001_hwi.c    |  2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c    |  2 +-
 include/linux/libata.h              |  6 ++--
 include/scsi/libsas.h               | 11 ++-----
 12 files changed, 76 insertions(+), 87 deletions(-)

-- 
1.8.5.2

