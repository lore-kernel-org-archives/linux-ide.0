From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Sat, 13 Feb 2010 00:04:10 +0000
Message-ID: <20100213000410.5d58d619@lxorguk.ukuu.org.uk>
References: <4B591D61.8030003@infernix.net>
	<4B593128.1040104@gmail.com>
	<4B59A0CD.4000801@infernix.net>
	<4B5A4F7A.4040709@gmail.com>
	<4B5A5F09.1070300@infernix.net>
	<20100123101457.7f8cbb3f@lxorguk.ukuu.org.uk>
	<4B5AF4DF.4020100@infernix.net>
	<20100123133831.7f24ae95@lxorguk.ukuu.org.uk>
	<4B75E4B2.3070105@infernix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36855 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751568Ab0BMAEW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Feb 2010 19:04:22 -0500
In-Reply-To: <4B75E4B2.3070105@infernix.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: infernix <infernix@infernix.net>
Cc: linux-ide@vger.kernel.org

On Sat, 13 Feb 2010 00:30:58 +0100
infernix <infernix@infernix.net> wrote:

> Hi again,
>=20
> It's been a while because I got a bad set of hard disks to start test=
ing=20
> with, but I'm all set now that I've got new ones. Both the PATA port=20
> with the IDE DOM as well as all the SATA ports are recognised and=20
> working now.
>=20
> PATA_LEGACY Depends on: ATA [=3Dy] && ATA_SFF [=3Dy] && ISA [=3Dn] &&=
=20
> EXPERIMENTAL [=3Dy]                                            =E2=94=
=82
>=20
> To make it work, PATA_LEGACY needs to have the ISA dependancy removed=
=20
> (at least on x86_64). Not sure if that's been committed by anyone yet=
=2E

I have it pending - but its not urgent so with a release pending isn't
going to get pushed in a hurry.

Beyond that I've dug into it with another owner of the same board - the
BIOS has hidden the device. Unfortunately the documentation for the
chipset is quite explicit that while you can hide devices you cannot th=
en
unhide them again.

It might be possible to do something by booting the system in compatibl=
e
mode and beating the controller into AHCI + PATA mode but really what i=
s
needed is a BIOS fix.

Alan
=20
