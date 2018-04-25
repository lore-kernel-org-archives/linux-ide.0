From: <xswang@marvell.com>
Subject: [PATCH 0/2] Allow drivers to override stop_engine
Date: Wed, 25 Apr 2018 12:27:12 +0800
Message-ID: <1524630434-5914-1-git-send-email-xswang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
Cc: oferh@marvell.com, dingwei@marvell.com, xigu@marvell.com, nadavh@marvell.com, Evan Wang <xswang@marvell.com>
List-Id: linux-ide@vger.kernel.org

From: Evan Wang <xswang@marvell.com>

There are some special operations needed when stop engine
for Marvell AHCI IP, and it maybe needed by other vendors,
so it is necessary to allow to override ahci_stop_engine()
when stop the engine like overriding start_engine.

Evan Wang (2):
  libahci: Allow drivers to override stop_engine
  ata: ahci: mvebu: override ahci_stop_engine for mvebu AHCI

 drivers/ata/ahci.c          |  6 ++---
 drivers/ata/ahci.h          |  7 ++++++
 drivers/ata/ahci_mvebu.c    | 56 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci_qoriq.c    |  2 +-
 drivers/ata/ahci_xgene.c    |  4 ++--
 drivers/ata/libahci.c       | 20 +++++++++-------
 drivers/ata/sata_highbank.c |  2 +-
 7 files changed, 82 insertions(+), 15 deletions(-)

-- 
1.9.1
