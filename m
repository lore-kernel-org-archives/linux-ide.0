From: Richard Zhu <richard.zhu@linaro.org>
Subject: Re: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
 different features
Date: Tue, 30 Aug 2011 16:54:21 +0800
Message-ID: <CAJNCFVJk0ZeMpSxa=wo1ByV64mip7=Gpscym1LLz2rHC0QvaLQ@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
	<1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
	<20110829121214.GA15484@oksana.dev.rtsoft.ru>
	<CAMPhdO_XsrGTiiKpALVU7tZiAO_C5d_9XKoVjL_BHwpcqzXcFg@mail.gmail.com>
	<CAJNCFVJKvO+W0ogn-3GOsR8ygtn5KWtqTc2sw6HuNB2-x7ZviA@mail.gmail.com>
	<CAJNCFVKPUW95F0Wt9eVWs0+ne1pdXreYi6uSKH2TkR+Qt_sm4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:45384 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab1H3IyW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2011 04:54:22 -0400
Received: by yie30 with SMTP id 30so4203435yie.19
        for <linux-ide@vger.kernel.org>; Tue, 30 Aug 2011 01:54:21 -0700 (PDT)
In-Reply-To: <CAJNCFVKPUW95F0Wt9eVWs0+ne1pdXreYi6uSKH2TkR+Qt_sm4A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Miao <eric.miao@linaro.org>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, eric@eukrea.com, linux-ide@vger.kernel.org, kernel@pengutronix.de, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org

Hi:
Maybe we have to come back to take wolfram's suggestion.
Remove the mx53 specification in the ahci_type, and replace it by
 the generic one AHCI_PMP_RTY_SRST
Then the other ahci controller that needs the same PMP retry soft
reset SW work-around can reuse the
ata_port_info.

Hi Eric:
How about to use the generic ahci_type AHCI_PMP_RTY_SRST to replace
the IMX53_AHCI firstly?

The specified ahci_type can be added if the ahci controller needs some
different configurations refer to
the definitions in the AHCI_PMP_RTY_SRST's ata_port_info.

In this way, we can re-use the codes as much as possible.

Best Regards
Richard Zhu

On 30 August 2011 15:07, Richard Zhu <richard.zhu@linaro.org> wrote:
> Hi:
> One more concern, the .../drivers/ata/ahci.h file should be moved to
> .../include/linux/ folder.
> Because that the kinds of macros used in the ata_port_info and the
> ahci_pmp_retry_srst_ops are
> all defined in the .../drivers/ata/ahci.h file.
> Otherwise, the ata_port_info can't be defined in the board related
> platform data.
>
> How we can handle this case?
>
> Best Regard
> Richard Zhu
>
> On 30 August 2011 14:21, Richard Zhu <richard.zhu@linaro.org> wrote:
>> Hi:
>> Pass port info from the platform data is a good idea.
>> About the codes duplication in the board level, I think that we can
>> re-use the default =A0port info on most boards, when the ata_port_in=
fo
>> is null in the platform data struct.
>> We can leave the ahci_platform.c without any modifications in this w=
ay.
>>
>> How do you guys think about?
>>
>> Best Regard
>> Richard Zhu
>>
>>
>> On 29 August 2011 20:25, Eric Miao <eric.miao@linaro.org> wrote:
>>> On Mon, Aug 29, 2011 at 8:12 PM, Anton Vorontsov <cbouatmailru@gmai=
l.com> wrote:
>>>> Hello,
>>>>
>>>> On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
>>>>> On imx53 AHCI, soft reset fails with IPMS set when PMP
>>>>> is enabled but SATA HDD/ODD is connected to SATA port,
>>>>> do soft reset again to port 0.
>>>>> So the 'ahci_pmp_retry_srst_ops' is required when imx53
>>>>> ahci is present.
>>>>>
>>>>> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
>>>>> ---
>>>> [...]
>>>>> =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
>>>>> =A0 =A0 =A0 struct ahci_platform_data *pdata =3D dev->platform_da=
ta;
>>>>> - =A0 =A0 struct ata_port_info pi =3D {
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D AHCI_FLAG=
_COMMON,
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 .pio_mask =A0 =A0 =A0 =3D ATA_PIO4,
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 .udma_mask =A0 =A0 =A0=3D ATA_UDMA6,
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 .port_ops =A0 =A0 =A0 =3D &ahci_ops,
>>>>> - =A0 =A0 };
>>>>> + =A0 =A0 struct platform_device_id *id_entry =3D platform_get_de=
vice_id(pdev);
>>>>> + =A0 =A0 struct ata_port_info pi =3D ahci_port_info[id_entry->dr=
iver_data];
>>>>
>>>> Why not pass port info via platform_data? It seems to be platform
>>>> specific nowadays, so leave the default as is, but let the platfor=
ms
>>>> pass their own port info through platform_data.
>>>
>>> That's also a very clean way. However I have the concern that it mi=
ght
>>> end up with many duplicate entries.
>>>
>>>>
>>>> Thanks,
>>>>
>>>> --
>>>> Anton Vorontsov
>>>> Email: cbouatmailru@gmail.com
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>
>>
>
