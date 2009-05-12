From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Tue, 12 May 2009 18:30:01 +0200
Message-ID: <200905121830.07023.bzolnier@gmail.com>
References: <49CCD7C4.8000207@inov.pt> <4A046BB6.6060806@inov.pt> <4A099D71.5040703@inov.pt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:24006 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbZELQbT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 May 2009 12:31:19 -0400
Received: by fg-out-1718.google.com with SMTP id d23so816142fga.17
        for <linux-ide@vger.kernel.org>; Tue, 12 May 2009 09:31:19 -0700 (PDT)
In-Reply-To: <4A099D71.5040703@inov.pt>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-1?q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Tuesday 12 May 2009 18:01:53 Jo=E3o Ramos wrote:
> Jo=E3o Ramos escreveu:
> >
> >>
> >> Yes! :)
> >>
> >> There is still a room for improvement though -- it would be better=
 to=20
> >> fix
> >> IDE core to set PIO0 before probing devices for all host controlle=
rs.
> >>
> >> Moreover it seems that doing it this way would allow us to remove=20
> >> ->init_hwif
> >> method from this driver and do all necessary setup in ep93xx_ide_p=
robe()
> >> (this controller is a single port one so theoretically there=20
> >> shouldn't be
> >> a need for having per-port ->init_hwif implementation).
> >>  =20
> >
> > So after all this discussion ;-) , my driver will have no 'init_hwi=
f'=20
> > method, and the setup code will be on 'ep93xx_ide_probe', which wil=
l=20
> > configure entirely the IDE host controller.
> > Moreover, this initial configuration will setup the controller to w=
ork=20
> > at PIO Mode 0. Later on, the 'set_pio_mode' method will be called a=
nd=20
> > the controller will configure itself according to the PIO mode=20
> > reported by the IDE core.
> >
> > Can I proceed this way?
> >
> >> =20
> >>> There's just only one issue; normally, I would setup the specific=
=20
> >>> timings (t0, t1, t2, t2i, etc) in the 'pio_set_mode' hook. Howeve=
r,=20
> >>> if you look further in the driver, those timings aren't defined=20
> >>> through a memory controller but instead manually enforced by=20
> >>> 'ndelay' calls (arghhh).
> >>> This means that in my low-level procedures for reading and writin=
g,=20
> >>> I need to have access to the timings (or the struct ide_timing)=20
> >>> corresponding to the PIO mode selected, in order to use the corre=
ct=20
> >>> delays.
> >>>
> >>> My question is: which is the best way to accomplish this? Declari=
ng=20
> >>> a global struct ide_timing variable pointer that always holds the=
=20
> >>> correct ide_timing struct to the selected PIO mode? Or should I=20
> >>> always check (in some manner) what is the current PIO mode and th=
en=20
> >>> select the adequate delays?
> >>>    =20
> >>
> >> I think that the setting variable pointer in ->set_pio_mode method=
 would
> >> work best.  Seems like the existing drive_data field of ide_drive_=
t=20
> >> is well
> >> suited for this purpose (however it may be worth to convert it to=20
> >> 'void *'
> >> type while we are it).
> >> =20
>=20
> Are you sure I can do this safely?
>=20
> Using the patch i've sent earlier, I am using the 'drive_data' field =
=20
> (now converted to void * type) to store the struct ide_timing pointer=
=20
> that holds the adequate timings for the selected PIO mode.
> This is working, and the fix you suggested works, but sometimes I get=
 a=20
> null pointer dereference I can't seem to figure why.
> As I needed to define low-level read/write procedures, I've defined t=
he=20
> entire ide_tp_ops structure with my own provided methods.
> For the tf_load, tf_read, input_data and output_data methods, the fix=
 is=20
> easy since I have an ide_drive_t structure pointer as a parameter, so=
 I=20
> access the timing structure using:
>=20
> struct ide_timing *t =3D (struct ide_timing *) ide_get_drivedata(driv=
e);
>=20
> However, for the remaining methods (exec_command, read_status,=20
> read_altstatus, write_devctl and dev_select), I only have access to a=
n=20
> ide_hwif_t pointer, so in order to get access to the containing=20
> ide_drive_t and then to the struct ide_timing pointer stored before, =
I do:
>=20
> ide_drive_t *drive =3D (ide_drive_t *) container_of(&hwif, ide_drive_=
t, hwif);

This doesn't look correct.

> struct ide_timing *t =3D (struct ide_timing *) ide_get_drivedata(driv=
e);
>=20
> And this seems to work, however at some point, after a while I get a=20
> kernel Oops pointing out a null pointer dereference.
>=20
> Can someone help me here?
> Is there a better way to retrieve the ide_drive_t pointer from the=20
> ide_hwif_t structure?

hwif->devices[0] / hwif->devices[1]

However, I see the problem -- we need timing data also for command PIO.

Sergei, seems like we should just stuff pointer to command PIO timings
(which would be maximum PIO supported by both devices on the port) into
hwif->hwif_data and use it everywhere except ->*put_data methods?

Or maybe there is some better way to do it?

Thanks,
Bart
