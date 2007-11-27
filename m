From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device driver
Date: Tue, 27 Nov 2007 22:32:58 +0100
Message-ID: <200711272233.00456.arnd@arndb.de>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153908.GB14183@localhost.localdomain> <20071127212222.GB10829@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59641 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758374AbXK0Vdr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 16:33:47 -0500
In-Reply-To: <20071127212222.GB10829@lixom.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: Olof Johansson <olof@lixom.net>, Anton Vorontsov <avorontsov@ru.mvista.com>, linux-ide@vger.kernel.org

On Tuesday 27 November 2007, Olof Johansson wrote:
> On Tue, Nov 27, 2007 at 06:39:08PM +0300, Anton Vorontsov wrote:
> > This driver nicely wraps around pata_platform library functions,
> > and provides OF platform bus bindings to the PATA devices.
>=20
> > +static struct of_device_id pata_of_platform_match[] =3D {
> > +=A0=A0=A0=A0=A0{ .compatible =3D "pata-platform", },
> > +};
>=20
> "pata-platform" really means nothing outside of linux. A more
> generic label would be useful.

Maybe the name of the standards it supports? Could be
"ata-4", "ata-5" and the like, or the exact transfer mode, like
"pata-udma-5", "pata-pio-3", "sata-150", etc.

	Arnd <><
