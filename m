From: Tyler <pml@dtbb.net>
Subject: Re: IDENTIFY DEVICE not working any more?
Date: Mon, 15 Aug 2005 06:33:01 -0700
Message-ID: <4300998D.6000205@dtbb.net>
References: <43005B4D.1090801@conterra.de> <1124102095.8189.45.camel@localhost.localdomain> <43009642.40805@conterra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tor.primus.ca ([216.254.136.21]:41348 "EHLO
	smtp-04.primus.ca") by vger.kernel.org with ESMTP id S932507AbVHONa7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Aug 2005 09:30:59 -0400
In-Reply-To: <43009642.40805@conterra.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>

Were the 2.6.11 kernels you have included with a distribution such as=20
ubuntu, fedora, etc?  If it was, there's a good chance that it has the=20
passthru libata patch, that allows you to access drives using smartctl,=
=20
with the special ata flag.

Tyler.

Dieter St=FCken wrote:

> Erik Slagter wrote:
>
>> On Mon, 2005-08-15 at 11:07 +0200, Dieter St=FCken wrote:
>>
>>> I used smartmontools for sata devices quite successfully awhile.
>>> Since 2.6.12.2 however, I get an ioerror on "DENTIFY DEVICE"
>>> errno=3D25 [Inappropriate ioctl for device] and smartctl gives up.
>>
>>
>> Over here it works fine (sata_promise driver + 2.6.12.3 +
>> smartmontools).
>>
>> Also afaik the .1/.2/.3 patches did not contain changes to the libat=
a or
>> scsi layer.
>
>
> strange. I Have written a tiny test with: rc =3D ioctl(fd,=20
> HDIO_GET_IDENTITY, &id);
> and definitely got: "/dev/sda: Inappropriate ioctl for device" with=20
> 2.6.12.2.
> I did not test any other 2.6.12.x, but it works fine for an other=20
> 2.6.11 system.
>
> Unfortunalely I can't install an other kernel today, as all my system=
s=20
> are in
> production. Is there any new kernel config I missed? The only=20
> difference ist,
> that my 2.6.12 system is a x86_64, where as the 2.6.11 system is an i=
686.
> I'll try some constellations later at home, where I have an other=20
> x86_64 system.
>
> Dieter.



--=20
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.338 / Virus Database: 267.10.8/71 - Release Date: 8/12/200=
5

