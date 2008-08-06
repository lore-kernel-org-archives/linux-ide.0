From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: [PATCH 1/2] pata_legacy: export functionality to ide
Date: Wed, 6 Aug 2008 16:03:32 +0200
Message-ID: <9ea470500808060703p4a94c868i25106e081aad75c4@mail.gmail.com>
References: <20080802183253.GA2239@gollum.tnic>
	 <20080803125907.67676948@lxorguk.ukuu.org.uk>
	 <20080803143837.GA26672@gollum.tnic>
	 <20080803162214.394b13a1@lxorguk.ukuu.org.uk>
	 <20080803165135.GA31977@gollum.tnic> <4898630C.7090403@ru.mvista.com>
	 <9ea470500808050732s7be29360ge358790e955be06a@mail.gmail.com>
	 <58cb370e0808050741v7ff3f20awb3d91a84486f8547@mail.gmail.com>
	 <20080806061023.GA23773@gollum.tnic> <48998C58.20703@ru.mvista.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:28548 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbYHFODd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 10:03:33 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4961130wfd.4
        for <linux-ide@vger.kernel.org>; Wed, 06 Aug 2008 07:03:32 -0700 (PDT)
In-Reply-To: <48998C58.20703@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Aug 6, 2008 at 1:34 PM, Sergei Shtylyov <sshtylyov@ru.mvista.co=
m> wrote:
> Hello.
>
> Borislav Petkov wrote:
>>
>> From: Borislav Petkov <petkovbb@gmail.com>
>> Date: Sun, 3 Aug 2008 18:46:35 +0200
>> Subject: [PATCH] ide-generic: handle probing of legacy io-ports v4
>>
>> Avoid probing the io-ports in case an IDE PCI controller is present =
and it
>> uses
>> the legacy iobases. If we still want to enforce the probing, we do
>>
>> ide_generic.probe_mask=3D0x3f
>>
>> on the kernel command line. The iobase checking code is adapted from
>> drivers/ata/pata_legacy.c after converting hex pci ids into their
>> corresponding
>> macros in <linux/pci_ids.h>.
>>
>> CC: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
>>
>
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
>> diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
>> index 8fe8b5b..efce159 100644
>> --- a/drivers/ide/ide-generic.c
>> +++ b/drivers/ide/ide-generic.c
>>
>
> [...]
>>
>> @@ -100,19 +101,69 @@ static const u16 legacy_bases[] =3D { 0x1f0, 0=
x170,
>> 0x1e8, 0x168, 0x1e0, 0x160 };
>>  static const int legacy_irqs[]  =3D { 14, 15, 11, 10, 8, 12 };
>>  #endif
>>  +static void ide_generic_check_pci_legacy_iobases(int *primary, int
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
>>
>
>  Would have been probably enough to test only BAR0/2, don't you think=
?

I assume you're referring to the legacy ioports fixup in
drivers/pci/probe.c:pci_setup_device(). Yes, there's no need to go all =
the way
to BAR5 since those are guaranteed unused in compatibility mode, so act=
ually the
loop should go till 4. Bart, can you please change that when applying?

--=20
Regards/Gru=DF,
Boris
