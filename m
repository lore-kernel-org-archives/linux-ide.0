From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata ZAC changes for v4.7-rc1
Date: Mon, 23 May 2016 11:04:35 -0400
Message-ID: <20160523150435.GA5873@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>
List-Id: linux-ide@vger.kernel.org

Hello, Linus.

This pull request contains Zone ATA Command support for Shingled
Magnetic Recording devices.  In addition to sending the new commands
down to the device, as ZAC commands depend on getting a lot of
responses from the device, piping up responses is beefed up too.
However, it doesn't involve changes to libata core mechanism or its
interaction with upper layers, so I'm not expecting too many fallouts.
Kudos to Hannes for driving SMR support.

Thanks.

The following changes since commit 13f307711b127d30fcf333a04365a217baf9ca2b:

  megaraid_sas: Downgrade two success messages to info (2016-05-05 21:03:52 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.7-zac

for you to fetch changes up to 6d1003ae8db228b74ef61536364cd2a1bd973dd8:

  libata: support host-aware and host-managed ZAC devices (2016-05-09 12:36:46 -0400)

----------------------------------------------------------------
Hannes Reinecke (28):
      libata: Implement NCQ autosense
      libata: Implement support for sense data reporting
      libata-scsi: sanitize ata_gen_ata_sense()
      libata: sanitize ata_tf_read_block()
      libata-scsi: use scsi_set_sense_information()
      libata-eh: Set 'information' field for autosense
      libata-scsi: use ata_scsi_set_sense()
      libata: evaluate SCSI sense code
      libata-scsi: generate correct ATA pass-through sense
      libata: Implement control mode page to select sense format
      scsi: add scsi_set_sense_field_pointer()
      libata-scsi: Set field pointer in sense code
      libata-scsi: set bit pointer for sense code information
      libata-scsi: Set information sense field for invalid parameter
      libata: do not attempt to retrieve sense code twice
      libsas: enable FPDMA SEND/RECEIVE
      libata/libsas: Define ATA_CMD_NCQ_NON_DATA
      libata: Separate out ata_dev_config_ncq_send_recv()
      libata: Add command definitions for NCQ Encapsulation for READ LOG DMA EXT
      libata: Check log page directory before accessing pages
      libata-trace: decode subcommands
      libata-scsi: Generate sense code for disabled devices
      libata: fixup ZAC device disabling
      libata: implement ZBC IN translation
      libata: Implement ZBC OUT translation
      libata: NCQ encapsulation for ZAC MANAGEMENT OUT
      libata: support device-managed ZAC devices
      libata: support host-aware and host-managed ZAC devices

Tejun Heo (1):
      Merge branch '4.7/scsi-queue' of git://git.kernel.org/.../mkp/scsi into for-4.7-zac

 drivers/ata/libahci.c                  |   4 +-
 drivers/ata/libata-core.c              | 215 +++++++++-
 drivers/ata/libata-eh.c                | 113 ++++-
 drivers/ata/libata-scsi.c              | 752 +++++++++++++++++++++++++++------
 drivers/ata/libata-trace.c             |  72 ++++
 drivers/ata/libata.h                   |   8 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   3 +
 drivers/scsi/isci/request.c            |   5 +-
 drivers/scsi/libsas/sas_ata.c          |   7 +-
 drivers/scsi/mvsas/mv_sas.c            |   5 +-
 drivers/scsi/pm8001/pm8001_sas.c       |   5 +-
 drivers/scsi/scsi_common.c             |  53 +++
 drivers/scsi/scsi_error.c              |   3 +-
 include/linux/ata.h                    |  72 +++-
 include/linux/libata.h                 |  35 +-
 include/scsi/scsi_common.h             |   1 +
 include/scsi/scsi_eh.h                 |   1 +
 include/trace/events/libata.h          |  10 +-
 18 files changed, 1181 insertions(+), 183 deletions(-)

-- 
tejun
