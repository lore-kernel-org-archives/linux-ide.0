From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 8 May 2009 20:02:38 +0200
Message-ID: <200905082002.38487.bzolnier@gmail.com>
References: <49CCD7C4.8000207@inov.pt> <200905081404.29868.bzolnier@gmail.com> <4A046BB6.6060806@inov.pt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:34450 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbZEHR64 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 May 2009 13:58:56 -0400
Received: by fxm2 with SMTP id 2so1533000fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 08 May 2009 10:58:55 -0700 (PDT)
In-Reply-To: <4A046BB6.6060806@inov.pt>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Friday 08 May 2009 19:28:22 Jo=E3o Ramos wrote:
>=20
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
> So after all this discussion ;-) , my driver will have no 'init_hwif'=
=20
> method, and the setup code will be on 'ep93xx_ide_probe', which will=20
> configure entirely the IDE host controller.
> Moreover, this initial configuration will setup the controller to wor=
k=20
> at PIO Mode 0. Later on, the 'set_pio_mode' method will be called and=
=20
> the controller will configure itself according to the PIO mode report=
ed=20
> by the IDE core.
>=20
> Can I proceed this way?

Well, yes.  Though I hoped that you would at least give a try to fixing
IDE core to program PIO0 initially for all host drivers that implement
->set_pio_mode method...

> >  =20
> >> There's just only one issue; normally, I would setup the specific=20
> >> timings (t0, t1, t2, t2i, etc) in the 'pio_set_mode' hook. However=
, if=20
> >> you look further in the driver, those timings aren't defined throu=
gh a=20
> >> memory controller but instead manually enforced by 'ndelay' calls =
(arghhh).
> >> This means that in my low-level procedures for reading and writing=
, I=20
> >> need to have access to the timings (or the struct ide_timing)=20
> >> corresponding to the PIO mode selected, in order to use the correc=
t delays.
> >>
> >> My question is: which is the best way to accomplish this? Declarin=
g a=20
> >> global struct ide_timing variable pointer that always holds the co=
rrect=20
> >> ide_timing struct to the selected PIO mode? Or should I always che=
ck (in=20
> >> some manner) what is the current PIO mode and then select the adeq=
uate=20
> >> delays?
> >>    =20
> >
> > I think that the setting variable pointer in ->set_pio_mode method =
would
> > work best.  Seems like the existing drive_data field of ide_drive_t=
 is well
> > suited for this purpose (however it may be worth to convert it to '=
void *'
> > type while we are it).
> >  =20
>=20
> Did you mean 'drive_data' field, or 'driver_data' field?
> 'drive_data' field is an unsigned int value; I guess you meant=20
> 'driver_data' field as it is a (void *) field, so I can define it as =
a=20
> pointer to the correct 'struct ide_timing'.

That is why I hinted that you may need to convert 'drive_data' to
'void *' type first.  You may also try to use 'driver_data' instead
but you will discover rather quickly that you shouldn't do this... ;)

'driver_data' is for use by IDE core and IDE device drivers.

'drive_data' is for use by IDE host drivers.

Thanks,
Bart
