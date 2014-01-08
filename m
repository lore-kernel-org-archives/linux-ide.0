From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 0/3] ata: ahci_platform: Add PHY support and OMAP support
Date: Wed, 8 Jan 2014 15:17:05 +0530
Message-ID: <1389174428-31414-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: sergei.shtylyov@cogentembedded.com, kishon@ti.com, b.zolnierkie@samsung.com, hdegoede@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-ide@vger.kernel.org

Hi,

Some platforms have a PHY hooked up to the SATA controller.
The PHY needs to be initialized and powered up for SATA to work.
We do that using the Generic PHY framework in PATCH 2.

In order to support SATA on the OMAP platforms we need to runtime
resume the device before use. PATCH 3 takes care of that.

PATCH 1 just updates the compatible list in the DT binding document.

Changelog:
v3:
- Addressed review comments and rebased on 3.13-rc7
- DT binding update moved to new patch.

v2:
- got rid of Texas Instruments SATA wrapper driver
- adressed review comments

cheers,
-roger

Balaji T K (1):
  ata: ahci_platform: Manage SATA PHY

Roger Quadros (2):
  ata: ahci_platform: Update DT compatible list
  ata: ahci_platform: runtime resume the device before use

 .../devicetree/bindings/ata/ahci-platform.txt      |  4 ++-
 drivers/ata/ahci.h                                 |  2 ++
 drivers/ata/ahci_platform.c                        | 41 +++++++++++++++++++++-
 3 files changed, 45 insertions(+), 2 deletions(-)

-- 
1.8.3.2
