From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Thu, 9 Mar 2017 19:22:50 +0300
Message-ID: <580cabb1-90aa-418d-6ac8-a363d54dabe3@cogentembedded.com>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20161212135537epcas5p440bbb93d40f0c41b3754635733b09879@epcas5p4.samsung.com>
 <8ea5971a-338d-e8b9-6be8-8fe2658fc04d@ti.com> <1709119.SQyio4Ct6n@amdc3058>
 <1fd840c5-b0bb-726b-6357-669977c4ae5f@ti.com>
 <a3161cfc-56f7-4577-c37f-3798cdb03713@ti.com>
 <ab44a3c1-f078-4476-4583-de92ee68632c@cogentembedded.com>
 <98031160-f7b4-3cff-043a-1f2ee62c8a01@ti.com>
 <a8eab3b1-8867-00dd-08e4-bcece23010a6@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <a8eab3b1-8867-00dd-08e4-bcece23010a6@cogentembedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 03/09/2017 03:24 PM, Sergei Shtylyov wrote:

>>>> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c
>>>> b/arch/arm/mach-davinci/board-dm644x-evm.c
>>>> index 023480b75244..60a1f23890cd 100644
>>>> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
>>>> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
>>>> @@ -744,7 +744,7 @@ static int davinci_phy_fixup(struct phy_device
>>>> *phydev)
>>>>      return 0;
>>>>  }
>>>>
>>>> -#define HAS_ATA        IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
>>>> +#define HAS_ATA        IS_ENABLED(CONFIG_PATA_BK3710)
>>>
>>>    I think it would be more correct to check for both libata and IDE
>>> drivers here...
>>
>> As I understand, the plan is to remove the IDE driver soon.
>
>    I'm not sure DaveM would support any removals in drivers/ide/. He has
> explicitly expressed his will to maintain the IDE driuver forever.

    s/driuver/drivers/, sorry. :-)

>> Thanks,
>> Sekhar

MBR, Sergei
