From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 08 May 2009 18:28:22 +0100
Message-ID: <4A046BB6.6060806@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <20090507145315.3e85b2a8@lxorguk.ukuu.org.uk> <4A02FF40.6090303@inov.pt> <200905081404.29868.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:59409 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754265AbZEHRbO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 May 2009 13:31:14 -0400
In-Reply-To: <200905081404.29868.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org


>
> Yes! :)
>
> There is still a room for improvement though -- it would be better to=
 fix
> IDE core to set PIO0 before probing devices for all host controllers.
>
> Moreover it seems that doing it this way would allow us to remove ->i=
nit_hwif
> method from this driver and do all necessary setup in ep93xx_ide_prob=
e()
> (this controller is a single port one so theoretically there shouldn'=
t be
> a need for having per-port ->init_hwif implementation).
>  =20

So after all this discussion ;-) , my driver will have no 'init_hwif'=20
method, and the setup code will be on 'ep93xx_ide_probe', which will=20
configure entirely the IDE host controller.
Moreover, this initial configuration will setup the controller to work=20
at PIO Mode 0. Later on, the 'set_pio_mode' method will be called and=20
the controller will configure itself according to the PIO mode reported=
=20
by the IDE core.

Can I proceed this way?

>  =20
>> There's just only one issue; normally, I would setup the specific=20
>> timings (t0, t1, t2, t2i, etc) in the 'pio_set_mode' hook. However, =
if=20
>> you look further in the driver, those timings aren't defined through=
 a=20
>> memory controller but instead manually enforced by 'ndelay' calls (a=
rghhh).
>> This means that in my low-level procedures for reading and writing, =
I=20
>> need to have access to the timings (or the struct ide_timing)=20
>> corresponding to the PIO mode selected, in order to use the correct =
delays.
>>
>> My question is: which is the best way to accomplish this? Declaring =
a=20
>> global struct ide_timing variable pointer that always holds the corr=
ect=20
>> ide_timing struct to the selected PIO mode? Or should I always check=
 (in=20
>> some manner) what is the current PIO mode and then select the adequa=
te=20
>> delays?
>>    =20
>
> I think that the setting variable pointer in ->set_pio_mode method wo=
uld
> work best.  Seems like the existing drive_data field of ide_drive_t i=
s well
> suited for this purpose (however it may be worth to convert it to 'vo=
id *'
> type while we are it).
>  =20

Did you mean 'drive_data' field, or 'driver_data' field?
'drive_data' field is an unsigned int value; I guess you meant=20
'driver_data' field as it is a (void *) field, so I can define it as a=20
pointer to the correct 'struct ide_timing'.

Regards,
Jo=E3o


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

