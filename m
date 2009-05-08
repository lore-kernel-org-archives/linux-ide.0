From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 8 May 2009 14:04:27 +0200
Message-ID: <200905081404.29868.bzolnier@gmail.com>
References: <49CCD7C4.8000207@inov.pt> <20090507145315.3e85b2a8@lxorguk.ukuu.org.uk> <4A02FF40.6090303@inov.pt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:59970 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbZEHMDW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 May 2009 08:03:22 -0400
Received: by ewy24 with SMTP id 24so1765986ewy.37
        for <linux-ide@vger.kernel.org>; Fri, 08 May 2009 05:03:22 -0700 (PDT)
In-Reply-To: <4A02FF40.6090303@inov.pt>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

On Thursday 07 May 2009 17:33:20 Jo=E3o Ramos wrote:
> Alan Cox escreveu:
> >> So you're saying I should support all PIO modes? If so, I would ha=
ve to=20
> >> make conditional code, checking perhaps a module param to sort whi=
ch PIO=20
> >> mode to use.
> >>    =20
> >
> > If you advertise PIO0-PIO4 as supported the core IDE code will do a=
ll the
> > work on figuring which modes are supported by the attached devices.=
 You
> > just need to be able to set them.
> >
> > Alan
> >  =20
>=20
> Ok, so I've been studying that (I was quite lost for a time, I confes=
s,=20
> I'm not that much familiar with the IDE subsystem, so please bear wit=
h=20
> me ;-) ).
>=20
> So I need to set up a hook for 'set_pio_mode()', so that when the IDE=
=20
> subsystem detects a device and figures the most suitable PIO mode for=
=20
> the device, it will call the 'set_pio_mode' routine provided by the=20
> driver in order to configure the host controller for that PIO mode.
>=20
> This also means that my host controller driver should always default =
to=20
> PIO Mode 0, as the initial host controller setup that is carried out =
by=20
> the 'init_hwif' routine, allowing devices to be detected. Afterwards,=
=20
> the IDE subsystem detects the most suitable PIO mode and calls=20
> 'set_pio_mode' to change that configuration.
>=20
> Am I correct on this?

Yes! :)

There is still a room for improvement though -- it would be better to f=
ix
IDE core to set PIO0 before probing devices for all host controllers.

Moreover it seems that doing it this way would allow us to remove ->ini=
t_hwif
method from this driver and do all necessary setup in ep93xx_ide_probe(=
)
(this controller is a single port one so theoretically there shouldn't =
be
a need for having per-port ->init_hwif implementation).

> There's just only one issue; normally, I would setup the specific=20
> timings (t0, t1, t2, t2i, etc) in the 'pio_set_mode' hook. However, i=
f=20
> you look further in the driver, those timings aren't defined through =
a=20
> memory controller but instead manually enforced by 'ndelay' calls (ar=
ghhh).
> This means that in my low-level procedures for reading and writing, I=
=20
> need to have access to the timings (or the struct ide_timing)=20
> corresponding to the PIO mode selected, in order to use the correct d=
elays.
>=20
> My question is: which is the best way to accomplish this? Declaring a=
=20
> global struct ide_timing variable pointer that always holds the corre=
ct=20
> ide_timing struct to the selected PIO mode? Or should I always check =
(in=20
> some manner) what is the current PIO mode and then select the adequat=
e=20
> delays?

I think that the setting variable pointer in ->set_pio_mode method woul=
d
work best.  Seems like the existing drive_data field of ide_drive_t is =
well
suited for this purpose (however it may be worth to convert it to 'void=
 *'
type while we are it).

Thanks,
Bart
