From: Tyler <pml@dtbb.net>
Subject: Re: read vs write
Date: Mon, 25 Jul 2005 05:34:05 -0700
Message-ID: <42E4DC3D.1050900@dtbb.net>
References: <d15adc960507250314ec47755@mail.gmail.com>	 <42E4BFC1.7070905@stesmi.com> <d15adc960507250440510efd58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound04.telus.net ([199.185.220.223]:16572 "EHLO
	priv-edtnes27.telusplanet.net") by vger.kernel.org with ESMTP
	id S261158AbVGYMeG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jul 2005 08:34:06 -0400
In-Reply-To: <d15adc960507250440510efd58@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saswat Praharaj <saswat@gmail.com>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, linux-ide@vger.kernel.org

My only suggestion would be to do some research using google.

a) 100MB/sec is an interface specification, anotherwords, the bus it=20
sits on, can do 100MB/sec.  Take into account the fact that you may hav=
e=20
more than one hard drive on the same bus, and you soon figure out why=20
maxtor felt 133MB/sec may be useful, now that there are drives that can=
=20
do over 50MB/sec, multiply that by 2, and you are at or above the=20
100MB/sec bus rating.  The PCI bus itself (the bus the IDE interface=20
attaches to and transfers across to the CPU), in 32bit, 33mhz form only=
=20
has a theoretical limit of 133MB/sec itself.

b) I'm guessing your processor is holding you back, or the chipset, or=20
the chipset drivers, or any combination therein.  My first test would b=
e=20
to put the drive in a faster system.  Yes, I know your read speed was=20
higher, but reads *tend* to be higher to begin with.  Thinking about=20
this again, and after reading the page i posted below, I would say you=20
are already hitting the drives limits, even without hitting a=20
motherboard/cpu limit, other than possibly the burst speed, which may b=
e=20
slightly higher on an ata100 controller.

c) Here is possibly a better example than the highway:  You buy a new=20
car off the lot these days, and it comes with tires, that are *capable*=
=20
of 150mph continuosly... does that mean automatically mean your car is=20
capable of running that fast? no.  If you put 4 inch exhaust on your=20
vehicle, does that mean your engine will be able to flow at a rate=20
and/or pressure that can take full advantage of the 4 inch exhaust=20
systems capacity?  no.  Your speedometer goes to 160mph, does that mean=
=20
your car goes that fast? no.

and as a side note, 25MB/sec on a 400mhz machine, is an excellent speed=
,=20
as is 58mb/sec read speed.  I would stop complaining or looking for=20
something to blame, and realize the hardware is at its limits.  I=20
actually doubt that your barracuda drive is doing 58mb/sec, other than=20
possibly burst transfers.

try googling a little bit, and find reviews and information such as thi=
s=20
page:=20
http://www.xbitlabs.com/articles/storage/display/seagate-barracuda-ata4=
=2Ehtml

Regards,
Tyler.

Saswat Praharaj wrote:

>yups I meant MBps ..thanks for correcting me .
>
>However, I dont agree with your ford/road example.
>
>I just checked the product specification of STA340016A (seagate) .=20
>
>Here is what they claim :=20
>
>[  This manual describes the functional, mechanical and interface spec=
ifi-
>cations for the ST380021A, ST360021A, ST340016A and ST320011A.
>These drives provide the following key features:
>=B7 7,200-RPM spindle speed and 2-Mbyte buffer combine for superior
>  desktop performance
>=B7 High instantaneous (burst) data-transfer rates (up to 100 Mbytes p=
er
>  second) using Ultra DMA mode 5 ]
>
>I have found average seek time is little faster (around 1ms) for read
>than write.
>Still that doesn't justify the write speed of 15-20 MBps and 55-60
>MBps for read.
>
>Can anyone help me understading how/why write is different than read.
>
>Thanks and Regards,
>Saswat
>
>On 7/25/05, Stefan Smietanowski <stesmi@stesmi.com> wrote:
> =20
>
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Hi Saswat.
>>
>>   =20
>>
>>>Moreover, I am wondering if I could achieve the 100Mbps read speed a=
s
>>>claimed by different vendors.For me , It should ideally be 100 Mbps =
as
>>>I am using a 80 conductor cable and UDMA 5.Why then I am getting 58
>>>Mbps max . .
>>>     =20
>>>
>>If you mean Mbps then you are already above it. 100Mbps =3D 12.5MB/s
>>give or take and both speeds are above that.
>>I guess you probably mean 100MB/s though and that is only what
>>the cable can take.
>>
>>If you take a T-ford onto the highway - can you go 130Km/h in it?
>>
>>No, the road is rated at 130Km/s but the car can't go that fast.
>>
>>Same here, the standard says you can transfer 100MB/s over the cable
>>but the disk isn't fast enough to be able to transfer that fast.
>>
>>// Stefan
>>-----BEGIN PGP SIGNATURE-----
>>Version: GnuPG v1.4.1 (MingW32)
>>
>>iD8DBQFC5L/BBrn2kJu9P78RAkXKAJ4vc/xQ0Z8mA1ddo79+wC6NCFe5VACgl+j+
>>ceP+as8dx0uZs2W6xaYiMVc=3D
>>=3DOf1/
>>-----END PGP SIGNATURE-----
>>
>>   =20
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" i=
n
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> =20
>
