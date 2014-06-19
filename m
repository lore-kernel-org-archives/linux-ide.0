From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH RFC 1/2] libahci_platform: add ahci_platform_get_of_property
Date: Thu, 19 Jun 2014 10:22:08 +0800
Message-ID: <53A24950.2020300@linaro.org>
References: <xuwei5@hisilicon.com,kefeng.wang@linaro.org,> <1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org> <1403067249-8021-2-git-send-email-zhangfei.gao@linaro.org> <20140618140352.GD11895@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:44992 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbaFSCWY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2014 22:22:24 -0400
Received: by mail-pb0-f53.google.com with SMTP id uo5so1369666pbc.40
        for <linux-ide@vger.kernel.org>; Wed, 18 Jun 2014 19:22:24 -0700 (PDT)
In-Reply-To: <20140618140352.GD11895@leverpostej>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "tj@kernel.org" <tj@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Mark,

On 06/18/2014 10:03 PM, Mark Rutland wrote:
> On Wed, Jun 18, 2014 at 05:54:08AM +0100, Zhangfei Gao wrote:
>> Instead of setting hflags in different files,
>> ahci_platform_get_of_property set hpriv->flags when ahci_platform_init_host
>> according to property in dts.
>
> The AHCI_HFLAGS are a Linux implementation detail, so it would be nice
> to have a good justification for each of these being turned into DT
> properties.

Do you mean only add required property now?

Add ahci_platform_get_of_property is considering sharing 
drivers/ata/ahci_platform.c, refering sdhci_get_of_property in 
drivers/mmc/host/sdhci-pltfm.c.

The problem we met is different AHCI_HFLAGS required even in one soc 
series, for example, current version of "hisilicon,hisi-ahci" requires 
AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ, while next version solve the 
limitation, and no HFLAG required.
We may need different compatible, or it may simplier just state in dts.
What's more,  one common compatible can be used instead of adding 
specific compatible string.

>
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   .../devicetree/bindings/ata/ahci-platform.txt      |    9 +++++
>>   drivers/ata/libahci_platform.c                     |   39 ++++++++++++++++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> index c96d8dcf98fd..c0b9f6e76ba4 100644
>> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> @@ -26,6 +26,15 @@ Optional properties:
>>   - clocks            : must contain the sata, sata_ref and ahb clocks
>>   - clock-names       : must contain "ahb" for the ahb clock
>>
>> +- no-ncq: when present, controller can't do NCQ, turning off CAP_NCQ
>> +- 32bit-only: when present, controller can't do 64bit DMA, forcing 32bit
>> +- no-msi: when present, no PCI MSI
>> +- no-pmp: when present, controller can't do PMP, turning off CAP_PMP
>> +- yes-ncq: when present,controller can do NCQ, turning on CAP_NCQ
>> +- no-suspend: when present, controller can't do suspend
>> +- yes-fbs: when present, controller can do FBS, turning on CAP_FBS
>> +- no-fbs: when present, controller can't do FBS, turning off CAP_FBS
>
> There is absolutely no reason to mention CAP_* here; the DT should
> describe the HW, not Linux internals.
Yes, got it, will remove CAP*.

>
> Do these all make sense to be placed in DT?
Currently, "hisilicon,hisi-ahci" only need AHCI_HFLAG_NO_FBS | 
AHCI_HFLAG_NO_NCQ.
Just grep AHCI_HFLAG under ata.

>
> I worry that for other quirks we may need more flags in future. For that
> reason I'd rather figure this out in the driver based on the compatible
> string.
So do we just add no-ncq & no-fbs now?
>
>> +
>>   Examples:
>>           sata@ffe08000 {
>>   		compatible = "snps,spear-ahci";
>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>> index 3a5b4ed25a4f..880b9f360056 100644
>> --- a/drivers/ata/libahci_platform.c
>> +++ b/drivers/ata/libahci_platform.c
>> @@ -278,6 +278,44 @@ err_out:
>>   }
>>   EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
>>
>> +#ifdef CONFIG_OF
>> +static void ahci_platform_get_of_property(struct platform_device *pdev,
>> +					  struct ahci_host_priv *hpriv)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
>> +
>> +	if (of_device_is_available(np)) {
>> +		if (of_get_property(np, "no-ncq", NULL))
>> +			hpriv->flags |= AHCI_HFLAG_NO_NCQ;
>
> For boolean flags please use of_property_read_bool.
Yes, it's more accurate.

Thanks for advices.
>
> Mark.
>
