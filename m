From: Adam Manzanares <adam.manzanares@hgst.com>
Subject: [PATCH 0/3] Enabling ATA Command Priorities
Date: Tue, 27 Sep 2016 11:14:53 -0700
Message-ID: <1475000096-6148-1-git-send-email-adam.manzanares@hgst.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-block-owner@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
To: axboe@kernel.dk, tj@kernel.org
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org, Adam Manzanares <adam.manzanares@hgst.com>
List-Id: linux-ide@vger.kernel.org

This patch builds ATA commands with high priority if the iocontext
of a process is set to real time. The goal of the patch is to
improve tail latencies of workloads that use higher queue depths.

Adam Manzanares (3):
  block: Add iocontext priority to request
  ata: Enabling ATA Command Priorities
  ata: ATA Command Priority Disabled By Default

 drivers/ata/libahci.c     |  1 +
 drivers/ata/libata-core.c | 35 +++++++++++++++++++++-
 drivers/ata/libata-scsi.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h      |  2 +-
 include/linux/ata.h       |  6 ++++
 include/linux/libata.h    | 27 +++++++++++++++++
 6 files changed, 142 insertions(+), 3 deletions(-)

-- 
2.1.4

