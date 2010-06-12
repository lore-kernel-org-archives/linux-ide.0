From: jeanseb <jeanseb.valette@free.fr>
Subject: Re: More ata_piix spurious IRQs
Date: Sat, 12 Jun 2010 19:49:44 +0200
Message-ID: <20100612194944.750682d7@server.gazypan.dyndns.org>
References: <20100611222746.37b5efa6@server.gazypan.dyndns.org>
	<1276298006.14011.149.camel@localhost>
	<4C13C4D5.5080300@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:33781 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab0FLRur convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jun 2010 13:50:47 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 0CD2ED1ACD5
	for <linux-ide@vger.kernel.org>; Sat, 12 Jun 2010 19:50:40 +0200 (CEST)
In-Reply-To: <4C13C4D5.5080300@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, 585556@bugs.debian.org, linux-ide@vger.kernel.org

Hi,
the Drive is recognizes by bios and works (fine enough to install
debian).

thanks

Le Sat, 12 Jun 2010 19:33:09 +0200,
Tejun Heo <tj@kernel.org> a =C3=A9crit :

> Hello, Ben.
>=20
> On 06/12/2010 01:13 AM, Ben Hutchings wrote:
> > (more details at <http://bugs.debian.org/585556>).
> >=20
> > This is in Debian kernel version 2.6.32-15 which is based on stable
> > version 2.6.32.14 but has your backported spurious IRQ handling
> > patch taken from SLE11 (References: bnc#445872, bnc#589449).  Any
> > idea what's going wrong here?  Is there a piece missing from that
> > fix?
>=20
> One great thing about traditional IDE is that the IRQ line is not
> really under the control of the controller so the device can assert
> the IRQ whether the controller want or not and there's nothing much
> the driver can do to prevent runaway IRQs if the device is crazy
> enough (some devices seem to have problem with toggling nIEN for
> example).  Ain't it just great?  :-)
>=20
> As the spurious interrupt handling kicked in, the spurious interrupts
> itself shouldn't cause problem.  It would be polling now, so it's
> likely that the device is asserting interrupt and not responding to
> commands properly.  Does the drive work in other environments?
> e.g. Can the BIOS d  it and boot from it?
>=20
> Thanks.
>=20

