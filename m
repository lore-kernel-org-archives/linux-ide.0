From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: kernel 2.6.31.1 + Sil 3512 + WDC WD5000AAKS-00V1A0 = no NCQ and
	UDMA5 instead of UDMA6
Date: Thu, 17 Dec 2009 23:00:16 -0600
Message-ID: <51f3faa70912172100p103e7698ne8a4216fe6471634@mail.gmail.com>
References: <4B2A3D25.9030209@hardwarefreak.com> <4B2A720B.2040809@pobox.com>
	 <4B2AE779.9060109@hardwarefreak.com> <4B2AF2C2.9010708@pobox.com>
	 <4B2AFBDD.30601@hardwarefreak.com> <4B2AFF7B.4000007@gmail.com>
	 <4B2B0642.3010501@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:58486 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbZLRFAR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2009 00:00:17 -0500
Received: by iwn1 with SMTP id 1so1955920iwn.33
        for <linux-ide@vger.kernel.org>; Thu, 17 Dec 2009 21:00:16 -0800 (PST)
In-Reply-To: <4B2B0642.3010501@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stan Hoeppner <stan@hardwarefreak.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Thu, Dec 17, 2009 at 10:34 PM, Stan Hoeppner <stan@hardwarefreak.com=
> wrote:
> Robert Hancock put forth on 12/17/2009 10:05 PM:
>> On 12/17/2009 09:49 PM, Stan Hoeppner wrote:
>>> Jeff Garzik put forth on 12/17/2009 9:10 PM:
>>>
>>>> Nope. =A0You are pretty much maxing out the drive, of whatever dri=
ve you
>>>> plug in. =A0The sata bus -- at its hardware spec'd maximum -- is f=
ar
>>>> faster than just about any drive, and the PCI bus is far faster th=
an the
>>>> sata bus.
>>>
>>> I'm on the old 32bit/33MHz PCI bus of 133MB/s. =A0SATA1 at 150MB/s =
is
>>> slightly faster, no? =A0No argument here that both are far faster t=
han
>>> almost all drives on the market. =A0I was just wondering if bumping=
 up
>>> from the default UDMA/100 to UDMA/133 would allow quicker PCI bus
>>> bursting and thus a slight improvement in overall performance.
>>
>> The UDMA speed doesn't make any difference at all with SATA, it's ju=
st
>> an arbitrary number in almost all cases. Only the link speed really
>> matters (which with these controllers will always be 1.5 Gbps).
>
> Hi Robert. =A0Thanks for your informed reply.
>
> So, how does this "phantom" UDMA setting affect either libata or
> sata_sil? =A0If it effects nothing, why is it hanging around? =A0Is t=
his a
> backward compatibility thing for the kernel's benefit? =A0I'm not a k=
ernel
> hacker or programmer (yet), so please forgive my ignorant questions.

It doesn't affect either the driver or the controller. Only the drive
may possibly care - that would be if there's a SATA-to-PATA bridge
involved (as some early SATA drives had internally, for example) and
there's an actual PATA bus that needs to be programmed properly for
speed. Other than that, it's basically vestigial.

>
>>> I think I only gave $15 for this Koutech Sil3512 PCI (32/33) contro=
ller
>>> at Newegg. =A0You being you with the knowledge you have, would buyi=
ng one
>>> of the cards whose chipset supports NCQ, such as the sata_sil24 car=
ds,
>>> be anything close to worth the additional investment in dollars and=
 time
>>> spent swapping hardware and drivers? =A0Is NCQ the performance pana=
cea
>>> that some purport it to be? =A0How much difference does it really m=
ake?
>>
>> It's really hard to say, it depends on the drive and the workload, i=
n
>> most cases..
>
> On this particular machine, the greatest disk loading will be running
> hdparm and other benchmarks. =A0Its real world workloads are modest, =
disk
> and otherwise (though that may change). =A0If NCQ's greatest benefit =
comes
> into play with multithreaded or multiuser workloads, then it would
> probably not benefit this machine's real world performance much. =A0U=
nless
> NCQ pumps up benchy numbers, which gives the machine owner a
> psychological boost, if nothing else. ;) =A0(feels guilt)

In my experience, you get a little bit more performance with hdparm,
etc. with NCQ enabled. But that depends on the drive implementation a
lot - if it's poorly optimized for NCQ you can see a slowdown.

It's true the biggest benefits tend to be with multithreaded
workloads, but even single-threaded workloads can get broken down by
the kernel into multiple parallel requests.

>
> Thanks for continuing to educate me folks. =A0It's so difficult to fi=
nd
> "under the hood" linux sata information of this type via Google. =A0A=
ll I
> find are benchy results and accounts of personal experience, but not =
any
> "this is why this works this way" info.
>
> Please continue my education a bit more. =A0I'm trying not to be a pe=
st,
> but this stuff is fascinating to me, and more knowledge is always a g=
ood
> thing, no?
>
> --
> Stan
>
