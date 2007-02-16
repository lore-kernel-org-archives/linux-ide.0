From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries
 CD drives
Date: Fri, 16 Feb 2007 17:51:06 +0300
Message-ID: <45D5C4DA.2040609@ru.mvista.com>
References: <20070210203512.GA25586@aepfle.de>	<20070210203614.GA25602@aepfle.de>	<45D4E82B.7020403@garzik.org> <20070216092046.GA2572@aepfle.de> <45D5B720.4010308@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:51090 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S964960AbXBPOvP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Feb 2007 09:51:15 -0500
In-Reply-To: <45D5B720.4010308@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello, I wrote:

>>Change the default for the built-in IDE on p610/p615/p630 from
>>ide to libata. libata has better error handling and the drive can
>>recover when hald does its CD media polling.

>>Signed-off-by: Olaf Hering <olaf@aepfle.de>

>>Index: linux-2.6.20/arch/powerpc/configs/ppc64_defconfig
>>===================================================================
>>--- linux-2.6.20.orig/arch/powerpc/configs/ppc64_defconfig
>>+++ linux-2.6.20/arch/powerpc/configs/ppc64_defconfig
>>@@ -500,7 +500,7 @@ CONFIG_BLK_DEV_AMD74XX=y
>> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
>> # CONFIG_BLK_DEV_SVWKS is not set
>> # CONFIG_BLK_DEV_SIIMAGE is not set
>>-CONFIG_BLK_DEV_SL82C105=y
>>+# CONFIG_BLK_DEV_SL82C105 is not set
>> # CONFIG_BLK_DEV_SLC90E66 is not set
>> # CONFIG_BLK_DEV_TRM290 is not set
>> # CONFIG_BLK_DEV_VIA82CXXX is not set
>>@@ -646,7 +646,7 @@ CONFIG_SATA_SVW=y
>> # CONFIG_PATA_SIL680 is not set
>> # CONFIG_PATA_SIS is not set
>> # CONFIG_PATA_VIA is not set
>>-# CONFIG_PATA_WINBOND is not set
>>+CONFIG_PATA_WINBOND=y
>> 
>> #
>> # Multi-device support (RAID and LVM)
>>Index: linux-2.6.20/arch/powerpc/configs/pseries_defconfig
>>===================================================================
>>--- linux-2.6.20.orig/arch/powerpc/configs/pseries_defconfig
>>+++ linux-2.6.20/arch/powerpc/configs/pseries_defconfig
>>@@ -483,7 +483,7 @@ CONFIG_BLK_DEV_AMD74XX=y
>> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
>> # CONFIG_BLK_DEV_SVWKS is not set
>> # CONFIG_BLK_DEV_SIIMAGE is not set
>>-CONFIG_BLK_DEV_SL82C105=y
>>+# CONFIG_BLK_DEV_SL82C105 is not set
>> # CONFIG_BLK_DEV_SLC90E66 is not set
>> # CONFIG_BLK_DEV_TRM290 is not set
>> # CONFIG_BLK_DEV_VIA82CXXX is not set
>>@@ -628,7 +628,7 @@ CONFIG_ATA=y
>> # CONFIG_PATA_SIL680 is not set
>> # CONFIG_PATA_SIS is not set
>> # CONFIG_PATA_VIA is not set
>>-# CONFIG_PATA_WINBOND is not set
>>+CONFIG_PATA_WINBOND=y

>     I'm sorry, how those 2 drivers can be equivalent?! The pata_winbond driver 

    Sorry indeed -- I didn't realize PATA_WINBOND correscponds to 
pata_sl82c105 (somewhat confusing, isn't it?).

WBR, Sergei
