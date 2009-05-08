From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 08 May 2009 13:16:55 +0100
Message-ID: <4A0422B7.9010903@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <20090507145315.3e85b2a8@lxorguk.ukuu.org.uk> <4A02FF40.6090303@inov.pt> <200905081404.29868.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:51223 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926AbZEHMRx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 May 2009 08:17:53 -0400
In-Reply-To: <200905081404.29868.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz escreveu:
> On Thursday 07 May 2009 17:33:20 Jo=E3o Ramos wrote:
>  =20
>> Alan Cox escreveu:
>>    =20
>>>> So you're saying I should support all PIO modes? If so, I would ha=
ve to=20
>>>> make conditional code, checking perhaps a module param to sort whi=
ch PIO=20
>>>> mode to use.
>>>>    =20
>>>>        =20
>>> If you advertise PIO0-PIO4 as supported the core IDE code will do a=
ll the
>>> work on figuring which modes are supported by the attached devices.=
 You
>>> just need to be able to set them.
>>>
>>> Alan
>>>  =20
>>>      =20
>> Ok, so I've been studying that (I was quite lost for a time, I confe=
ss,=20
>> I'm not that much familiar with the IDE subsystem, so please bear wi=
th=20
>> me ;-) ).
>>
>> So I need to set up a hook for 'set_pio_mode()', so that when the ID=
E=20
>> subsystem detects a device and figures the most suitable PIO mode fo=
r=20
>> the device, it will call the 'set_pio_mode' routine provided by the=20
>> driver in order to configure the host controller for that PIO mode.
>>
>> This also means that my host controller driver should always default=
 to=20
>> PIO Mode 0, as the initial host controller setup that is carried out=
 by=20
>> the 'init_hwif' routine, allowing devices to be detected. Afterwards=
,=20
>> the IDE subsystem detects the most suitable PIO mode and calls=20
>> 'set_pio_mode' to change that configuration.
>>
>> Am I correct on this?
>>    =20
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

So, I should remove the 'init_hwif' hook, and all the host controller=20
setup would be made in the driver's probe method, correct?

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

Ok, so I will set an struct ide_timing pointer in the 'set_pio_mode'=20
method, which will later be used by my low-level read/write procedures=20
to check the adequate IDE timings.

> Thanks,
> Bart
>
>  =20

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

