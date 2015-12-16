From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 2/3] ata: sata_dwc_460ex: add phy support
Date: Wed, 16 Dec 2015 11:24:29 +0000
Message-ID: <yw1xwpseeivm.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<1450221935-6034-2-git-send-email-mans@mansr.com>
	<56714778.4070100@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:42586 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754588AbbLPLYi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Dec 2015 06:24:38 -0500
In-Reply-To: <56714778.4070100@cogentembedded.com> (Sergei Shtylyov's message
	of "Wed, 16 Dec 2015 14:14:00 +0300")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> writes:

> Hello.
>
> On 12/16/2015 2:25 AM, Mans Rullgard wrote:
>
>> This adds support for powering on an optional PHY when activating th=
e
>> device.
>>
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
> [...]
>> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460=
ex.c
>> index 9985749..d07aae1 100644
>> --- a/drivers/ata/sata_dwc_460ex.c
>> +++ b/drivers/ata/sata_dwc_460ex.c
> [...]
>> @@ -1318,6 +1320,21 @@ static int sata_dwc_probe(struct platform_dev=
ice *ofdev)
>>   	}
>>   #endif
>>
>> +	hsdev->phy =3D devm_phy_optional_get(hsdev->dev, "sata-phy");
>> +	if (IS_ERR(hsdev->phy)) {
>> +		err =3D PTR_ERR(hsdev->phy);
>> +		hsdev->phy =3D NULL;
>> +		goto error_out;
>> +	}
>> +
>> +	err =3D phy_init(hsdev->phy);
>> +	if (err)
>> +		goto error_out;
>
>    If phy_init() fails, do we really need to call phy_exit()?

No, but it doesn't hurt either, and it makes the code slightly simpler.
I can change it though.

>> +
>> +	err =3D phy_power_on(hsdev->phy);
>> +	if (err)
>> +		goto error_out;
>> +
>>   	/*
>>   	 * Now, register with libATA core, this will also initiate the
>>   	 * device discovery process, invoking our port_start() handler &
>> @@ -1331,6 +1348,7 @@ static int sata_dwc_probe(struct platform_devi=
ce *ofdev)
>>   	return 0;
>>
>>   error_out:
>> +	phy_exit(hsdev->phy);
>>   	iounmap(base);
>>   	return err;
>>   }
> [...]
>
> MBR, Sergei
>

--=20
M=E5ns Rullg=E5rd
