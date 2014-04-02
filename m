From: Alexander Gordeev <agordeev@redhat.com>
Subject: [PATCH 0/2] ahci: Tweaks to the driver's PCI function
Date: Wed,  2 Apr 2014 10:19:55 +0200
Message-ID: <cover.1396426390.git.agordeev@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

The changes are against the latest Linus tree.

Cc: linux-ide@vger.kernel.org

Alexander Gordeev (2):
  ahci: Ensure "MSI Revert to Single Message" mode is not enforced
  ahci: Use pci_enable_msi_exact() instead of pci_enable_msi_range()

 drivers/ata/ahci.c |   25 +++++++++++++++++++++----
 drivers/ata/ahci.h |    1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
1.7.7.6
