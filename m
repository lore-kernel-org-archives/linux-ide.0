From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3 v3] ide: add at91_ide driver
Date: Fri, 13 Mar 2009 19:47:49 +0100
Message-ID: <200903131947.49361.bzolnier@gmail.com>
References: <200902181106.54260.stf_xl@wp.pl> <200903111800.44380.bzolnier@gmail.com> <49BA9838.5010801@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f175.google.com ([209.85.218.175]:54551 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbZCMTCK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Mar 2009 15:02:10 -0400
Received: by bwz23 with SMTP id 23so232981bwz.37
        for <linux-ide@vger.kernel.org>; Fri, 13 Mar 2009 12:02:06 -0700 (PDT)
In-Reply-To: <49BA9838.5010801@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>

On Friday 13 March 2009, Sergei Shtylyov wrote:
> Hello.
>=20
> Bartlomiej Zolnierkiewicz wrote:
>=20
> >>>>>>This is IDE host driver for AT91 (SAM9, CAP9, AT572D940HF) Stat=
ic=20
> >>>>>>Memory Controller with Compact Flash True IDE Mode logic.
>=20
> >>>>>>Driver have to switch 8/16 bit bus width when accessing Task Ti=
le or=20
> >>>>>>Data
> >>>>>>Register. Moreover some extra things need to be done when setti=
ng=20
> >>>>>>PIO mode.
> >>>>>>Only PIO mode is used, hardware have no DMA support. If interru=
pt=20
> >>>>>>line is
> >>>>>>connected through GPIO extra quirk is needed to cope with fake=20
> >>>>>>interrupts.
>=20
> >>>>>>Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
>=20
> >>>>>   This is prolly only me, but I afil to compile this driver wit=
h the=20
> >>>>>current arch/arm/configs/at91sam9263ek_defconfig:
>=20
> >>>>>  CC      drivers/ide/at91_ide.o
> >>>>>drivers/ide/at91_ide.c: In function =E2=80=98at91_ide_input_data=
=E2=80=99:
> >>>>>drivers/ide/at91_ide.c:159: error: implicit declaration of funct=
ion=20
> >>>>>=E2=80=98__ide_mm_insw=E2=80=99
> >>>>>drivers/ide/at91_ide.c: In function =E2=80=98at91_ide_output_dat=
a=E2=80=99:
> >>>>>drivers/ide/at91_ide.c:174: error: implicit declaration of funct=
ion=20
> >>>>>=E2=80=98__ide_mm_outsw=E2=80=99
> >>>>>drivers/ide/at91_ide.c: In function =E2=80=98at91_ide_tf_load=E2=
=80=99:
> >>>>>drivers/ide/at91_ide.c:192: error: =E2=80=98task=E2=80=99 undecl=
ared (first use in=20
> >>>>>this function)
> >>>>>drivers/ide/at91_ide.c:192: error: (Each undeclared identifier i=
s=20
> >>>>>reported only
> >>>>>once
> >>>>>drivers/ide/at91_ide.c:192: error: for each function it appears =
in.)
> >>>>>drivers/ide/at91_ide.c: At top level:
> >>>>>drivers/ide/at91_ide.c:303: warning: initialization from incompa=
tible=20
> >>>>>pointer type
> >>>>>drivers/ide/at91_ide.c:304: warning: initialization from incompa=
tible=20
> >>>>>pointer type
> >>>>>make[1]: *** [drivers/ide/at91_ide.o] Error 1
> >>>>>make: *** [drivers/ide/] Error 2
>=20
> >>>>   Ah, it's only with pata-2.6 series applied. Bart, you clearly =
need=20
> >>>>to include this driver to some of your patches...
>=20
> > I did and asked people to test the final result (see my mail on mer=
ging
> > at91_ide)... unfortunately it seems like I missed few spots... :)
>=20
> >>    Oops, got muddled in too many follow-ups.  :-)=20
> >>>     Namely, ide-remove-ide_task_t-typedef.patch is incomplete...
>=20
> > Was a bit more than that, I also needed to merge __ide_mm_* fixup b=
elow...
>=20
> > [ Anyway please verify that I got it right this time, thanks! ]
>=20
>     No, looks like you haven't again:
>=20
> Applying patch ide-pass-command-instead-of-request-to-ide_pio_datablo=
ck.patch
> 1 out of 3 hunks FAILED
> missing header for unified diff at line 208 of patch
> The text leading up to this was:
> --------------------------
> |                       printk(KERN_ERR "%s: multimode not set!\n",
> |                                       drive->name);
> --------------------------
> No file to patch.  Skipping patch.
> 11 out of 11 hunks ignored
> Patch ide-pass-command-instead-of-request-to-ide_pio_datablock.patch =
does not=20
> apply (enforce with -f)
>=20
>     It appears that this patch has 2 hunks repeated twice now...

Strangely, the problem seems to be on your side this time as the patch
applies just fine here and AFAIK Stephen has successfully applied it to
linux-next (also md5sum of patch on kernel.org matches the local copy).

Did you forgot to re-sync the whole pata-2.6 tree by any chance?

Thanks,
Bart
