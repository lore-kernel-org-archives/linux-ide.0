From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
 boards
Date: Tue, 13 Jan 2009 00:39:09 +0100
Message-ID: <20090112233909.221080@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:32973 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751316AbZALXjL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jan 2009 18:39:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org


-------- Original-Nachricht --------
> Datum: Mon, 12 Jan 2009 18:55:55 +0100
> Von: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, grant.likely@=
secretlab.ca
> Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for Ami=
gaOne boards

> > > checking if IDE_HFLAG_FORCE_LEGACY_IRQS should be set.
> > Wouldn't it be better, if I clean this up now? (I have to resend my
> > AmigaOne platform patches anyway).
>=20
> Replacement patch instead of incremental one is also fine with me -- =
given
> that it can wait for 2.6.30.
Yes, it can wait.
Although I would like to know from the powerpc maintainer, if my platfo=
rm
patches could still go in 2.6.29, if I resend them in the next days? I =
guess it's
too late, right?

> > Okay, so the change shouldn't break IDE for Pegasos machines (I don=
't
> > have a Pegasos for testing).
>=20
> Yes but there may be some other platforms (not necessarily powerpc on=
es)
> that may be affected (i.e. they can depend indirectly on IRQ auto-pro=
bing
> during IDE probe) so cleanup patch needs to spend some time in linux-=
next.
I think the VIA libata driver simply checks the progif register, too. I=
 guess you
don't like the idea of a "#ifdef PPC32" or so around the
ide_pci_is_in_compatibility_mode() check?

Thanks!

Gerhard

--=20
Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt? Der kann`s mit all=
en: http://www.gmx.net/de/go/multimessenger
