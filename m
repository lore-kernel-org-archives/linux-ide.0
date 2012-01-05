From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH] pata_bf54x: fix BMIDE status register emulation
Date: Thu, 5 Jan 2012 10:45:03 +0800
Message-ID: <CAJxxZ0Mtt4iMH9TJp=2rwB5buGXFofLt+4H2Tbns=hGZg9Gk5w@mail.gmail.com>
References: <201112281836.45834.sshtylyov@ru.mvista.com>
	<DB904C5425BA6F4E8424B3B51A1414D16D76860B88@NWD2CMBX1.ad.analog.com>
	<4EFF24BF.20905@mvista.com>
	<DB904C5425BA6F4E8424B3B51A1414D16D76860EA1@NWD2CMBX1.ad.analog.com>
	<4F045277.1080009@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55195 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab2AECpG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jan 2012 21:45:06 -0500
Received: by bkcjm19 with SMTP id jm19so12261bkc.19
        for <linux-ide@vger.kernel.org>; Wed, 04 Jan 2012 18:45:04 -0800 (PST)
In-Reply-To: <4F045277.1080009@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Zhang, Sonic" <Sonic.Zhang@analog.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>

On Wed, Jan 4, 2012 at 9:21 PM, Sergei Shtylyov <sshtylyov@mvista.com> =
wrote:
> Hello.
>
>
> On 04-01-2012 10:04, Zhang, Sonic wrote:
>
>> Hi Serge,
>
>
>> The MULTI_DONE_INT, UDMAIN_DONE_INT and UDMAOUT_DONE_INT are trigger=
ed
>> independent
>> of the ATAPI_DEV_INT, although they bind to the same IRQ on bf548. W=
ith
>> your patch,
>
>> these interrupts are ignored and results in kernel error "unhandled =
IRQ".
>
> =A0 Ah, indeed...
>
>
>> If you insist the BMDMA emulation on bf548 should comply with INF-80=
38i.
>
>
> =A0 It's not that I insist. It clearly follows from libata implemetin=
g
> bmdma_status() method.
>
>
>> I would propose the following patch to disable all BF548 ATAPI speci=
fic
>> interrupts.
>
>
> =A0 Yes, I agree -- they don't seem needed. And that will simplify th=
e driver
> too. I'll recast the patch and add your signoff if you agree.

No problem.

Sonic

>
>> Sonic
>
>
>> ---
>> =A0drivers/ata/pata_bf54x.c | =A0 19 ++-----------------
>> =A01 files changed, 2 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
>> index bd987bb..9711c2a 100644
>> --- a/drivers/ata/pata_bf54x.c
>> +++ b/drivers/ata/pata_bf54x.c
>> @@ -418,14 +418,6 @@ static void bfin_set_dmamode(struct ata_port *a=
p,
>> struct ata_device *adev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (tcyc_tdvs<<8 | tdvs));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATAP=
I_SET_ULTRA_TIM_2(base, (tmli<<8 |
>> tss));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATAP=
I_SET_ULTRA_TIM_3(base, (trp<<8 |
>> tzah));
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ena=
ble host ATAPI Untra DMA interrupts
>> */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATAPI_=
SET_INT_MASK(base,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ATAPI_GET_INT_MASK(base)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | UDMAIN_DONE_MASK
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | UDMAOUT_DONE_MASK
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | UDMAIN_TERM_MASK
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | UDMAOUT_TERM_MASK);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 }
>> @@ -470,10 +462,6 @@ static void bfin_set_dmamode(struct ata_port *a=
p,
>> struct ata_device *adev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATAPI_SET_MULTI_TIM_=
0(base, (tm<<8 | td));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATAPI_SET_MULTI_TIM_=
1(base, (tkr<<8 | tkw));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATAPI_SET_MULTI_TIM_=
2(base, (teoc<<8 | th));
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable host ATAPI M=
ulti DMA interrupts */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATAPI_SET_INT_MASK(bas=
e, ATAPI_GET_INT_MASK(base)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | MULT=
I_DONE_MASK | MULTI_TERM_MASK);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSYNC();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 }
>> @@ -1155,13 +1143,10 @@ static unsigned char bfin_bmdma_status(struc=
t
>> ata_port *ap)
>> =A0 =A0 =A0 =A0 void __iomem *base =3D (void __iomem *)ap->ioaddr.ct=
l_addr;
>> =A0 =A0 =A0 =A0 unsigned short int_status =3D ATAPI_GET_INT_STATUS(b=
ase);
>>
>> - =A0 =A0 =A0 if (ATAPI_GET_STATUS(base)& =A0(MULTI_XFER_ON|ULTRA_XF=
ER_ON))
>> + =A0 =A0 =A0 if (ATAPI_GET_STATUS(base)& =A0(MULTI_XFER_ON | ULTRA_=
XFER_ON))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host_stat |=3D ATA_DMA_ACTIVE;
>> - =A0 =A0 =A0 if (int_status& =A0(MULTI_DONE_INT|UDMAIN_DONE_INT|UDM=
AOUT_DONE_INT|
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ATAPI_DEV_INT))
>> + =A0 =A0 =A0 if (ATAPI_GET_INT_STATUS(base)& =A0ATAPI_DEV_INT)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host_stat |=3D ATA_DMA_INTR;
>> - =A0 =A0 =A0 if (int_status&
>> =A0(MULTI_TERM_INT|UDMAIN_TERM_INT|UDMAOUT_TERM_INT))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host_stat |=3D ATA_DMA_ERR|ATA_DMA_INT=
R;
>>
>> =A0 =A0 =A0 =A0 dev_dbg(ap->dev, "ATAPI: host_stat=3D0x%x\n", host_s=
tat);
>>
>> --
>> 1.7.0.4
>
>
> WBR, Sergei
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
