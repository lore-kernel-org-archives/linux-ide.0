From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH RFC 1/2] libahci_platform: add ahci_platform_get_of_property
Date: Thu, 19 Jun 2014 10:23:35 +0800
Message-ID: <53A249A7.2030807@linaro.org>
References: <xuwei5@hisilicon.com, kefeng.wang@linaro.org,>	<1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org>	<1403067249-8021-2-git-send-email-zhangfei.gao@linaro.org> <20140618093725.0f381633@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:54466 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895AbaFSCXn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2014 22:23:43 -0400
Received: by mail-pd0-f169.google.com with SMTP id g10so1310105pdj.0
        for <linux-ide@vger.kernel.org>; Wed, 18 Jun 2014 19:23:42 -0700 (PDT)
In-Reply-To: <20140618093725.0f381633@ipc1.ka-ro>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Cc: tj@kernel.org, hdegoede@redhat.com, arnd@arndb.de, mark.rutland@arm.com, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org



On 06/18/2014 03:37 PM, Lothar Wa=C3=9Fmann wrote:
> Hi,
>
> Zhangfei Gao wrote:
>> Instead of setting hflags in different files,
>> ahci_platform_get_of_property set hpriv->flags when ahci_platform_in=
it_host
>> according to property in dts.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   .../devicetree/bindings/ata/ahci-platform.txt      |    9 +++++
>>   drivers/ata/libahci_platform.c                     |   39 ++++++++=
++++++++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt=
 b/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> index c96d8dcf98fd..c0b9f6e76ba4 100644
>> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
>> @@ -26,6 +26,15 @@ Optional properties:
>>   - clocks            : must contain the sata, sata_ref and ahb cloc=
ks
>>   - clock-names       : must contain "ahb" for the ahb clock
>>
>> +- no-ncq: when present, controller can't do NCQ, turning off CAP_NC=
Q
>> +- 32bit-only: when present, controller can't do 64bit DMA, forcing =
32bit
>> +- no-msi: when present, no PCI MSI
>> +- no-pmp: when present, controller can't do PMP, turning off CAP_PM=
P
>> +- yes-ncq: when present,controller can do NCQ, turning on CAP_NCQ
>> +- no-suspend: when present, controller can't do suspend
>> +- yes-fbs: when present, controller can do FBS, turning on CAP_FBS
>> +- no-fbs: when present, controller can't do FBS, turning off CAP_FB=
S
>> +
> 'yes-...' sounds a bit silly to me.
> What about 'force-...'?

Yes, good idea, thanks for the suggestion.

> That's also what the comment to the flag definitions in
> drivers/ata/ahci.h says:
> |AHCI_HFLAG_YES_NCQ              =3D (1 << 9), /* force NCQ cap on */
> |AHCI_HFLAG_YES_FBS              =3D (1 << 14), /* force FBS cap on *=
/
>
>
> Lothar Wa=C3=9Fmann
>
