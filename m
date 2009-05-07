From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Thu, 07 May 2009 16:33:20 +0100
Message-ID: <4A02FF40.6090303@inov.pt>
References: <49CCD7C4.8000207@inov.pt>	<49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com>	<49D0CAE4.9090306@inov.pt>	<49D0E687.4040101@ru.mvista.com>	<49FED069.9080501@inov.pt>	<4A002B56.1000802@ru.mvista.com>	<4A019BE4.9020903@inov.pt>	<4A01C376.8000803@ru.mvista.com>	<4A02AB9C.4050107@inov.pt> <20090507145315.3e85b2a8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:51922 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbZEGPes (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 May 2009 11:34:48 -0400
In-Reply-To: <20090507145315.3e85b2a8@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

Alan Cox escreveu:
>> So you're saying I should support all PIO modes? If so, I would have=
 to=20
>> make conditional code, checking perhaps a module param to sort which=
 PIO=20
>> mode to use.
>>    =20
>
> If you advertise PIO0-PIO4 as supported the core IDE code will do all=
 the
> work on figuring which modes are supported by the attached devices. Y=
ou
> just need to be able to set them.
>
> Alan
>  =20

Ok, so I've been studying that (I was quite lost for a time, I confess,=
=20
I'm not that much familiar with the IDE subsystem, so please bear with=20
me ;-) ).

So I need to set up a hook for 'set_pio_mode()', so that when the IDE=20
subsystem detects a device and figures the most suitable PIO mode for=20
the device, it will call the 'set_pio_mode' routine provided by the=20
driver in order to configure the host controller for that PIO mode.

This also means that my host controller driver should always default to=
=20
PIO Mode 0, as the initial host controller setup that is carried out by=
=20
the 'init_hwif' routine, allowing devices to be detected. Afterwards,=20
the IDE subsystem detects the most suitable PIO mode and calls=20
'set_pio_mode' to change that configuration.

Am I correct on this?

There's just only one issue; normally, I would setup the specific=20
timings (t0, t1, t2, t2i, etc) in the 'pio_set_mode' hook. However, if=20
you look further in the driver, those timings aren't defined through a=20
memory controller but instead manually enforced by 'ndelay' calls (argh=
hh).
This means that in my low-level procedures for reading and writing, I=20
need to have access to the timings (or the struct ide_timing)=20
corresponding to the PIO mode selected, in order to use the correct del=
ays.

My question is: which is the best way to accomplish this? Declaring a=20
global struct ide_timing variable pointer that always holds the correct=
=20
ide_timing struct to the selected PIO mode? Or should I always check (i=
n=20
some manner) what is the current PIO mode and then select the adequate=20
delays?

Best regards,
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

