From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device driver
Date: Wed, 28 Nov 2007 18:49:04 +0300
Message-ID: <20071128154904.GA20722@localhost.localdomain>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153908.GB14183@localhost.localdomain> <20071127212222.GB10829@lixom.net> <200711272233.00456.arnd@arndb.de>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:9970 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752930AbXK1PoT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 10:44:19 -0500
Content-Disposition: inline
In-Reply-To: <200711272233.00456.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org

On Tue, Nov 27, 2007 at 10:32:58PM +0100, Arnd Bergmann wrote:
> On Tuesday 27 November 2007, Olof Johansson wrote:
> > On Tue, Nov 27, 2007 at 06:39:08PM +0300, Anton Vorontsov wrote:
> > > This driver nicely wraps around pata_platform library functions,
> > > and provides OF platform bus bindings to the PATA devices.
> >=20
> > > +static struct of_device_id pata_of_platform_match[] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "pata-platform",=
 },
> > > +};
> >=20
> > "pata-platform" really means nothing outside of linux. A more
> > generic label would be useful.

Agreed.

> Maybe the name of the standards it supports? Could be
> "ata-4", "ata-5" and the like, or the exact transfer mode, like
> "pata-udma-5", "pata-pio-3", "sata-150", etc.

You're quite optimistic about pata_platform capabilities. ;-)

As far as I know it is [obviously] supports PIO modes only. And so
far I was able to get max 5.28 MB/s read transfers. Which looks like
ideal case for PIO1 (CF I'm testing on is 3.0, max. PIO4).

I've modified pio_mask appropriately, plus I've tried to comment
out .set_mode =3D pata_platform_set_mode, and now it says:

ata5: PATA max PIO4 mmio cmd 0xf0000000 ctl 0xf000020c irq 24
ata5.00: CFA: TOSHIBA THNCF512MQG, 3.00, max PIO4
ata5.00: configured for PIO4
ata5.00: configured for PIO4

That looks good, but speed is the same. Oh well, it's another
matter.


Back to dts, I think pata-pio-X is good scheme. That way we can
pass pio_mask via device tree. Sounds reasonable?

--=20
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
