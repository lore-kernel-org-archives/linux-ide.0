From: Preetham Chandru Ramchandra <pchandru@nvidia.com>
Subject: [PATCH  0/2] ADD AHCI support for tegra210
Date: Wed, 19 Oct 2016 23:45:54 +0530
Message-ID: <1476900956-23719-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:25942 "EHLO
        hkmmgate101.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S944339AbcJSSQ7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2016 14:16:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, swarren@wwwdotorg.org, thierry.reding@gmail.com, preetham260@gmail.com
Cc: ldewangan@nvidia.com, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com, Preetham Chandru R <pchandru@nvidia.com>

From: Preetham Chandru R <pchandru@nvidia.com>

1. ADD AHCI support for tegra210
2. Extend the tegra AHCI controller device tree binding with tegra210
   support
3. Add property node to enable/disable features like dipm, hipm, devslp,
   partial, slumber, ncq.

Preetham Chandru R (2):
  dt-bindings: ata: ahci_tegra: Add tegra210 AHCI support
  ata: ahci_tegra: add support for tegra210

 .../bindings/ata/nvidia,tegra124-ahci.txt          |  48 +-
 drivers/ata/ahci_tegra.c                           | 630 ++++++++++++++++-----
 2 files changed, 536 insertions(+), 142 deletions(-)

-- 
2.1.4

