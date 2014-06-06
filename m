From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v0 0/2]ata: Fix the dma state machine lockup for APM X-Gene SoC
Date: Sat,  7 Jun 2014 02:58:52 +0530
Message-ID: <1402090134-23164-1-git-send-email-stripathi@apm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: tj@kernel.org, olof@lixom.net, arnd@arndb.de
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>
List-Id: linux-ide@vger.kernel.org

Suman Tripathi (2):
  libahci: Implement the restart_engine to restart the port dma engine.
  ata: Fix the dma state machine lockup for the PIO mode commands.

 drivers/ata/ahci_xgene.c  | 17 +++--------------
 drivers/ata/libahci.c     | 13 +++++++++++++
 drivers/ata/libata-core.c | 10 ++++++++++
 include/linux/libata.h    |  3 +++
 4 files changed, 29 insertions(+), 14 deletions(-)

--
1.8.2.1

