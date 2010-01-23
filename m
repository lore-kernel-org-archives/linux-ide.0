From: infernix <infernix@infernix.net>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Sat, 23 Jan 2010 14:08:47 +0100
Message-ID: <4B5AF4DF.4020100@infernix.net>
References: <4B591D61.8030003@infernix.net>	<4B593128.1040104@gmail.com>	<4B59A0CD.4000801@infernix.net>	<4B5A4F7A.4040709@gmail.com>	<4B5A5F09.1070300@infernix.net> <20100123101457.7f8cbb3f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dx.infernix.net ([83.96.151.193]:58102 "EHLO dx.infernix.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233Ab0AWNIy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jan 2010 08:08:54 -0500
In-Reply-To: <20100123101457.7f8cbb3f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On 23/01/10 11:14, Alan Cox wrote:
>> Can we force ata_piix to pick up the IDE controller? I mean the old =
IDE
>> PIIX driver can do it (albeit terribly slow), so why can't ata_piix?=
 I
>
> I doubt PIIX is doing it - the legacy IDE bits are.

You're right:

[    1.606687] Uniform Multi-Platform E-IDE driver
[    1.611276] ide_generic: please use "probe_mask=3D0x3f" module=20
parameter for probing all legacy ISA IDE ports
[    1.908275] hda: TRANSCEND, CFA DISK drive
[    2.584069] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    3.156052] ide1 at 0x170-0x177,0x376 on irq 15

> What I think is going on is this (and I don't have docs so I am guess=
ing)
>
> 	- The SOHO NAS has the IDE DOM wired to the LPC bus somewhere
> 	  directly (as legacy IDE)
> 	- The PATA port is intentionally disabled by the firmware to make
> 	  room for the DOM.
>
> In which case loading "pata_legacy" ought to make the right magic occ=
ur.

PATA_LEGACY Depends on: ATA [=3Dy] && ATA_SFF [=3Dy] && ISA [=3Dn] &&=20
EXPERIMENTAL [=3Dy]                                            =E2=94=82

So I have to turn on ISA for it to build. But that's not possible on=20
x86_64 because it depends on X86_32. I'll try a 32bit build later, but=20
I'd really like to be able to stay on x86_64. Is there a workaround?

> If that is the case I suspect the PIIX PATA port is not used at all
> by the sytstem (is it even wired to pins anywhere ?). If it is used t=
hen
> presumably the original NAS firmware does something truely hideous al=
ong
> the lines of
>
> -	Load boot image from DOM
> -	Turn off DOM/on PIIX
> -	Start using PIIX

Maybe I didn't make this clear enough, but the IDE DOM is not integrate=
d=20
in the NAS. I bought it afterwards and inserted it in the PATA port. I=20
can just swap it for a 2.5" or 3.5" PATA harddisk if I want to.

Also, in both compatible and enhanced mode, the BIOS has no problem=20
booting off the PATA port (with the IDE DOM that i bought). So I guess=20
the bios may play some tricks here but when I boot off the PATA port in=
=20
compatible mode, ata_piix is used to access the PATA port, and all is=20
well with the world (except that I lose 2 SATA ports in compatible mode=
).

That would make me think it's actually wired to the ICH. Maybe also to=20
the LPC bus but I'm not knowledgeable enough to know if thats even poss=
ible.
