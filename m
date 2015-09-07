From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ahci: added a new driver for supporting Freescale AHCI
 sata
Date: Mon, 7 Sep 2015 09:06:43 +0200
Message-ID: <55ED3783.8070002@redhat.com>
References: <1441160730-28006-1-git-send-email-Yuantian.Tang@freescale.com>
 <55E6B3E8.80902@redhat.com>
 <DM2PR03MB574DBC10E59CE7A8D10310DFA550@DM2PR03MB574.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47904 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbbIGHGp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Sep 2015 03:06:45 -0400
In-Reply-To: <DM2PR03MB574DBC10E59CE7A8D10310DFA550@DM2PR03MB574.namprd03.prod.outlook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On 06-09-15 07:39, Yuantian Tang wrote:
> Hi,
>
>> -----Original Message-----
>> From: Hans de Goede [mailto:hdegoede@redhat.com]
>> Sent: Wednesday, September 02, 2015 4:32 PM
>> To: Tang Yuantian-B29983 <Yuantian.Tang@freescale.com>
>> Cc: tj@kernel.org; linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] ahci: added a new driver for supporting Freescale AHCI
>> sata
>>
>> Hi,
>>
>> On 02-09-15 04:25, Yuantian.Tang@freescale.com wrote:
>>> From: Tang Yuantian <Yuantian.Tang@freescale.com>
>>>
>>> Currently Freescale QorIQ series SATA is supported by ahci_platform
>>> driver. Some SoC specific settings have been put in uboot. So whether
>>> SATA works or not heavily depends on uboot.
>>> This patch will add a new driver to support QorIQ sata which removes
>>> the dependency on any other boot loader.
>>> Freescale QorIQ series sata, like ls1021a ls2085a ls1043a, is
>>> compatible with serial ATA 3.0 and AHCI 1.3 specification.
>>>
>>> Signed-off-by: Yuantian Tang <Yuantian.Tang@freescale.com>
>>
>> Thanks for the patch looks good overall.
>>
>> You need to add a Documentation/devicetree/bindings/ata/ahci-fsl-qoriq.txt
>> (or a similar named file) documenting the compatible strings and what the
>> devicetree nodes should contain wrt reg, interrupts, etc.
>> properties. See Documentation/devicetree/bindings/ata/ahci-platform.txt
>> as an example.
>>
>> Further comments inline.
>>
> I was about to use ahci_platform driver, so I added the bindings stuff to
> Documentation/devicetree/bindings/ata/ahci-platform.txt
> So I need to revert the old bingings first and then add a new one.
>
>>> ---
>>>    drivers/ata/Kconfig         |   9 ++
>>>    drivers/ata/Makefile        |   1 +
>>>    drivers/ata/ahci_platform.c |   1 -
>>>    drivers/ata/ahci_qoriq.c    | 308
>> ++++++++++++++++++++++++++++++++++++++++++++
>>>    4 files changed, 318 insertions(+), 1 deletion(-)
>>>    create mode 100644 drivers/ata/ahci_qoriq.c
>>>
>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig index
>>> 15e40ee..6aaa3f8 100644
>>> --- a/drivers/ata/Kconfig
>>> +++ b/drivers/ata/Kconfig
>>> @@ -175,6 +175,15 @@ config AHCI_XGENE
>>>    	help
>>>    	 This option enables support for APM X-Gene SoC SATA host
>> controller.
>>>
>>> +config AHCI_QORIQ
>>> +	tristate "Freescale QorIQ AHCI SATA support"
>>> +	depends on OF
>>> +	help
>>> +	  This option enables support for the Freescale QorIQ AHCI SoC's
>>> +	  onboard AHCI SATA.
>>> +
>>> +	  If unsure, say N.
>>> +
>>>    config SATA_FSL
>>>    	tristate "Freescale 3.0Gbps SATA support"
>>>    	depends on FSL_SOC
>>> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile index
>>> af70919..af45eff 100644
>>> --- a/drivers/ata/Makefile
>>> +++ b/drivers/ata/Makefile
>>> @@ -19,6 +19,7 @@ obj-$(CONFIG_AHCI_SUNXI)	+= ahci_sunxi.o
>> libahci.o libahci_platform.o
>>>    obj-$(CONFIG_AHCI_ST)		+= ahci_st.o libahci.o
>> libahci_platform.o
>>>    obj-$(CONFIG_AHCI_TEGRA)	+= ahci_tegra.o libahci.o
>> libahci_platform.o
>>>    obj-$(CONFIG_AHCI_XGENE)	+= ahci_xgene.o libahci.o
>> libahci_platform.o
>>> +obj-$(CONFIG_AHCI_QORIQ)	+= ahci_qoriq.o libahci.o
>> libahci_platform.o
>>>
>>>    # SFF w/ custom DMA
>>>    obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
>>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>>> index 1befb11..04975b8 100644
>>> --- a/drivers/ata/ahci_platform.c
>>> +++ b/drivers/ata/ahci_platform.c
>>> @@ -76,7 +76,6 @@ static const struct of_device_id ahci_of_match[] = {
>>>    	{ .compatible = "ibm,476gtr-ahci", },
>>>    	{ .compatible = "snps,dwc-ahci", },
>>>    	{ .compatible = "hisilicon,hisi-ahci", },
>>> -	{ .compatible = "fsl,qoriq-ahci", },
>>>    	{},
>>>    };
>>>    MODULE_DEVICE_TABLE(of, ahci_of_match);
>>
>> This will break booting new kernels with old dtb files, something which in
>> general is considered a big non-no, I suggest adding a comment that this has
>> been superseded by the new ahci_qoriq.c code, and maybe add a date to
>> retire the compatible in say a year from now.
>>
> There is no old dtb because LS* platforms are not been upstreamed yet.
> So I think we can safely replace it without breaking anything.

Ok / ACK.

Regards,

Hans
