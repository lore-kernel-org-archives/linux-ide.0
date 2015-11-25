From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: Re: [v5 0/7] add support SATA for BMIPS_GENERIC
Date: Wed, 25 Nov 2015 18:30:00 +0900
Message-ID: <6E9B21E1-54EB-4220-B4C7-60132F984E81@gmail.com>
References: <1447900879-1549-1-git-send-email-jaedon.shin@gmail.com> <5654F7FA.4060508@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33235 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbbKYJaG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2015 04:30:06 -0500
Received: by pabfh17 with SMTP id fh17so53757737pab.0
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2015 01:30:06 -0800 (PST)
In-Reply-To: <5654F7FA.4060508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>, linux-ide@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>

On Nov 25, 2015, at 8:51 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> On 18/11/15 18:41, Jaedon Shin wrote:
>> Hi all,
>> 
>> This patch series add support SATA for BMIPS_GENERIC.
>> 
>> Changes in v5:
>> - uses brcm_sata_readreg and brcm_sata_writereg for HOST_CAP_NCQ overriding
>> - pull out already applied patches for device tree entries
>> - add "Tested-by:" and "Acked-by:" tags
> 
> And now also tested on 7435 and 7429 and worked just fine, I plan on
> submitting DTSes updates or additions for these chips a little later on.
> 
> Jaedon, can you address Brian's and Kishon's feedback so we can get
> these patches included in their respective trees?
> 
> Thanks again!
> 

Sorry too late, and I will resubmit patches in tomorrow including Tejun's, 
Brian's and Kishon's feedbacks.

Thanks,
Jaedon

>> 
>> Changes in v4:
>> - remove unused properties from bcm{7425,7342,7362}.dtsi
>> 
>> Changes in v3:
>> - fix typo quirk instead of quick
>> - disable NCQ before initialzing SATA controller endianness
>> - fix misnomer controlling phy interface
>> - remove brcm,broken-ncq and brcm,broken-phy properties from devicetree
>> - use compatible string for quirks
>> - use list for compatible strings
>> - add "Acked-by:" tags
>> 
>> Changes in v2:
>> - adds quirk for ncq
>> - adds quirk for phy interface control
>> - remove unused definitions in ahci_brcmstb
>> - combines compatible string
>> 
>> Jaedon Shin (7):
>>  ata: ahci_brcmstb: add support MIPS-based platforms
>>  ata: ahci_brcmstb: add quirk for broken ncq
>>  ata: ahci_brcmstb: add quirk for different phy
>>  ata: ahci_brcmstb: remove unused definitions
>>  phy: phy_brcmstb_sata: remove duplicate definitions
>>  phy: phy_brcmstb_sata: add data for phy version
>>  phy: phy_brcmstb_sata: add support MIPS-based platforms
>> 
>> .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
>> .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
>> drivers/ata/Kconfig                                |  2 +-
>> drivers/ata/ahci_brcmstb.c                         | 58 +++++++++++++++++++++-
>> drivers/phy/Kconfig                                |  4 +-
>> drivers/phy/phy-brcmstb-sata.c                     | 47 ++++++++++++++----
>> 6 files changed, 100 insertions(+), 16 deletions(-)
>> 
>> --
>> 2.6.3
>> 
> 
> 
> -- 
> Florian

