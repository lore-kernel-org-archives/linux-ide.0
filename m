From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3 v3] ide: add at91_ide driver
Date: Wed, 11 Mar 2009 18:00:44 +0100
Message-ID: <200903111800.44380.bzolnier@gmail.com>
References: <200902181106.54260.stf_xl@wp.pl> <49B6BF9F.5050705@ru.mvista.com> <49B6C013.80605@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:36933 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbZCKRA5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Mar 2009 13:00:57 -0400
Received: by mail-ew0-f177.google.com with SMTP id 25so80032ewy.37
        for <linux-ide@vger.kernel.org>; Wed, 11 Mar 2009 10:00:55 -0700 (PDT)
In-Reply-To: <49B6C013.80605@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>

On Tuesday 10 March 2009, Sergei Shtylyov wrote:
> I wrote:
>=20
> >>>> This is IDE host driver for AT91 (SAM9, CAP9, AT572D940HF) Stati=
c=20
> >>>> Memory
> >>>> Controller with Compact Flash True IDE Mode logic.
>=20
> >>>> Driver have to switch 8/16 bit bus width when accessing Task Til=
e or=20
> >>>> Data
> >>>> Register. Moreover some extra things need to be done when settin=
g=20
> >>>> PIO mode.
> >>>> Only PIO mode is used, hardware have no DMA support. If interrup=
t=20
> >>>> line is
> >>>> connected through GPIO extra quirk is needed to cope with fake=20
> >>>> interrupts.
>=20
> >>>> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
>=20
> >>>    This is prolly only me, but I afil to compile this driver with=
 the=20
> >>> current arch/arm/configs/at91sam9263ek_defconfig:
>=20
> >>>   CC      drivers/ide/at91_ide.o
> >>> drivers/ide/at91_ide.c: In function =E2=80=98at91_ide_input_data=E2=
=80=99:
> >>> drivers/ide/at91_ide.c:159: error: implicit declaration of functi=
on=20
> >>> =E2=80=98__ide_mm_insw=E2=80=99
> >>> drivers/ide/at91_ide.c: In function =E2=80=98at91_ide_output_data=
=E2=80=99:
> >>> drivers/ide/at91_ide.c:174: error: implicit declaration of functi=
on=20
> >>> =E2=80=98__ide_mm_outsw=E2=80=99
> >>> drivers/ide/at91_ide.c: In function =E2=80=98at91_ide_tf_load=E2=80=
=99:
> >>> drivers/ide/at91_ide.c:192: error: =E2=80=98task=E2=80=99 undecla=
red (first use in=20
> >>> this function)
> >>> drivers/ide/at91_ide.c:192: error: (Each undeclared identifier is=
=20
> >>> reported only
> >>> once
> >>> drivers/ide/at91_ide.c:192: error: for each function it appears i=
n.)
> >>> drivers/ide/at91_ide.c: At top level:
> >>> drivers/ide/at91_ide.c:303: warning: initialization from incompat=
ible=20
> >>> pointer type
> >>> drivers/ide/at91_ide.c:304: warning: initialization from incompat=
ible=20
> >>> pointer type
> >>> make[1]: *** [drivers/ide/at91_ide.o] Error 1
> >>> make: *** [drivers/ide/] Error 2
>=20
> >>    Ah, it's only with pata-2.6 series applied. Bart, you clearly n=
eed=20
> >> to include this driver to some of your patches...

I did and asked people to test the final result (see my mail on merging
at91_ide)... unfortunately it seems like I missed few spots... :)

>     Oops, got muddled in too many follow-ups. :-)
>     Namely, ide-remove-ide_task_t-typedef.patch is incomplete...

Was a bit more than that, I also needed to merge __ide_mm_* fixup below=
=2E..

[ Anyway please verify that I got it right this time, thanks! ]

=46rom: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] at91_ide: use readsw()/writesw() directly

Use readsw()/writesw() directly intead of __ide_mm_{in,out}sw() macros.

Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
needed for "ide: include <asm/ide.h> only when needed" patch in pata tr=
ee

 drivers/ide/at91_ide.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ide/at91_ide.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/at91_ide.c
+++ b/drivers/ide/at91_ide.c
@@ -156,7 +156,7 @@ static void at91_ide_input_data(ide_driv
 	len++;
=20
 	enter_16bit(chipselect, mode);
-	__ide_mm_insw((void __iomem *) io_ports->data_addr, buf, len / 2);
+	readsw((void __iomem *)io_ports->data_addr, buf, len / 2);
 	leave_16bit(chipselect, mode);
 }
=20
@@ -171,7 +171,7 @@ static void at91_ide_output_data(ide_dri
 	pdbg("cs %u buf %p len %d\n", chipselect,  buf, len);
=20
 	enter_16bit(chipselect, mode);
-	__ide_mm_outsw((void __iomem *) io_ports->data_addr, buf, len / 2);
+	writesw((void __iomem *)io_ports->data_addr, buf, len / 2);
 	leave_16bit(chipselect, mode);
 }
