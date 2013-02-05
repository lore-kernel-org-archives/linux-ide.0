From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: [PATCH v2 0/2]	Adding SATA PHY framework and PHY controller driver
Date: Tue,  5 Feb 2013 19:51:38 +0530
Message-ID: <1360074100-26357-1-git-send-email-vasanthananthan@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:57302 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab3BEOVu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2013 09:21:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, jgarzik@redhat.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, thomas.abraham@linaro.org, Vasanth Ananthan <vasanthananthan@gmail.com>

Changes since v1:
	
	1. Moved regs-sata.h to driver/ata/ and renamed to sata_exynos_phy.h

	2. Added support for getting the sata phy PMU control register base address
	   through device tree.

Vasanth Ananthan (2):
  driver: ata: SATA PHY framework
  driver: ata: add new Exynos5250 SATA PHY controller driver

 drivers/ata/Kconfig           |   20 +++
 drivers/ata/Makefile          |    2 +
 drivers/ata/sata_exynos_phy.c |  297 +++++++++++++++++++++++++++++++++++++++++
 drivers/ata/sata_exynos_phy.h |   31 +++++
 drivers/ata/sata_phy.c        |  146 ++++++++++++++++++++
 drivers/ata/sata_phy.h        |   29 ++++
 6 files changed, 525 insertions(+)
 create mode 100644 drivers/ata/sata_exynos_phy.c
 create mode 100644 drivers/ata/sata_exynos_phy.h
 create mode 100644 drivers/ata/sata_phy.c
 create mode 100644 drivers/ata/sata_phy.h

-- 
1.7.9.5

