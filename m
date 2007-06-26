From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA update in 2.4, ICH8
Date: Tue, 26 Jun 2007 09:37:10 -0400
Message-ID: <46811686.6050408@garzik.org>
References: <87y7idiwjd.fsf@naruto.ifr.lan> <20070621182119.GB26637@1wt.eu> <87myysfqo4.fsf@naruto.ifr.lan> <20070622191344.GB3629@1wt.eu> <87sl8ge9uw.fsf@naruto.ifr.lan> <20070626120904.GD23524@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59319 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780AbXFZNhP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jun 2007 09:37:15 -0400
In-Reply-To: <20070626120904.GD23524@1wt.eu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: Vincent Bernat <Vincent.Bernat@wallix.com>, linux-ide@vger.kernel.org, JF Taltavull <jean-francois.taltavull@wallix.com>

Willy Tarreau wrote:
> On Mon, Jun 25, 2007 at 10:06:47AM +0200, Vincent Bernat wrote:
>> OoO En  ce d=E9but de soir=E9e du  vendredi 22 juin 2007,  vers 21:1=
3, Willy
>> Tarreau <w@1wt.eu> disait:
>>
>>>> This is a SATA CDROM. There is no PATA controller on the motherboa=
rd.
>>> I've never tested any SATA CDROM yet. I don't even know if they wor=
k with
>>> 2.4 libata. So most likely you have more experience than me in this=
 area.
>>> If you have any other SATA controller on another machine on which y=
ou would
>>> test the drive, it could help up determine whether it's the CDROM w=
hich is
>>> causing the trouble or this specific controller+driver combination.
>> With an ICH7 controller, CDROM is not working.
>=20
> OK, so the problem is not specific to your change, but rather to the =
driver or
> something else. I have nothing against merging your PCI id update in =
principle.
> I also have another minor SATA update pending.
>=20
> Jeff, if you have any objection, it's the moment !

Any chance you could email me what is pending?

	Jeff



