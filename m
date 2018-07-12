From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/3] ata: ahci_platform: minor fixes
Date: Thu, 12 Jul 2018 11:41:28 +0000
Message-ID: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

Hello

This patchset fixes some minor problem found when working on supporting
allwinner R40 AHCI.

Regards

Corentin Labbe (3):
  ata: ahci_platform: correct parameter documentation for
    ahci_platform_shutdown
  ata: ahci_platform: convert kzallloc to kcalloc
  ata: ahci_platform: convert kcalloc to devm_kcalloc

 drivers/ata/libahci_platform.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
2.16.4
