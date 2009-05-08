From: joao.ramos@inov.pt
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri,  8 May 2009 21:24:57 +0100
Message-ID: <20090508212457.fxyzi9gk3cw4ksw0@webmail.inov.pt>
References: <49CCD7C4.8000207@inov.pt>
	<200905082002.38487.bzolnier@gmail.com> <4A047718.2000707@inov.pt>
	<200905082055.29993.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:42619 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756526AbZEHUZl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 May 2009 16:25:41 -0400
In-Reply-To: <200905082055.29993.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Quoting Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>:

> On Friday 08 May 2009 20:16:56 Jo=E3o Ramos wrote:
>> Bartlomiej Zolnierkiewicz escreveu:
>> > On Friday 08 May 2009 19:28:22 Jo=E3o Ramos wrote:
>> >
>> >>> Yes! :)
>> >>>
>> >>> There is still a room for improvement though -- it would be=20
>> better to fix
>> >>> IDE core to set PIO0 before probing devices for all host control=
lers.
>> >>>
>> >>> Moreover it seems that doing it this way would allow us to=20
>> remove ->init_hwif
>> >>> method from this driver and do all necessary setup in ep93xx_ide=
_probe()
>> >>> (this controller is a single port one so theoretically there=20
>> shouldn't be
>> >>> a need for having per-port ->init_hwif implementation).
>> >>>
>> >>>
>> >> So after all this discussion ;-) , my driver will have no 'init_h=
wif'
>> >> method, and the setup code will be on 'ep93xx_ide_probe', which w=
ill
>> >> configure entirely the IDE host controller.
>> >> Moreover, this initial configuration will setup the controller to=
 work
>> >> at PIO Mode 0. Later on, the 'set_pio_mode' method will be called=
 and
>> >> the controller will configure itself according to the PIO mode re=
ported
>> >> by the IDE core.
>> >>
>> >> Can I proceed this way?
>> >>
>> >
>> > Well, yes.  Though I hoped that you would at least give a try to f=
ixing
>> > IDE core to program PIO0 initially for all host drivers that imple=
ment
>> > ->set_pio_mode method...
>> >
>>
>> Sorry, I didn't noticed your hint... Sure, I can give it a try ;-)
>> Maybe with a little help, but I can try. You mean, when the host dri=
ver
>> is registered (ide_host_register, or ide_host_add that later calls
>> ide_host_register), maybe in the 'ide_init_port' method (sorry, I ne=
ed
>> some guidance here...) check if the 'set_pio_mode' method is
>> implemented, and after initializing each port (d->init_hwif(hwif))
>> default it to PIO Mode 0, calling set_pio_mode method.
>
> ide_init_port() seems OK but I think that ide_port_init_devices()
> [it is called after ide_init_port()] would be a bit safer and more
> flexible (some host drivers may also require special ->init_dev
> setup first) and the check for ->set_pio_mode method presence can
> be done just before actually using the method, i.e.
>
> 	const struct ide_port_ops *port_ops =3D hwif->port_ops;
>
> 	if (port_ops && port_ops->set_pio_mode)
> 		port_ops->set_pio_mode(...)

Ok. I'll will give that a try and I'll report back with a proposed=20
patch for it.

>
>> Is this correct? Sorry, has I stated earlier, I'm wasn't familiar wi=
th
>> the IDE susbsystem untill I wrote this patch; but I'm willing to
>> contribute in any way I can, so please, bear with me on this :-) .
>
> Sure, nobody starts from the expert level and not all maintainers are
> into "prove the maintainer wrong" elitist's idiocy. ;)
>
>> >
>> >>>
>> >>>
>> >>>> There's just only one issue; normally, I would setup the specif=
ic
>> >>>> timings (t0, t1, t2, t2i, etc) in the 'pio_set_mode' hook. Howe=
ver, if
>> >>>> you look further in the driver, those timings aren't defined th=
rough a
>> >>>> memory controller but instead manually enforced by 'ndelay'=20
>> calls (arghhh).
>> >>>> This means that in my low-level procedures for reading and writ=
ing, I
>> >>>> need to have access to the timings (or the struct ide_timing)
>> >>>> corresponding to the PIO mode selected, in order to use the=20
>> correct delays.
>> >>>>
>> >>>> My question is: which is the best way to accomplish this? Decla=
ring a
>> >>>> global struct ide_timing variable pointer that always holds the=
 correct
>> >>>> ide_timing struct to the selected PIO mode? Or should I always=20
>> check (in
>> >>>> some manner) what is the current PIO mode and then select the a=
dequate
>> >>>> delays?
>> >>>>
>> >>>>
>> >>> I think that the setting variable pointer in ->set_pio_mode meth=
od would
>> >>> work best.  Seems like the existing drive_data field of=20
>> ide_drive_t is well
>> >>> suited for this purpose (however it may be worth to convert it=20
>> to 'void *'
>> >>> type while we are it).
>> >>>
>> >>>
>> >> Did you mean 'drive_data' field, or 'driver_data' field?
>> >> 'drive_data' field is an unsigned int value; I guess you meant
>> >> 'driver_data' field as it is a (void *) field, so I can define it=
 as a
>> >> pointer to the correct 'struct ide_timing'.
>> >>
>> >
>> > That is why I hinted that you may need to convert 'drive_data' to
>> > 'void *' type first.  You may also try to use 'driver_data' instea=
d
>> > but you will discover rather quickly that you shouldn't do this...=
 ;)
>> >
>> > 'driver_data' is for use by IDE core and IDE device drivers.
>> >
>> > 'drive_data' is for use by IDE host drivers.
>> >
>>
>> And this conversion is made by my driver code, or should I fix direc=
tly
>> in the ide_drive_t structure?
>
> The latter -- ide_drive_t is the place needing fixing.

Same: I will fix that and propose a patch.

Regards,
Jo=E3o Ramos

>
> Thanks,
> Bart
>



