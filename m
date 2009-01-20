From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
 boards
Date: Tue, 20 Jan 2009 12:25:06 +0100
Message-ID: <20090120112506.278840@gmx.net>
References: <3a68e478a75.2662f91@smtp.lizzy.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:44704 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756779AbZATLZJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 06:25:09 -0500
In-Reply-To: <3a68e478a75.2662f91@smtp.lizzy.com.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, benh@kernel.crashing.org


-------- Original-Nachricht --------
> Datum: Mon, 19 Jan 2009 19:28:35 +0100
> Von: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger=
=2Ekernel.org, linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca
> Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for Ami=
gaOne boards

> The following patchset fixes core IDE PCI code to always use
> pci_get_legacy_ide_irq() and ide_pci_is_in_compatibility_mode():
>=20
> http://lkml.org/lkml/2009/1/19/163
>=20
> so via82cxxx specific solution is no longer necessary.
>=20
> [ IOW I'll keep your previous patch and the #ifdef issue will
>   solve itself after the above patchset is merged. ]
Thanks a lot! That's much better than the simple fix I had planned.

Gerhard

--=20
Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt? Der kann`s mit all=
en: http://www.gmx.net/de/go/multimessenger
