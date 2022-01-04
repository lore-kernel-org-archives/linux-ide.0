Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2E3C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 08:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiADIg7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 03:36:59 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:19850 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234145AbiADIg6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 03:36:58 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmF64qtlz1VSkY
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 00:36:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1641285417; x=1643877418; bh=qtKKOE3E1z7pNq08UoVpTBZZqsFXu8otZze
        XBbo/oMo=; b=iUsAvfSqFpidVZ+psQu+P/KtoFRy+Fc4EgO8DjG4mCdWSGL/gMT
        i6kiTrt/5OYSC0dIf3gJg4vhpqc+DZOhD5QApWg7XSGwcj1eUjif1jnKxQa/MrrM
        +fSXT6LazvD8dc25hSkGcYottnQwLWHHduYPRQYkbLLHem/NAsxq9ETOF8UEFUtd
        ch3mBpacvRDOgFs92sbjRm6q1h6dvq1zVxMZoeaJD/84QN8EGzUB/JSCPym+2YZp
        OOSBdUrusMvoX5pXfsDZmf6/C5DSGQz1vWfP9hu7TcagMFPlYFRcmf57j29Ym3yK
        hv1I6Y/SnSK3UayfGrUTInjVN6DD0NKw0Yw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id op7iqd_g0P8V for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 00:36:57 -0800 (PST)
Received: from [10.225.163.42] (unknown [10.225.163.42])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmF46TGSz1VSjC;
        Tue,  4 Jan 2022 00:36:56 -0800 (PST)
Message-ID: <c6748a52-fc8f-3309-31c2-973a9e69a7e8@opensource.wdc.com>
Date:   Tue, 4 Jan 2022 17:36:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/3] ahci: AMD A85 FCH (Hudson D4): Skip 200 ms
 debounce delay in `sata_link_resume()`
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
 <20211229161119.1006-3-pmenzel@molgen.mpg.de>
 <5c333718-eaa5-b41c-e8ea-59d6e01254aa@opensource.wdc.com>
 <19f6cd93-9bd7-60dc-4471-18022bcf456c@molgen.mpg.de>
 <7b64d1c3-f798-d64b-9ee3-9669d98f4e28@opensource.wdc.com>
 <fbfd865f-c88c-6ee1-6cb9-8194e170cd3a@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <fbfd865f-c88c-6ee1-6cb9-8194e170cd3a@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/31/21 16:08, Paul Menzel wrote:
> Dear Damien,
>=20
>=20
> Am 31.12.21 um 01:52 schrieb Damien Le Moal:
>> On 12/30/21 20:08, Paul Menzel wrote:
>>>>>    	board_ahci_nomsi,
>>>>>    	board_ahci_noncq,
>>>>>    	board_ahci_nosntf,
>>>>> @@ -141,6 +142,13 @@ static const struct ata_port_info ahci_port_in=
fo[] =3D {
>>>>>    		.udma_mask	=3D ATA_UDMA6,
>>>>>    		.port_ops	=3D &ahci_ops,
>>>>>    	},
>>>>> +	[board_ahci_nodbdelay] =3D {
>>>>> +		.flags		=3D AHCI_FLAG_COMMON,
>>>>> +		.link_flags	=3D ATA_LFLAG_NO_DB_DELAY,
>>>>> +		.pio_mask	=3D ATA_PIO4,
>>>>> +		.udma_mask	=3D ATA_UDMA6,
>>>>> +		.port_ops	=3D &ahci_ops,
>>>>> +	},
>>>>>    	[board_ahci_nomsi] =3D {
>>>>>    		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
>>>>>    		.flags		=3D AHCI_FLAG_COMMON,
>>>>> @@ -437,6 +445,7 @@ static const struct pci_device_id ahci_pci_tbl[=
] =3D {
>>>>>    		board_ahci_al },
>>>>>    	/* AMD */
>>>>>    	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE), board_a=
hci },
>>>>> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_HUDSON2_SATA_AHCI), board_ah=
ci_nodbdelay },
>>>>
>>>> Patch 1 introduces this macro in pci_ids.h, but it is used only here=
. So
>>>> to keep with the current style in this structure, drop the macro (so
>>>> drop patch 1).
>>>
>>> I wait for your answer of the second patch, and then I am going to se=
nt v4.
>>
>> Let's use the numeric value. No macro definition needed.
>=20
> Alright. I am going to follow the maintainers wishes.
>=20
>>>>>    	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>>>>>    	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green S=
ardine */
>>>>>    	/* AMD is using RAID class only for ahci controllers */
>>>
>>> Do you have a AHCI device at hand, where you could also test if
>>> everything works fine without the delay?
>>
>> Unfortunately, I do not have any board with this adapter.
>=20
> Sorry, we misunderstand each other. (I wrote a reply to my own patch [1=
].)
>=20
> I think the delay is not necessary for any modern AHCI controller. It=E2=
=80=99d=20
> be great, if you could test, if it=E2=80=99s also true on the systems y=
ou have=20
> by just skipping the delay.

I need to figure out how to safely test suspend/resume remotely (working
from home) :)

It would indeed be great to have the default as "no delay on resume" and
add the delay only for chipsets that need it. However, it is unclear
which chipset need the delay, right ? So I think we are stuck with
switching chipsets to "no delay" one by one by testing. Once the
majority of drivers are converted, we can reverse the default to be "no
delay" and mark untested drivers as needing the delay.

>=20
>=20
> Kind regards,
>=20
> Paul
>=20
>=20
> [1]:=20
> https://lore.kernel.org/linux-ide/20211227162658.11314-2-pmenzel@molgen=
.mpg.de/T/#m697d2121463a4c946730e6b83940e12d6d7e6700


--=20
Damien Le Moal
Western Digital Research
