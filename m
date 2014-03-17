From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/4] ata: add remaining new-style AHCI platform drivers
Date: Mon, 17 Mar 2014 19:31:54 +0100
Message-ID: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:19937 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313AbaCQScO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Mar 2014 14:32:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, spear-devel@list.st.com, b.zolnierkie@samsung.com

Hi,

This patch series adds new-style AHCI platform drivers for DaVinci DA850
AHCI controller and ST SPEAr1340 AHCI controller.  As a preparation for
adding these drivers it also fixes ahci_platform_data->suspend() handling
(patch #1) and moves library AHCI platform code to its own file (patch #2).
The new AHCI platform drivers are only compile tested (they are marked as
experimental because of this) and I would ask somebody with the hardware
to verify them (thanks!).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (4):
  ata: ahci_platform: fix ahci_platform_data->suspend method handling
  ata: move library code from ahci_platform.c to libahci_platform.c
  ata: add new-style AHCI platform driver for DaVinci DA850 AHCI
    controller
  ata: add new-style AHCI platform driver for ST SPEAr1340 AHCI
    controller

 drivers/ata/Kconfig            |  23 +-
 drivers/ata/Makefile           |  10 +-
 drivers/ata/ahci_da850.c       | 178 ++++++++++++++
 drivers/ata/ahci_platform.c    | 508 --------------------------------------
 drivers/ata/ahci_spear1340.c   | 222 +++++++++++++++++
 drivers/ata/libahci_platform.c | 541 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 967 insertions(+), 515 deletions(-)
 create mode 100644 drivers/ata/ahci_da850.c
 create mode 100644 drivers/ata/ahci_spear1340.c
 create mode 100644 drivers/ata/libahci_platform.c

-- 
1.8.2.3

