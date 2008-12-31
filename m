From: "Shane McDonald" <mcdonald.shane@gmail.com>
Subject: Re: [PATCH v3] Resurrect IT8172 IDE controller driver
Date: Tue, 30 Dec 2008 21:20:07 -0600
Message-ID: <b2b2f2320812301920y551371b7u2292fbccc73f4fec@mail.gmail.com>
References: <E1LEfcO-0007lL-Mq@localhost> <49580131.6090006@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:12433 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbYLaDUJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Dec 2008 22:20:09 -0500
In-Reply-To: <49580131.6090006@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I have made the changes you have suggested.  See resolution below.
A v4 patch follows shortly.

On Sun, Dec 28, 2008 at 4:44 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Shane McDonald wrote:
>
>  Well, you're close. :-)

Just 3 more iterations... :-)

>> diff -uprN a/drivers/ide/it8172.c b/drivers/ide/it8172.c
>> --- a/drivers/ide/it8172.c      1969-12-31 18:00:00.000000000 -0600
>> +++ b/drivers/ide/it8172.c      2008-12-22 01:23:15.000000000 -0600
>> @@ -0,0 +1,188 @@
>> +                                    /* RTx  PWx */
>> +       static const u8 timings[][2] =3D {
>> +                                       { 7, 7 },
>> +                                       { 3, 4 },
>
>  This is not enough for PIO mode 1, as this only gives 150 ns active =
+ 120
> ns recovery =3D 270 ns where minimum is 383 ns

OK, I think I understand the required timings now.  I will update PIO m=
ode 1
to set RTx to 7 and PWx to 4, giving 150 ns active + 240 ns recovery
=3D 390 ns (> minimum 383 ns).

>> +       if (drive->dn) {
>
>  Would have been good to collapse both branches...

Yes, the code is quite repetitive.  I've collapsed it into a single
chunk of code.

>> +               if (pio > 2 || ata_id_has_iordy(drive->id))
>
>  You can actually skip "pio > 2" test.

Agreed.

>> +       if (speed >=3D XFER_UDMA_0) {
>> +               u8 udma =3D speed - XFER_UDMA_0;
>> +               u_speed =3D min_t(u8, 2 - (udma & 1), udma) << (driv=
e->dn *
>> 4);
>
>  There's no need to use such complex math when the chip only supports
> UltraDMA modes 0 thru 2. Be simple:
>
>                u_speed =3D udma << (drive->dn * 4);

Suggested change has been implemented.

>> +               if (speed >=3D XFER_MW_DMA_0)
>
>  We dropped support for SWDMA, so the check  should not be needed...

Yes.  Check will be removed.

>> +                       pio =3D mwdma_to_pio[speed - XFER_MW_DMA_0];
>> +               else
>> +                       pio =3D 2;
>>
>
>  ... and *else* branch is pointless.

and is now removed.

>> +               it8172_set_pio_mode(drive, pio);
>
>  Well, not the best place in the PIIX driver -- DMA modes shouldn't a=
ffect
> prefetch and IORDY settings (regardless of what the Intel's programmi=
ng
> manuals say :-).
> =C0lthough, it's probably OK to continue abusing the set_pio_mode() m=
ethod.

I will continue to abuse set_pio_mode().

>
>> +static const struct ide_port_info it8172_port_info __devinitdata =3D=
 {
>> +       .name           =3D DRV_NAME,
>> +       .port_ops       =3D &it8172_port_ops,
>> +       .enablebits     =3D {{0x41, 0x80, 0x80}, {0x00, 0x00, 0x00} =
},
>>
>
>  Inconsistent spacing, add space after first {...

I will correct the spacing.

> MBR, Sergei

Shane
