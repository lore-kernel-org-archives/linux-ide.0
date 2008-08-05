From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: [PATCH 1/2] pata_legacy: export functionality to ide
Date: Tue, 5 Aug 2008 16:32:25 +0200
Message-ID: <9ea470500808050732s7be29360ge358790e955be06a@mail.gmail.com>
References: <20080715053356.GA18628@gollum.tnic>
	 <200808021902.12191.bzolnier@gmail.com>
	 <20080802183253.GA2239@gollum.tnic>
	 <200808022046.16990.bzolnier@gmail.com>
	 <20080803073756.GA8762@gollum.tnic>
	 <20080803125907.67676948@lxorguk.ukuu.org.uk>
	 <20080803143837.GA26672@gollum.tnic>
	 <20080803162214.394b13a1@lxorguk.ukuu.org.uk>
	 <20080803165135.GA31977@gollum.tnic> <4898630C.7090403@ru.mvista.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:1534 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbYHEOc1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 10:32:27 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1469649ywe.1
        for <linux-ide@vger.kernel.org>; Tue, 05 Aug 2008 07:32:26 -0700 (PDT)
In-Reply-To: <4898630C.7090403@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Aug 5, 2008 at 4:26 PM, Sergei Shtylyov <sshtylyov@ru.mvista.co=
m> wrote:
> Hello.
>
> Borislav Petkov wrote:
>
>> Avoid probing the io-ports in case an IDE PCI controller is present =
and it
>> uses
>> the legacy iobases. If we still want to enforce the probing, we do
>
>> ide_generic.probe_mask=3D0x3f
>
>> on the kernel command line. The iobase checking code is adapted from
>> drivers/ata/pata_legacy.c
>
>> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
>
>> diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
>> index 8fe8b5b..e9b7b69 100644
>> --- a/drivers/ide/ide-generic.c
>> +++ b/drivers/ide/ide-generic.c
>
> [...]
>>
>> @@ -100,19 +100,71 @@ static const u16 legacy_bases[] =3D { 0x1f0, 0=
x170,
>> 0x1e8, 0x168, 0x1e0, 0x160 };
>>  static const int legacy_irqs[]  =3D { 14, 15, 11, 10, 8, 12 };
>>  #endif
>>  +
>
>   Extra newline...
>
>> +static void ide_generic_check_pci_legacy_iobases(int *primary, int
>> *secondary)
>> +{
>> +       struct pci_dev *p =3D NULL;
>> +       u16 val;
>> +
>> +       for_each_pci_dev(p) {
>> +               int r;
>> +
>> +               for (r =3D 0; r < 6; r++) {
>> +                       if (pci_resource_start(p, r) =3D=3D 0x1f0)
>> +                               *primary =3D 1;
>> +                       if (pci_resource_start(p, r) =3D=3D 0x170)
>> +                               *secondary =3D 1;
>> +               }
>> +
>> +               /* Cyrix CS5510 pre SFF MWDMA ATA on the bridge */
>> +               if (p->vendor =3D=3D 0x1078 && p->device =3D=3D 0x00=
00)
>> +                       *primary =3D *secondary =3D 1;
>> +
>> +               /* Cyrix CS5520 pre SFF MWDMA ATA on the bridge */
>> +               if (p->vendor =3D=3D 0x1078 && p->device =3D=3D 0x00=
02)
>> +                       *primary =3D *secondary =3D 1;
>
>   I think the above two if statements should be collapsed into a sing=
le one.

This is code is actually from the pata_legacy.c but yep, you're right,
those can merge.

>
>> +
>> +               /* Intel MPIIX - PIO ATA on non PCI side of bridge *=
/
>> +               if (p->vendor =3D=3D 0x8086 && p->device =3D=3D 0x12=
34) {
>
>   Also, perhaps it makes sense to #include <linux/pci_ids.h> and use =
the
> macros defined there...

Will look into it later and redo the patch, thanks for reviewing. I
still haven't heard from
Bart, though, whether he's OK with the code duplication...?

--=20
Regards/Gru=DF,
Boris
