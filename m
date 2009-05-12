From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Tue, 12 May 2009 17:01:53 +0100
Message-ID: <4A099D71.5040703@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <20090507145315.3e85b2a8@lxorguk.ukuu.org.uk> <4A02FF40.6090303@inov.pt> <200905081404.29868.bzolnier@gmail.com> <4A046BB6.6060806@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:52049 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbZELQCr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 May 2009 12:02:47 -0400
In-Reply-To: <4A046BB6.6060806@inov.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Jo=E3o Ramos escreveu:
>
>>
>> Yes! :)
>>
>> There is still a room for improvement though -- it would be better t=
o=20
>> fix
>> IDE core to set PIO0 before probing devices for all host controllers=
=2E
>>
>> Moreover it seems that doing it this way would allow us to remove=20
>> ->init_hwif
>> method from this driver and do all necessary setup in ep93xx_ide_pro=
be()
>> (this controller is a single port one so theoretically there=20
>> shouldn't be
>> a need for having per-port ->init_hwif implementation).
>>  =20
>
> So after all this discussion ;-) , my driver will have no 'init_hwif'=
=20
> method, and the setup code will be on 'ep93xx_ide_probe', which will=20
> configure entirely the IDE host controller.
> Moreover, this initial configuration will setup the controller to wor=
k=20
> at PIO Mode 0. Later on, the 'set_pio_mode' method will be called and=
=20
> the controller will configure itself according to the PIO mode=20
> reported by the IDE core.
>
> Can I proceed this way?
>
>> =20
>>> There's just only one issue; normally, I would setup the specific=20
>>> timings (t0, t1, t2, t2i, etc) in the 'pio_set_mode' hook. However,=
=20
>>> if you look further in the driver, those timings aren't defined=20
>>> through a memory controller but instead manually enforced by=20
>>> 'ndelay' calls (arghhh).
>>> This means that in my low-level procedures for reading and writing,=
=20
>>> I need to have access to the timings (or the struct ide_timing)=20
>>> corresponding to the PIO mode selected, in order to use the correct=
=20
>>> delays.
>>>
>>> My question is: which is the best way to accomplish this? Declaring=
=20
>>> a global struct ide_timing variable pointer that always holds the=20
>>> correct ide_timing struct to the selected PIO mode? Or should I=20
>>> always check (in some manner) what is the current PIO mode and then=
=20
>>> select the adequate delays?
>>>    =20
>>
>> I think that the setting variable pointer in ->set_pio_mode method w=
ould
>> work best.  Seems like the existing drive_data field of ide_drive_t=20
>> is well
>> suited for this purpose (however it may be worth to convert it to=20
>> 'void *'
>> type while we are it).
>> =20

Are you sure I can do this safely?

Using the patch i've sent earlier, I am using the 'drive_data' field =20
(now converted to void * type) to store the struct ide_timing pointer=20
that holds the adequate timings for the selected PIO mode.
This is working, and the fix you suggested works, but sometimes I get a=
=20
null pointer dereference I can't seem to figure why.
As I needed to define low-level read/write procedures, I've defined the=
=20
entire ide_tp_ops structure with my own provided methods.
=46or the tf_load, tf_read, input_data and output_data methods, the fix=
 is=20
easy since I have an ide_drive_t structure pointer as a parameter, so I=
=20
access the timing structure using:

struct ide_timing *t =3D (struct ide_timing *) ide_get_drivedata(drive)=
;

However, for the remaining methods (exec_command, read_status,=20
read_altstatus, write_devctl and dev_select), I only have access to an=20
ide_hwif_t pointer, so in order to get access to the containing=20
ide_drive_t and then to the struct ide_timing pointer stored before, I =
do:

ide_drive_t *drive =3D (ide_drive_t *) container_of(&hwif, ide_drive_t,=
 hwif);
struct ide_timing *t =3D (struct ide_timing *) ide_get_drivedata(drive)=
;

And this seems to work, however at some point, after a while I get a=20
kernel Oops pointing out a null pointer dereference.

Can someone help me here?
Is there a better way to retrieve the ide_drive_t pointer from the=20
ide_hwif_t structure?

Best regards,
Jo=E3o Ramos

--=20
***********************************************************************=
*

    Jo=E3o Ramos        <joao.ramos@inov.pt>

    INOV INESC Inova=E7=E3o - ESTG Leiria
    Escola Superior de Tecnologia e Gest=E3o de Leiria
    Ed=EDficio C1, Campus 2
    Morro do Lena, Alto do Vieiro
    Leiria
    2411-901 Leiria
    Portugal

    Tel: +351244843424
    Fax: +351244843424

***********************************************************************=
*

