From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3/3] ARM: davinci_all_defconfig: convert to use libata PATA
Date: Thu, 09 Mar 2017 14:01:36 +0100
Message-ID: <1489064496-6270-4-git-send-email-b.zolnierkie@samsung.com>
References: <1489064496-6270-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170309130223epcas5p21264a08eab66d1d95561d6c79829afc1@epcas5p2.samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45632 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754624AbdCINEZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Mar 2017 08:04:25 -0500
In-reply-to: <1489064496-6270-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

From: Sekhar Nori <nsekhar@ti.com>

IDE subsystem has been deprecated since 2009 and the majority
(if not all) of Linux distributions have switched to use
libata for ATA support exclusively.  However there are still
some users (mostly old or/and embedded non-x86 systems) that
have not converted from using IDE subsystem to libata PATA
drivers.  This doesn't seem to be good thing in the long-term
for Linux as while there is less and less PATA systems left
in use:

* testing efforts are divided between two subsystems

* having duplicate drivers for same hardware confuses users

This patch converts davinci_all_defconfig to use libata PATA
drivers.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
[b.zolnierkie: split from bigger patch + added patch description]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/davinci_all_defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index c8663ea..93aab3d 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -74,12 +74,10 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_EEPROM_AT24=y
-CONFIG_IDE=m
-CONFIG_BLK_DEV_PALMCHIP_BK3710=m
-CONFIG_SCSI=m
 CONFIG_BLK_DEV_SD=m
 CONFIG_ATA=m
 CONFIG_AHCI_DA850=m
+CONFIG_PATA_BK3710=m
 CONFIG_NETDEVICES=y
 CONFIG_NETCONSOLE=y
 CONFIG_TUN=m
-- 
1.9.1

