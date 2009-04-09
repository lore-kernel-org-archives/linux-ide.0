From: yanhua <yanh@lemote.com>
Subject: Re: [PATCH 13/14] lemote: fixup for FUJITSU disk
Date: Thu, 09 Apr 2009 20:53:45 +0800
Message-ID: <49DDEFD9.5050803@lemote.com>
References: <49DD83CA.9000704@lemote.com> <49DDE1D4.9080601@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [222.92.8.141] ([222.92.8.141]:33343 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759951AbZDIMxx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 08:53:53 -0400
In-Reply-To: <49DDE1D4.9080601@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, =?UTF-8?B?5b2t5Lqu6ZSm?= <penglj@lemote.com>, "zhangfx@lemote.com" <zhangfx@lemote.com>, linux-ide@vger.kernel.org

Sergei Shtylyov =E5=86=99=E9=81=93:
> Hello.
>
> yanhua wrote:
>
>    The patch description wouldn't hurt, i.e. why this fixup is needed=
=2E..
>
>  =20
>> diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
>> index 77267c8..51b888f 100644
>> --- a/drivers/ide/amd74xx.c
>> +++ b/drivers/ide/amd74xx.c
>>    =20
>
>    The IDE patches should be posted to linux-ide mail list.
>
>  =20
>> @@ -23,6 +23,11 @@
>>
>> #define DRV_NAME "amd74xx"
>>
>> +static const char *am74xx_quirk_drives[] =3D {
>> + "FUJITSU MHZ2160BH G2",
>> + NULL
>> +};
>> +
>> enum {
>> AMD_IDE_CONFIG =3D 0x41,
>> AMD_CABLE_DETECT =3D 0x42,
>> @@ -112,6 +117,20 @@ static void amd_set_pio_mode(ide_drive_t *drive=
,
>> const u8 pio)
>> amd_set_drive(drive, XFER_PIO_0 + pio);
>>    =20
>
>    Your patches are seriously whitespace-damaged, i.e. all tabs seem =
to be
> collapsed to a single space. You'll have to find a way to avoid that.=
=2E.
>
>  =20
>> }
>>
>> +static void amd_quirkproc(ide_drive_t *drive, const u8 pio)
>>    =20
>
>    Have you tried to compile this? The quirkproc() method only has on=
e parameter.
Sorry for my mistake(after check, the compile reports a warning).
I have compiled it and test this on Yeeloong machines.=20


>  =20
>> +{
>> + const char **list, *m =3D (char *)&drive->id[ATA_ID_PROD];
>> +
>> + for (list =3D am74xx_quirk_drives; *list !=3D NULL; list++)
>> + if (strstr(m, *list) !=3D NULL) {
>> + drive->quirk_list =3D 2;
>> + return;
>> + }
>> +
>> + drive->quirk_list =3D 0;
>> +
>> +}
>> +
>> static void amd7409_cable_detect(struct pci_dev *dev)
>> {
>> /* no host side cable detection */
>> @@ -194,6 +213,7 @@ static void __devinit init_hwif_amd74xx(ide_hwif=
_t
>> *hwif)
>> static const struct ide_port_ops amd_port_ops =3D {
>> .set_pio_mode =3D amd_set_pio_mode,
>> .set_dma_mode =3D amd_set_drive,
>> + .quirkproc =3D amd_quirkproc,
>> .cable_detect =3D amd_cable_detect,
>> };
>>
>>    =20
>
> MBR, Sergei
>
>  =20


--=20
=E6=99=8F=E5=8D=8E


