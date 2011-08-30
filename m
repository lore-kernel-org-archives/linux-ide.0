From: Richard Zhu <richard.zhu@linaro.org>
Subject: Re: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
 different features
Date: Tue, 30 Aug 2011 14:21:22 +0800
Message-ID: <CAJNCFVJKvO+W0ogn-3GOsR8ygtn5KWtqTc2sw6HuNB2-x7ZviA@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
	<1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
	<20110829121214.GA15484@oksana.dev.rtsoft.ru>
	<CAMPhdO_XsrGTiiKpALVU7tZiAO_C5d_9XKoVjL_BHwpcqzXcFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58953 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab1H3GVX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2011 02:21:23 -0400
Received: by gwaa12 with SMTP id a12so5399587gwa.19
        for <linux-ide@vger.kernel.org>; Mon, 29 Aug 2011 23:21:22 -0700 (PDT)
In-Reply-To: <CAMPhdO_XsrGTiiKpALVU7tZiAO_C5d_9XKoVjL_BHwpcqzXcFg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Miao <eric.miao@linaro.org>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, eric@eukrea.com, linux-ide@vger.kernel.org, kernel@pengutronix.de, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org

Hi:
Pass port info from the platform data is a good idea.
About the codes duplication in the board level, I think that we can
re-use the default  port info on most boards, when the ata_port_info
is null in the platform data struct.
We can leave the ahci_platform.c without any modifications in this way.

How do you guys think about?

Best Regard
Richard Zhu


On 29 August 2011 20:25, Eric Miao <eric.miao@linaro.org> wrote:
> On Mon, Aug 29, 2011 at 8:12 PM, Anton Vorontsov <cbouatmailru@gmail.=
com> wrote:
>> Hello,
>>
>> On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
>>> On imx53 AHCI, soft reset fails with IPMS set when PMP
>>> is enabled but SATA HDD/ODD is connected to SATA port,
>>> do soft reset again to port 0.
>>> So the 'ahci_pmp_retry_srst_ops' is required when imx53
>>> ahci is present.
>>>
>>> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
>>> ---
>> [...]
>>> =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
>>> =A0 =A0 =A0 struct ahci_platform_data *pdata =3D dev->platform_data=
;
>>> - =A0 =A0 struct ata_port_info pi =3D {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D AHCI_FLAG_C=
OMMON,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 .pio_mask =A0 =A0 =A0 =3D ATA_PIO4,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 .udma_mask =A0 =A0 =A0=3D ATA_UDMA6,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 .port_ops =A0 =A0 =A0 =3D &ahci_ops,
>>> - =A0 =A0 };
>>> + =A0 =A0 struct platform_device_id *id_entry =3D platform_get_devi=
ce_id(pdev);
>>> + =A0 =A0 struct ata_port_info pi =3D ahci_port_info[id_entry->driv=
er_data];
>>
>> Why not pass port info via platform_data? It seems to be platform
>> specific nowadays, so leave the default as is, but let the platforms
>> pass their own port info through platform_data.
>
> That's also a very clean way. However I have the concern that it migh=
t
> end up with many duplicate entries.
>
>>
>> Thanks,
>>
>> --
>> Anton Vorontsov
>> Email: cbouatmailru@gmail.com
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
