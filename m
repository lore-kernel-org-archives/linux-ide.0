From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Thu, 9 Mar 2017 15:24:56 +0300
Message-ID: <a8eab3b1-8867-00dd-08e4-bcece23010a6@cogentembedded.com>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20161212135537epcas5p440bbb93d40f0c41b3754635733b09879@epcas5p4.samsung.com>
 <8ea5971a-338d-e8b9-6be8-8fe2658fc04d@ti.com> <1709119.SQyio4Ct6n@amdc3058>
 <1fd840c5-b0bb-726b-6357-669977c4ae5f@ti.com>
 <a3161cfc-56f7-4577-c37f-3798cdb03713@ti.com>
 <ab44a3c1-f078-4476-4583-de92ee68632c@cogentembedded.com>
 <98031160-f7b4-3cff-043a-1f2ee62c8a01@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <98031160-f7b4-3cff-043a-1f2ee62c8a01@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>
List-Id: linux-ide@vger.kernel.org

On 03/09/2017 03:20 PM, Sekhar Nori wrote:

> [...]

>>> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c
>>> b/arch/arm/mach-davinci/board-dm644x-evm.c
>>> index 023480b75244..60a1f23890cd 100644
>>> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
>>> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
>>> @@ -744,7 +744,7 @@ static int davinci_phy_fixup(struct phy_device
>>> *phydev)
>>>      return 0;
>>>  }
>>>
>>> -#define HAS_ATA        IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
>>> +#define HAS_ATA        IS_ENABLED(CONFIG_PATA_BK3710)
>>
>>    I think it would be more correct to check for both libata and IDE
>> drivers here...
>
> As I understand, the plan is to remove the IDE driver soon.

    I'm not sure DaveM would support any removals in drivers/ide/. He has 
explicitly expressed his will to maintain the IDE driuver forever.

> Thanks,
> Sekhar

MBR, Sergei
