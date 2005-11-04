From: Virginio GL <virginiogl_web@ono.com>
Subject: Re: sata_sil.c, firmware information
Date: Fri, 4 Nov 2005 18:46:42 +0100
Message-ID: <200511041846.42421.virginiogl_web@ono.com>
References: <200511041150.46666.virginiogl_web@ono.com> <58cb370e0511040535o5a3e41dcl701c8ff60d5b704f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ono.com ([62.42.230.12]:16553 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S1750769AbVKDRq7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Nov 2005 12:46:59 -0500
In-Reply-To: <58cb370e0511040535o5a3e41dcl701c8ff60d5b704f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Yes. I've upgrade my kernel to 2.6.14 and apply the patch and work perf=
ectly.
Thank you very much.

El Viernes, 4 de Noviembre de 2005 14:35, Bartlomiej Zolnierkiewicz esc=
ribi=C3=B3:
> On 11/4/05, Virginio GL <virginiogl_web@ono.com> wrote:
> > Doing "hdparam -I /dev/sda":
> >
> > **
> > Capabilities:
> >         LBA, IORDY(can be disabled)
> >         bytes avail on r/w long: 4      Queue depth: 1
> >         Standby timer values: spec'd by Standard, no device specifi=
c
> > minimum R/W multiple sector transfer: Max =3D 16  Current =3D 16
> >         Recommended acoustic management value: 254, current value: =
0
> >         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5=
 udma6
> >              Cycle time: min=3D120ns recommended=3D120ns
> > **
> >
> > =C2=BFwhy is not configured in udma6 by default? ("hdparm -X70 /dev=
/sda" not
> > work).
>
> Does attached patch work for you?
>
> Bartlomiej

--=20
http://virginiogl.blogspot.com/
