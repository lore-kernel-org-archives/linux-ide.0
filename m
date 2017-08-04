From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 0/9] Ata ceva patches
Date: Fri,  4 Aug 2017 15:18:09 +0200
Message-ID: <cover.1501852693.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Alexander Graf <agraf@suse.de>, Tejun Heo <tj@kernel.org>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

Hi,

this patchset contains the latest changes which are available in Xilinx tree.

Thanks,
Michal


Anurag Kumar Vulisha (9):
  devicetree: bindings: Add sata port phy config parameters in ahci-ceva
  ata: ceva: Move sata port phy oob settings to device-tree
  ata: ceva: Add gen 3 mode support in driver
  ata: ceva: Disable Device Sleep capability
  ata: ceva: Make RxWaterMark value as module parameter
  ata: ceva: Add CCI support for SATA if CCI is enabled
  ata: ceva: Correct the AXI bus configuration for SATA ports
  ata: ceva: Correct the suspend and resume logic for SATA
  ata: ceva: Add SMMU support for SATA IP

 .../devicetree/bindings/ata/ahci-ceva.txt          |  39 ++++
 drivers/ata/ahci_ceva.c                            | 197 +++++++++++++++++----
 2 files changed, 198 insertions(+), 38 deletions(-)

-- 
1.9.1
