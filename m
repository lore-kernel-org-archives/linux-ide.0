From: Preetham Chandru Ramchandra <pchandru@nvidia.com>
Subject: [PATCH V3 0/3] ADD AHCI support for tegra210
Date: Fri, 12 May 2017 15:04:07 +0530
Message-ID: <1494581650-11115-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:40812 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756312AbdELJfK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 12 May 2017 05:35:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: thierry.reding@gmail.com, tj@kernel.org
Cc: tegra@vger.kernel.org, linux-ide@vger.kernel.org, ldewangan@nvidia.com, preetham260@gmail.com, vbyravarasu@nvidia.com, pkunapuli@nvidia.com, Preetham Chandru R <pchandru@nvidia.com>

From: Preetham Chandru R <pchandru@nvidia.com>

1. ADD AHCI support for tegra210
2. Extend the tegra AHCI controller device tree binding with tegra210
---
Preetham Chandru R (3):
  ata: ahci_tegra: Add AHCI support for tegra210
  dt-bindings: tegra: Add tegra210 AHCI
  arm64: tegra: Enable SATA on Tegra210

 .../bindings/ata/nvidia,tegra124-ahci.txt          |  45 ++-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   6 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  16 +
 drivers/ata/ahci_tegra.c                           | 377 ++++++++++++++++-----
 4 files changed, 346 insertions(+), 98 deletions(-)

-- 
2.1.4

