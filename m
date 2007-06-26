From: Willy Tarreau <w@1wt.eu>
Subject: Re: SATA update in 2.4, ICH8
Date: Tue, 26 Jun 2007 14:09:04 +0200
Message-ID: <20070626120904.GD23524@1wt.eu>
References: <87y7idiwjd.fsf@naruto.ifr.lan> <20070621182119.GB26637@1wt.eu> <87myysfqo4.fsf@naruto.ifr.lan> <20070622191344.GB3629@1wt.eu> <87sl8ge9uw.fsf@naruto.ifr.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:3170 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbXFZMJM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jun 2007 08:09:12 -0400
Content-Disposition: inline
In-Reply-To: <87sl8ge9uw.fsf@naruto.ifr.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincent Bernat <Vincent.Bernat@wallix.com>
Cc: linux-ide@vger.kernel.org, JF Taltavull <jean-francois.taltavull@wallix.com>, Jeff Garzik <jeff@garzik.org>

On Mon, Jun 25, 2007 at 10:06:47AM +0200, Vincent Bernat wrote:
> OoO En  ce d=E9but de soir=E9e du  vendredi 22 juin 2007,  vers 21:13=
, Willy
> Tarreau <w@1wt.eu> disait:
>=20
> >> This is a SATA CDROM. There is no PATA controller on the motherboa=
rd.
>=20
> > I've never tested any SATA CDROM yet. I don't even know if they wor=
k with
> > 2.4 libata. So most likely you have more experience than me in this=
 area.
> > If you have any other SATA controller on another machine on which y=
ou would
> > test the drive, it could help up determine whether it's the CDROM w=
hich is
> > causing the trouble or this specific controller+driver combination.
>=20
> With an ICH7 controller, CDROM is not working.

OK, so the problem is not specific to your change, but rather to the dr=
iver or
something else. I have nothing against merging your PCI id update in pr=
inciple.
I also have another minor SATA update pending.

Jeff, if you have any objection, it's the moment !

Thanks,
Willy

