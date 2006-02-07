From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Subject: Re: libata-core and pccard CF card reader
Date: Tue, 7 Feb 2006 22:17:16 +0100
Message-ID: <20060207211716.GA12185@localhost>
References: <20060206221923.GA12063@localhost> <1139266210.10437.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp13.wanadoo.fr ([193.252.22.54]:38185 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S965179AbWBGVSg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Feb 2006 16:18:36 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1303.wanadoo.fr (SMTP Server) with ESMTP id A5A7E700009A
	for <linux-ide@vger.kernel.org>; Tue,  7 Feb 2006 22:18:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1139266210.10437.56.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, Mark Lord <lkml@rtr.ca>

On Mon, Feb 06, 2006 at 10:50:09PM +0000, Alan Cox wrote:
> 848A is CFA from memory. Probably it should be tested for and treated
> either as disk, or quite possibly a new class.
>=20
> > [...]
>=20
> Yes it has its own spec which is ATA plus other bits.
>=20
> > [...]
>=20
> I think you want to add an "is_cfa" type macro and check it too

Looking at your latest libata / ide patches, you've done just that,
thanks. I'll keep working on the rest!
--=20
Mathieu Chouquet-Stringer                           mchouque@free.fr
    "Le disparu, si l'on v=E9n=E8re sa m=E9moire, est plus pr=E9sent et
                 plus puissant que le vivant".
           -- Antoine de Saint-Exup=E9ry, Citadelle --

