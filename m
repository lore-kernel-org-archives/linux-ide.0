From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Sat, 23 Jan 2010 13:38:31 +0000
Message-ID: <20100123133831.7f24ae95@lxorguk.ukuu.org.uk>
References: <4B591D61.8030003@infernix.net>
	<4B593128.1040104@gmail.com>
	<4B59A0CD.4000801@infernix.net>
	<4B5A4F7A.4040709@gmail.com>
	<4B5A5F09.1070300@infernix.net>
	<20100123101457.7f8cbb3f@lxorguk.ukuu.org.uk>
	<4B5AF4DF.4020100@infernix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40935 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932068Ab0AWNgb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jan 2010 08:36:31 -0500
In-Reply-To: <4B5AF4DF.4020100@infernix.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: infernix <infernix@infernix.net>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

> PATA_LEGACY Depends on: ATA [=3Dy] && ATA_SFF [=3Dy] && ISA [=3Dn] &&=
=20
> EXPERIMENTAL [=3Dy]                                            =E2=94=
=82
>=20
> So I have to turn on ISA for it to build. But that's not possible on=20
> x86_64 because it depends on X86_32. I'll try a 32bit build later, bu=
t=20
> I'd really like to be able to stay on x86_64. Is there a workaround?

Remove the && ISA in Kconfig - that's bogus.

> Maybe I didn't make this clear enough, but the IDE DOM is not integra=
ted=20
> in the NAS. I bought it afterwards and inserted it in the PATA port. =
I=20
> can just swap it for a 2.5" or 3.5" PATA harddisk if I want to.

Ok - well the PATA port seems not to be wired to the ICH. You could try
enabling the PATA port and seeing what happens I guess.

> Also, in both compatible and enhanced mode, the BIOS has no problem=20
> booting off the PATA port (with the IDE DOM that i bought).

That I would expect - most BIOSes just use the legacy 0x170/0x1F0
interfaces and polled I/O. They don't care what the logic being driven =
is.

> That would make me think it's actually wired to the ICH. Maybe also t=
o=20
> the LPC bus but I'm not knowledgeable enough to know if thats even po=
ssible.

I'm not sure what occurs if you set up the address decode on the ICH fo=
r
the port and then hide it. Seems a strange thing to do but it might be
the case, and if so we can probably add a Linux quirk based on the DMI
data to unhide it.
