From: Vincent Bernat <Vincent.Bernat@wallix.com>
Subject: Re: SATA update in 2.4, ICH8
Date: Mon, 25 Jun 2007 10:06:47 +0200
Message-ID: <87sl8ge9uw.fsf@naruto.ifr.lan>
References: <87y7idiwjd.fsf@naruto.ifr.lan> <20070621182119.GB26637@1wt.eu>
	<87myysfqo4.fsf@naruto.ifr.lan> <20070622191344.GB3629@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.wallix.com ([212.43.221.50]:36045 "EHLO postman.wallix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbXFYJM3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jun 2007 05:12:29 -0400
In-Reply-To: <20070622191344.GB3629@1wt.eu> (Willy Tarreau's message of "Fri,
	22 Jun 2007 21:13:44 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: linux-ide@vger.kernel.org, JF Taltavull <jean-francois.taltavull@wallix.com>, Jeff Garzik <jeff@garzik.org>

OoO En  ce d=E9but de soir=E9e du  vendredi 22 juin 2007,  vers 21:13, =
Willy
Tarreau <w@1wt.eu> disait:

>> This is a SATA CDROM. There is no PATA controller on the motherboard=
=2E

> I've never tested any SATA CDROM yet. I don't even know if they work =
with
> 2.4 libata. So most likely you have more experience than me in this a=
rea.
> If you have any other SATA controller on another machine on which you=
 would
> test the drive, it could help up determine whether it's the CDROM whi=
ch is
> causing the trouble or this specific controller+driver combination.

With an ICH7 controller, CDROM is not working.
--=20
Vincent Bernat
118 rue de Tocqueville, 75017 Paris
Tel: +33 1 53 42 12 86
http://www.wallix.com
