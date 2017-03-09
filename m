From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Thu, 9 Mar 2017 14:09:30 +0530
Message-ID: <a3161cfc-56f7-4577-c37f-3798cdb03713@ti.com>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20161212135537epcas5p440bbb93d40f0c41b3754635733b09879@epcas5p4.samsung.com>
 <8ea5971a-338d-e8b9-6be8-8fe2658fc04d@ti.com> <1709119.SQyio4Ct6n@amdc3058>
 <1fd840c5-b0bb-726b-6357-669977c4ae5f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:44979 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdCIIkN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Mar 2017 03:40:13 -0500
In-Reply-To: <1fd840c5-b0bb-726b-6357-669977c4ae5f@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>

Hi Bartlomiej,

On Wednesday 08 March 2017 08:30 PM, Sekhar Nori wrote:

>> It took a while to get to it but here is the draft driver patch
>> against v4.11-rc1.  Please test.
> 
> I tested this on DM6446 EVM. I was able to mount existing partitions on 
> the hard disk and see that the directory listing looks good[1]. I will do 
> more tests (including comparing performance with old driver) tomorrow. I 

I completed the tests I wanted to, including some read/write/data 
integrity tests. Performance is same as before too.

Tested-by: Sekhar Nori <nsekhar@ti.com>

Here are the additional changes I did. These changes do not clash with 
what I have already queued for v4.12. That said, its probably better if 
I carry the platform pieces through my tree. Let me know how you want 
to proceed.

Thanks,
Sekhar

---8<---
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index b9a7cb98ffda..67db82999c06 100644
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
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 023480b75244..60a1f23890cd 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -744,7 +744,7 @@ static int davinci_phy_fixup(struct phy_device *phydev)
 	return 0;
 }
 
-#define HAS_ATA		IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
+#define HAS_ATA		IS_ENABLED(CONFIG_PATA_BK3710)
 
 #define HAS_NOR		IS_ENABLED(CONFIG_MTD_PHYSMAP)
 
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index f702d4fc8eb8..589f3c33c4a0 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -119,7 +119,7 @@ static struct platform_device davinci_nand_device = {
 	},
 };
 
-#define HAS_ATA		IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
+#define HAS_ATA		IS_ENABLED(CONFIG_PATA_BK3710)
 
 #ifdef CONFIG_I2C
 /* CPLD Register 0 bits to control ATA */
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 0a7838852649..075e304ce7be 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -163,7 +163,7 @@ static struct davinci_mmc_config davinci_ntosd2_mmc_config = {
 	.wires		= 4,
 };
 
-#define HAS_ATA		IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
+#define HAS_ATA		IS_ENABLED(CONFIG_PATA_BK3710)
 
 #define HAS_NAND	IS_ENABLED(CONFIG_MTD_NAND_DAVINCI)
 

