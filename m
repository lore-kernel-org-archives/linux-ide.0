From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 8 May 2009 20:55:29 +0200
Message-ID: <200905082055.29993.bzolnier@gmail.com>
References: <49CCD7C4.8000207@inov.pt> <200905082002.38487.bzolnier@gmail.com> <4A047718.2000707@inov.pt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:44041 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbZEHSwW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 May 2009 14:52:22 -0400
Received: by bwz22 with SMTP id 22so1529321bwz.37
        for <linux-ide@vger.kernel.org>; Fri, 08 May 2009 11:52:21 -0700 (PDT)
In-Reply-To: <4A047718.2000707@inov.pt>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Friday 08 May 2009 20:16:56 Jo=E3o Ramos wrote:
> Bartlomiej Zolnierkiewicz escreveu:
> > On Friday 08 May 2009 19:28:22 Jo=E3o Ramos wrote:
> >  =20
> >>> Yes! :)
> >>>
> >>> There is still a room for improvement though -- it would be bette=
r to fix
> >>> IDE core to set PIO0 before probing devices for all host controll=
ers.
> >>>
> >>> Moreover it seems that doing it this way would allow us to remove=
 ->init_hwif
> >>> method from this driver and do all necessary setup in ep93xx_ide_=
probe()
> >>> (this controller is a single port one so theoretically there shou=
ldn't be
> >>> a need for having per-port ->init_hwif implementation).
> >>>  =20
> >>>      =20
> >> So after all this discussion ;-) , my driver will have no 'init_hw=
if'=20
> >> method, and the setup code will be on 'ep93xx_ide_probe', which wi=
ll=20
> >> configure entirely the IDE host controller.
> >> Moreover, this initial configuration will setup the controller to =
work=20
> >> at PIO Mode 0. Later on, the 'set_pio_mode' method will be called =
and=20
> >> the controller will configure itself according to the PIO mode rep=
orted=20
> >> by the IDE core.
> >>
> >> Can I proceed this way?
> >>    =20
> >
> > Well, yes.  Though I hoped that you would at least give a try to fi=
xing
> > IDE core to program PIO0 initially for all host drivers that implem=
ent
> > ->set_pio_mode method...
> >  =20
>=20
> Sorry, I didn't noticed your hint... Sure, I can give it a try ;-)
> Maybe with a little help, but I can try. You mean, when the host driv=
er=20
> is registered (ide_host_register, or ide_host_add that later calls=20
> ide_host_register), maybe in the 'ide_init_port' method (sorry, I nee=
d=20
> some guidance here...) check if the 'set_pio_mode' method is=20
> implemented, and after initializing each port (d->init_hwif(hwif))=20
> default it to PIO Mode 0, calling set_pio_mode method.

ide_init_port() seems OK but I think that ide_port_init_devices()
[it is called after ide_init_port()] would be a bit safer and more
flexible (some host drivers may also require special ->init_dev
setup first) and the check for ->set_pio_mode method presence can
be done just before actually using the method, i.e.

	const struct ide_port_ops *port_ops =3D hwif->port_ops;

	if (port_ops && port_ops->set_pio_mode)
		port_ops->set_pio_mode(...)

> Is this correct? Sorry, has I stated earlier, I'm wasn't familiar wit=
h=20
> the IDE susbsystem untill I wrote this patch; but I'm willing to=20
> contribute in any way I can, so please, bear with me on this :-) .

Sure, nobody starts from the expert level and not all maintainers are
into "prove the maintainer wrong" elitist's idiocy. ;)

> >  =20
> >>>  =20
> >>>      =20
> >>>> There's just only one issue; normally, I would setup the specifi=
c=20
> >>>> timings (t0, t1, t2, t2i, etc) in the 'pio_set_mode' hook. Howev=
er, if=20
> >>>> you look further in the driver, those timings aren't defined thr=
ough a=20
> >>>> memory controller but instead manually enforced by 'ndelay' call=
s (arghhh).
> >>>> This means that in my low-level procedures for reading and writi=
ng, I=20
> >>>> need to have access to the timings (or the struct ide_timing)=20
> >>>> corresponding to the PIO mode selected, in order to use the corr=
ect delays.
> >>>>
> >>>> My question is: which is the best way to accomplish this? Declar=
ing a=20
> >>>> global struct ide_timing variable pointer that always holds the =
correct=20
> >>>> ide_timing struct to the selected PIO mode? Or should I always c=
heck (in=20
> >>>> some manner) what is the current PIO mode and then select the ad=
equate=20
> >>>> delays?
> >>>>    =20
> >>>>        =20
> >>> I think that the setting variable pointer in ->set_pio_mode metho=
d would
> >>> work best.  Seems like the existing drive_data field of ide_drive=
_t is well
> >>> suited for this purpose (however it may be worth to convert it to=
 'void *'
> >>> type while we are it).
> >>>  =20
> >>>      =20
> >> Did you mean 'drive_data' field, or 'driver_data' field?
> >> 'drive_data' field is an unsigned int value; I guess you meant=20
> >> 'driver_data' field as it is a (void *) field, so I can define it =
as a=20
> >> pointer to the correct 'struct ide_timing'.
> >>    =20
> >
> > That is why I hinted that you may need to convert 'drive_data' to
> > 'void *' type first.  You may also try to use 'driver_data' instead
> > but you will discover rather quickly that you shouldn't do this... =
;)
> >
> > 'driver_data' is for use by IDE core and IDE device drivers.
> >
> > 'drive_data' is for use by IDE host drivers.
> >  =20
>=20
> And this conversion is made by my driver code, or should I fix direct=
ly=20
> in the ide_drive_t structure?

The latter -- ide_drive_t is the place needing fixing.

Thanks,
Bart
