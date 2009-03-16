From: Volker Lanz <vl@fidra.de>
Subject: Re: AHCI errors on ICH10 board
Date: Mon, 16 Mar 2009 18:57:19 +0100
Message-ID: <200903161857.19245.vl@fidra.de>
References: <200903161406.01411.vl@fidra.de> <49BE6B06.1040909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from twilight.fidra.de ([88.198.14.164]:44193 "EHLO
	twilight.fidra.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761406AbZCPR5Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Mar 2009 13:57:25 -0400
In-Reply-To: <49BE6B06.1040909@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>

On Montag, 16. M=E4rz 2009 16:06:46 Jeff Garzik wrote:
> Your hardware is telling you that it is seeing CRC errors on the ATA =
bus
> -- which means to say, a hardware problem that causes data transfer o=
ver
> the SATA cable to fail.
>
> Possible sources of problems:  bad SATA cable, bad power supply, bad
> SATA port on device or mainboard, bad mainboard, ...

=46aulty hardware is of course always possible. It's hard to imagine so=
mething=20
is wrong with the hardware in this case, though:

* Both drives are affected, a Samsung and a Seagate. We can rule out th=
e=20
drives.
* Both drives worked in AHCI mode with the same cables and power supply=
 with=20
the ICH9 based Gigabyte board: We can rule out the drives themselves ag=
ain and=20
also the cables.
* Different SATA cables did not help. We can rule out the cables again.
* Unplugging everything in the machine except the drive with the root=20
partition and the video card did not help: We can rule out the power su=
pply (a=20
high quality Tagan 400W model, not some OEM junk) with a near 100%=20
probability, I suppose.

So, all that's left is the mainboard. But on this same machine, AHCI in=
=20
Microsoft Windows XP works without any problem whatsoever. I know the o=
ld=20
Linux-stresses-your-hardware-more-than-Windows tale, but I haven't seen=
 proof=20
of that for 10 years now. This finally seems to rule out the mainboard =
and at=20
least to me it appears the software side is all that is left.

What can I do to diagnose this further short of buying an additional po=
wer=20
supply and mainboard?

Volker

