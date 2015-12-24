From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [v6 0/7] add support SATA for BMIPS_GENERIC
Date: Thu, 24 Dec 2015 09:52:52 -0800
Message-ID: <2D90085B-23A9-4FE6-A203-5934749B4D04@gmail.com>
References: <1448506595-4981-1-git-send-email-jaedon.shin@gmail.com> <56769896.6060908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35832 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262AbbLXRxG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Dec 2015 12:53:06 -0500
Received: by mail-ob0-f173.google.com with SMTP id 18so189269482obc.2
        for <linux-ide@vger.kernel.org>; Thu, 24 Dec 2015 09:53:05 -0800 (PST)
In-Reply-To: <56769896.6060908@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Jaedon Shin <jaedon.shin@gmail.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, linux-ide@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>

On December 20, 2015 4:01:26 AM PST, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>
>On Thursday 26 November 2015 08:26 AM, Jaedon Shin wrote:
>> Hi all,
>> 
>> This patch series add support SATA for BMIPS_GENERIC.
>> 
>> Changes in v6:
>> - change error message for invalid phy version
>> - use a flag AHCI_HFLAG_NO_NCQ instead of HOST_CAP_NCQ overriding
>> 
>> Changes in v5:
>> - uses brcm_sata_readreg and brcm_sata_writereg for HOST_CAP_NCQ
>overriding
>> - pull out already applied patches for device tree entries
>> - add "Tested-by:" and "Acked-by:" tags
>> 
>> Changes in v4:
>> - remove unused properties from bcm{7425,7342,7362}.dtsi
>> 
>> Changes in v3:
>> - fix typo quirk instead of quick
>> - disable NCQ before initialzing SATA controller endianness
>> - fix misnomer controlling phy interface
>> - remove brcm,broken-ncq and brcm,broken-phy properties from
>devicetree
>> - use compatible string for quirks
>> - use list for compatible strings
>> - add "Acked-by:" tags
>> 
>> Changes in v2:
>> - add a quirk for disable NCQ
>> - add a quirk for skip phy interface control
>> - remove unused definitions in ahci_brcmstb
>> - combine compatible string
>> 
>> Jaedon Shin (7):
>>   ata: ahci_brcmstb: add support for MIPS-based platforms
>>   ata: ahci_brcmstb: disable NCQ for MIPS-based platforms
>>   ata: ahci_brcmstb: add a quirk for MIPS-based platforms
>>   ata: ahci_brcmstb: remove unused definitions
>>   phy: phy_brcmstb_sata: remove duplicate definitions
>>   phy: phy_brcmstb_sata: add data for phy version
>>   phy: phy_brcmstb_sata: add support for MIPS-based platforms
>
>merged phy susbsystem patches to linux-phy tree.

Thank you! Tejun, can you take the AHCI driver changes if they look good to you? Thanks!

>
>Thanks
>Kishon
>> 
>>  .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
>>  .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
>>  drivers/ata/Kconfig                                |  2 +-
>>  drivers/ata/ahci_brcmstb.c                         | 23 ++++++++++-
>>  drivers/phy/Kconfig                                |  4 +-
>>  drivers/phy/phy-brcmstb-sata.c                     | 47
>+++++++++++++++++-----
>>  6 files changed, 65 insertions(+), 16 deletions(-)
>> 


-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
