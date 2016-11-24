From: Preetham Chandru Ramchandra <pchandru@nvidia.com>
Subject: [PATCH v2 0/3] ADD AHCI support for tegra210
Date: Thu, 24 Nov 2016 13:13:35 +0530
Message-ID: <1479973418-21351-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7360 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbcKXHqu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Nov 2016 02:46:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, swarren@wwwdotorg.org, thierry.reding@gmail.com, preetham260@gmail.com
Cc: ldewangan@nvidia.com, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com, Preetham Chandru R <pchandru@nvidia.com>

From: Preetham Chandru R <pchandru@nvidia.com>

1. ADD AHCI support for tegra210
2. Add support to disable DIPM, HIPM, DevSlp,
   partial, slumber, NCQ features from DT.
3. Extend the tegra AHCI controller device tree binding with tegra210
---
Preetham Chandru R (3):
  ata: ahci_tegra: add support for tegra210
  ata: ahci_tegra: Add support to disable features
  dt-bindings: ata: ahci_tegra: Add tegra210 AHCI support

 .../bindings/ata/nvidia,tegra124-ahci.txt          |  48 +-
 drivers/ata/ahci_tegra.c                           | 581 ++++++++++++++++-----
 2 files changed, 483 insertions(+), 146 deletions(-)

-- 
2.1.4

