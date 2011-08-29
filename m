From: Eric Miao <eric.miao@linaro.org>
Subject: Re: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
 different features
Date: Mon, 29 Aug 2011 20:25:30 +0800
Message-ID: <CAMPhdO_XsrGTiiKpALVU7tZiAO_C5d_9XKoVjL_BHwpcqzXcFg@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
 <1314602339-18392-2-git-send-email-richard.zhu@linaro.org> <20110829121214.GA15484@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61075 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab1H2MZv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2011 08:25:51 -0400
Received: by vxi9 with SMTP id 9so4162550vxi.19
        for <linux-ide@vger.kernel.org>; Mon, 29 Aug 2011 05:25:50 -0700 (PDT)
In-Reply-To: <20110829121214.GA15484@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Richard Zhu <richard.zhu@linaro.org>, eric@eukrea.com, linux-ide@vger.kernel.org, kernel@pengutronix.de, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org

On Mon, Aug 29, 2011 at 8:12 PM, Anton Vorontsov <cbouatmailru@gmail.co=
m> wrote:
> Hello,
>
> On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
>> On imx53 AHCI, soft reset fails with IPMS set when PMP
>> is enabled but SATA HDD/ODD is connected to SATA port,
>> do soft reset again to port 0.
>> So the 'ahci_pmp_retry_srst_ops' is required when imx53
>> ahci is present.
>>
>> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
>> ---
> [...]
>> =C2=A0 =C2=A0 =C2=A0 struct device *dev =3D &pdev->dev;
>> =C2=A0 =C2=A0 =C2=A0 struct ahci_platform_data *pdata =3D dev->platf=
orm_data;
>> - =C2=A0 =C2=A0 struct ata_port_info pi =3D {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D AHCI_FLAG_COMMON,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pio_mask =C2=A0 =C2=A0 =
=C2=A0 =3D ATA_PIO4,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .udma_mask =C2=A0 =C2=A0=
 =C2=A0=3D ATA_UDMA6,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .port_ops =C2=A0 =C2=A0 =
=C2=A0 =3D &ahci_ops,
>> - =C2=A0 =C2=A0 };
>> + =C2=A0 =C2=A0 struct platform_device_id *id_entry =3D platform_get=
_device_id(pdev);
>> + =C2=A0 =C2=A0 struct ata_port_info pi =3D ahci_port_info[id_entry-=
>driver_data];
>
> Why not pass port info via platform_data? It seems to be platform
> specific nowadays, so leave the default as is, but let the platforms
> pass their own port info through platform_data.

That's also a very clean way. However I have the concern that it might
end up with many duplicate entries.

>
> Thanks,
>
> --
> Anton Vorontsov
> Email: cbouatmailru@gmail.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
