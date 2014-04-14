From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v2 5/5] ARM: configs: add ahci_mvebu to multi_v7_defconfig
Date: Mon, 14 Apr 2014 16:34:15 +0200
Message-ID: <1397486055-16303-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60372 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752768AbaDNOeX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2014 10:34:23 -0400
In-Reply-To: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The Marvell Armada 38x platform needs the ahci_mvebu driver enabled
for the AHCI interfaces, so this commit enables the corresponding
Kconfig option in multi_v7_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47..59f7ede 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -116,6 +116,7 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_ATA=y
+CONFIG_AHCI_MVEBU=y
 CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_SATA_HIGHBANK=y
 CONFIG_SATA_MV=y
-- 
1.8.3.2

