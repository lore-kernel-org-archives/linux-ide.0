From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 8 May 2009 14:40:29 +0200
Message-ID: <200905081440.30147.bzolnier@gmail.com>
References: <49CCD7C4.8000207@inov.pt> <200905081404.29868.bzolnier@gmail.com> <4A0422B7.9010903@inov.pt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:29601 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759022AbZEHM7V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 May 2009 08:59:21 -0400
Received: by fg-out-1718.google.com with SMTP id d23so121347fga.17
        for <linux-ide@vger.kernel.org>; Fri, 08 May 2009 05:59:20 -0700 (PDT)
In-Reply-To: <4A0422B7.9010903@inov.pt>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

On Friday 08 May 2009 14:16:55 Jo=E3o Ramos wrote:
> Bartlomiej Zolnierkiewicz escreveu:
> > On Thursday 07 May 2009 17:33:20 Jo=E3o Ramos wrote:
> >  =20
> >> Alan Cox escreveu:
> >>    =20
> >>>> So you're saying I should support all PIO modes? If so, I would =
have to=20
> >>>> make conditional code, checking perhaps a module param to sort w=
hich PIO=20
> >>>> mode to use.
> >>>>    =20
> >>>>        =20
> >>> If you advertise PIO0-PIO4 as supported the core IDE code will do=
 all the
> >>> work on figuring which modes are supported by the attached device=
s. You
> >>> just need to be able to set them.
> >>>
> >>> Alan
> >>>  =20
> >>>      =20
> >> Ok, so I've been studying that (I was quite lost for a time, I con=
fess,=20
> >> I'm not that much familiar with the IDE subsystem, so please bear =
with=20
> >> me ;-) ).
> >>
> >> So I need to set up a hook for 'set_pio_mode()', so that when the =
IDE=20
> >> subsystem detects a device and figures the most suitable PIO mode =
for=20
> >> the device, it will call the 'set_pio_mode' routine provided by th=
e=20
> >> driver in order to configure the host controller for that PIO mode=
=2E
> >>
> >> This also means that my host controller driver should always defau=
lt to=20
> >> PIO Mode 0, as the initial host controller setup that is carried o=
ut by=20
> >> the 'init_hwif' routine, allowing devices to be detected. Afterwar=
ds,=20
> >> the IDE subsystem detects the most suitable PIO mode and calls=20
> >> 'set_pio_mode' to change that configuration.
> >>
> >> Am I correct on this?
> >>    =20
> >
> > Yes! :)
> >
> > There is still a room for improvement though -- it would be better =
to fix
> > IDE core to set PIO0 before probing devices for all host controller=
s.
> >
> > Moreover it seems that doing it this way would allow us to remove -=
>init_hwif
> > method from this driver and do all necessary setup in ep93xx_ide_pr=
obe()
> > (this controller is a single port one so theoretically there should=
n't be
> > a need for having per-port ->init_hwif implementation).
> >  =20
>=20
> So, I should remove the 'init_hwif' hook, and all the host controller=
=20
> setup would be made in the driver's probe method, correct?

Yes, that would be preferred (of course given that you fix IDE core to =
do
initial PIO0 setup first).

Thanks,
Bart
