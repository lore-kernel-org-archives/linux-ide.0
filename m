From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/9] libata sense code update
Date: Fri, 27 Mar 2015 16:46:29 +0100
Message-ID: <1427471198-62676-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41467 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284AbbC0Pqm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Mar 2015 11:46:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>

Hi all,

with ACS-4 ATA drives inherited the possibility to return
SCSI sense codes, allowing for a more precise error handling.
Not to mention a nice alignment with the SCSI error handling.
This patchset implements both, support for NCQ Autosense and
the sense data reporting feature set.
Plus some whitespace and assorted cleanups.
And I've added some tracepoints, too.

Hannes Reinecke (9):
  libata: use READ_LOG_DMA_EXT
  libata: whitespace cleanup in ata_get_cmd_descript()
  libata: whitespace fixes in ata_to_sense_error()
  ide,ata: Rename ATA_IDX to ATA_SENSE
  libata: use status bit definitions in ata_dump_status()
  libata: Implement NCQ autosense
  libata: Implement support for sense data reporting
  libata-eh: Set 'information' field for autosense
  libata: Add tracepoints

 drivers/ata/Makefile          |   3 +-
 drivers/ata/libata-core.c     |  32 ++++-
 drivers/ata/libata-eh.c       | 168 ++++++++++++++++++----
 drivers/ata/libata-scsi.c     | 111 ++++++++++-----
 drivers/ata/libata-trace.c    | 151 ++++++++++++++++++++
 drivers/ata/libata.h          |   6 +-
 drivers/ide/ide-lib.c         |   4 +-
 drivers/ide/ide-probe.c       |   2 +-
 drivers/scsi/scsi_error.c     |  31 ++++
 include/linux/ata.h           |  29 +++-
 include/scsi/scsi_eh.h        |   1 +
 include/trace/events/libata.h | 325 ++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 786 insertions(+), 77 deletions(-)
 create mode 100644 drivers/ata/libata-trace.c
 create mode 100644 include/trace/events/libata.h

-- 
1.8.5.2

