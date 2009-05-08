From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Sat, 09 May 2009 01:01:13 +0400
Message-ID: <4A049D99.3050203@ru.mvista.com>
References: <49CCD7C4.8000207@inov.pt>	<200905082002.38487.bzolnier@gmail.com> <4A047718.2000707@inov.pt>	<200905082055.29993.bzolnier@gmail.com> <20090508212457.fxyzi9gk3cw4ksw0@webmail.inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:41460 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756990AbZEHVBS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 May 2009 17:01:18 -0400
In-Reply-To: <20090508212457.fxyzi9gk3cw4ksw0@webmail.inov.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: joao.ramos@inov.pt
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

joao.ramos@inov.pt wrote:

>>> Is this correct? Sorry, has I stated earlier, I'm wasn't familiar w=
ith
>>> the IDE susbsystem untill I wrote this patch; but I'm willing to
>>> contribute in any way I can, so please, bear with me on this :-) .
>>
>> Sure, nobody starts from the expert level and not all maintainers ar=
e
>> into "prove the maintainer wrong" elitist's idiocy. ;)
>>
>>> >
>>> >>>
>>> >>>
>>> >>>> There's just only one issue; normally, I would setup the speci=
fic
>>> >>>> timings (t0, t1, t2, t2i, etc) in the 'pio_set_mode' hook.=20
>>> However, if
>>> >>>> you look further in the driver, those timings aren't defined=20
>>> through a
>>> >>>> memory controller but instead manually enforced by 'ndelay'=20
>>> calls (arghhh).
>>> >>>> This means that in my low-level procedures for reading and=20
>>> writing, I
>>> >>>> need to have access to the timings (or the struct ide_timing)
>>> >>>> corresponding to the PIO mode selected, in order to use the=20
>>> correct delays.
>>> >>>>
>>> >>>> My question is: which is the best way to accomplish this?=20
>>> Declaring a
>>> >>>> global struct ide_timing variable pointer that always holds th=
e=20
>>> correct
>>> >>>> ide_timing struct to the selected PIO mode? Or should I always=
=20
>>> check (in
>>> >>>> some manner) what is the current PIO mode and then select the=20
>>> adequate
>>> >>>> delays?
>>> >>>>
>>> >>>>
>>> >>> I think that the setting variable pointer in ->set_pio_mode=20
>>> method would
>>> >>> work best.  Seems like the existing drive_data field of=20
>>> ide_drive_t is well
>>> >>> suited for this purpose (however it may be worth to convert it=20
>>> to 'void *'
>>> >>> type while we are it).
>>> >>>
>>> >>>
>>> >> Did you mean 'drive_data' field, or 'driver_data' field?
>>> >> 'drive_data' field is an unsigned int value; I guess you meant
>>> >> 'driver_data' field as it is a (void *) field, so I can define i=
t=20
>>> as a
>>> >> pointer to the correct 'struct ide_timing'.
>>> >>
>>> >
>>> > That is why I hinted that you may need to convert 'drive_data' to
>>> > 'void *' type first.  You may also try to use 'driver_data' inste=
ad
>>> > but you will discover rather quickly that you shouldn't do this..=
=2E ;)
>>> >
>>> > 'driver_data' is for use by IDE core and IDE device drivers.
>>> >
>>> > 'drive_data' is for use by IDE host drivers.
>>> >
>>>
>>> And this conversion is made by my driver code, or should I fix dire=
ctly
>>> in the ide_drive_t structure?
>>
>> The latter -- ide_drive_t is the place needing fixing.
>
>
> Same: I will fix that and propose a patch.

   Hey, don't do this please! This is actually a bad idea as some=20
drivers (e.g. sl82c105) use drive_data as an integer entity. Bart, stop=
=20
giving such advices please. :-)

> Regards,
> Jo=E3o Ramos
>
>> Thanks,
>> Bart

WBR, Sergei


