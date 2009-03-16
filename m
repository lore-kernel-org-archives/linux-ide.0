From: Jeff Garzik <jeff@garzik.org>
Subject: Re: AHCI errors on ICH10 board
Date: Mon, 16 Mar 2009 16:40:03 -0400
Message-ID: <49BEB923.6070001@garzik.org>
References: <200903161406.01411.vl@fidra.de> <49BE6B06.1040909@garzik.org> <200903161857.19245.vl@fidra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55720 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758908AbZCPUkJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Mar 2009 16:40:09 -0400
In-Reply-To: <200903161857.19245.vl@fidra.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Lanz <vl@fidra.de>
Cc: linux-ide@vger.kernel.org

Volker Lanz wrote:
> On Montag, 16. M=E4rz 2009 16:06:46 Jeff Garzik wrote:
>> Your hardware is telling you that it is seeing CRC errors on the ATA=
 bus
>> -- which means to say, a hardware problem that causes data transfer =
over
>> the SATA cable to fail.
>>
>> Possible sources of problems:  bad SATA cable, bad power supply, bad
>> SATA port on device or mainboard, bad mainboard, ...
>=20
> Faulty hardware is of course always possible. It's hard to imagine so=
mething=20
> is wrong with the hardware in this case, though:
>=20
> * Both drives are affected, a Samsung and a Seagate. We can rule out =
the=20
> drives.
> * Both drives worked in AHCI mode with the same cables and power supp=
ly with=20
> the ICH9 based Gigabyte board: We can rule out the drives themselves =
again and=20
> also the cables.
> * Different SATA cables did not help. We can rule out the cables agai=
n.
> * Unplugging everything in the machine except the drive with the root=
=20
> partition and the video card did not help: We can rule out the power =
supply (a=20
> high quality Tagan 400W model, not some OEM junk) with a near 100%=20
> probability, I suppose.
>=20
> So, all that's left is the mainboard. But on this same machine, AHCI =
in=20
> Microsoft Windows XP works without any problem whatsoever. I know the=
 old=20

I would double-check that you are using an AHCI driver in XP, since tha=
t=20
is uncommon.  Most XP drivers for AHCI-capable hardware program the SAT=
A=20
device in legacy IDE mode.


> Linux-stresses-your-hardware-more-than-Windows tale, but I haven't se=
en proof=20
> of that for 10 years now. This finally seems to rule out the mainboar=
d and at=20
> least to me it appears the software side is all that is left.

> What can I do to diagnose this further short of buying an additional =
power=20
> supply and mainboard?

Well, the root cause of these errors are CRC errors during transmission=
=20
over the SATA cable.  You can extrapolate from there... it could be=20
heat, poor cable shielding, dirty A/C power, bad RAM, who knows.

Your AHCI chip is telling Linux "hardware CRC error, that I could not=20
recover from" and Linux is dutifully reporting that back to you.=20
Software is unlikely as the cause, considering the volume of AHCI chips=
=20
in users hands versus the volume of bug reports like yours.

Every problem is different, of course, but the standard recommendations=
 are
- trying different SATA ports on the mainboard.  SATA ports are easy to=
=20
break or "fuzz" into uselessness
- replacing cables
- replacing the power supply
- running memtest86 or replacing RAM, etc.
- disabling AHCI mode

Mainboards can definitely go bad, but the above tends to be of more hel=
p.

	Jeff



