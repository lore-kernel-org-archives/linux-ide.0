From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 08 May 2009 19:16:56 +0100
Message-ID: <4A047718.2000707@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <200905081404.29868.bzolnier@gmail.com> <4A046BB6.6060806@inov.pt> <200905082002.38487.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:35026 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140AbZEHSRf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 May 2009 14:17:35 -0400
In-Reply-To: <200905082002.38487.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz escreveu:
> On Friday 08 May 2009 19:28:22 Jo=E3o Ramos wrote:
>  =20
>>> Yes! :)
>>>
>>> There is still a room for improvement though -- it would be better =
to fix
>>> IDE core to set PIO0 before probing devices for all host controller=
s.
>>>
>>> Moreover it seems that doing it this way would allow us to remove -=
>init_hwif
>>> method from this driver and do all necessary setup in ep93xx_ide_pr=
obe()
>>> (this controller is a single port one so theoretically there should=
n't be
>>> a need for having per-port ->init_hwif implementation).
>>>  =20
>>>      =20
>> So after all this discussion ;-) , my driver will have no 'init_hwif=
'=20
>> method, and the setup code will be on 'ep93xx_ide_probe', which will=
=20
>> configure entirely the IDE host controller.
>> Moreover, this initial configuration will setup the controller to wo=
rk=20
>> at PIO Mode 0. Later on, the 'set_pio_mode' method will be called an=
d=20
>> the controller will configure itself according to the PIO mode repor=
ted=20
>> by the IDE core.
>>
>> Can I proceed this way?
>>    =20
>
> Well, yes.  Though I hoped that you would at least give a try to fixi=
ng
> IDE core to program PIO0 initially for all host drivers that implemen=
t
> ->set_pio_mode method...
>  =20

Sorry, I didn't noticed your hint... Sure, I can give it a try ;-)
Maybe with a little help, but I can try. You mean, when the host driver=
=20
is registered (ide_host_register, or ide_host_add that later calls=20
ide_host_register), maybe in the 'ide_init_port' method (sorry, I need=20
some guidance here...) check if the 'set_pio_mode' method is=20
implemented, and after initializing each port (d->init_hwif(hwif))=20
default it to PIO Mode 0, calling set_pio_mode method.

Is this correct? Sorry, has I stated earlier, I'm wasn't familiar with=20
the IDE susbsystem untill I wrote this patch; but I'm willing to=20
contribute in any way I can, so please, bear with me on this :-) .

>  =20
>>>  =20
>>>      =20
>>>> There's just only one issue; normally, I would setup the specific=20
>>>> timings (t0, t1, t2, t2i, etc) in the 'pio_set_mode' hook. However=
, if=20
>>>> you look further in the driver, those timings aren't defined throu=
gh a=20
>>>> memory controller but instead manually enforced by 'ndelay' calls =
(arghhh).
>>>> This means that in my low-level procedures for reading and writing=
, I=20
>>>> need to have access to the timings (or the struct ide_timing)=20
>>>> corresponding to the PIO mode selected, in order to use the correc=
t delays.
>>>>
>>>> My question is: which is the best way to accomplish this? Declarin=
g a=20
>>>> global struct ide_timing variable pointer that always holds the co=
rrect=20
>>>> ide_timing struct to the selected PIO mode? Or should I always che=
ck (in=20
>>>> some manner) what is the current PIO mode and then select the adeq=
uate=20
>>>> delays?
>>>>    =20
>>>>        =20
>>> I think that the setting variable pointer in ->set_pio_mode method =
would
>>> work best.  Seems like the existing drive_data field of ide_drive_t=
 is well
>>> suited for this purpose (however it may be worth to convert it to '=
void *'
>>> type while we are it).
>>>  =20
>>>      =20
>> Did you mean 'drive_data' field, or 'driver_data' field?
>> 'drive_data' field is an unsigned int value; I guess you meant=20
>> 'driver_data' field as it is a (void *) field, so I can define it as=
 a=20
>> pointer to the correct 'struct ide_timing'.
>>    =20
>
> That is why I hinted that you may need to convert 'drive_data' to
> 'void *' type first.  You may also try to use 'driver_data' instead
> but you will discover rather quickly that you shouldn't do this... ;)
>
> 'driver_data' is for use by IDE core and IDE device drivers.
>
> 'drive_data' is for use by IDE host drivers.
>  =20

And this conversion is made by my driver code, or should I fix directly=
=20
in the ide_drive_t structure?

Regards,
Jo=E3o Ramos

> Thanks,
> Bart
>
>  =20


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

