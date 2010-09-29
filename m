From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Bug#598518: linux-image-2.6-686: ata_piix module loaded before
 ahci module deactivate hotplug support (regression from lenny)
Date: Wed, 29 Sep 2010 23:27:10 +0100
Message-ID: <1285799230.28504.105.camel@localhost>
References: <20100929165034.21331.69639.reportbug@albatros.savanenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-SH9WkzjaDG6an/e/NEd4"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45278 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753188Ab0I2W1V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Sep 2010 18:27:21 -0400
In-Reply-To: <20100929165034.21331.69639.reportbug@albatros.savanenet>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: thomas.debesse+debian@gmail.com, 598518@bugs.debian.org
Cc: linux-ide@vger.kernel.org


--=-SH9WkzjaDG6an/e/NEd4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-09-29 at 18:50 +0200, thomas.debesse+debian@gmail.com
wrote:
[...]
> ICH6 sata controller could be managed by both ata_piix and ahci module bu=
t only
> ahci module handle hotplug.
> At boot time, when ata_piix is loaded before ahci module, it takes contro=
l of
> the ICH6 controller and the ahci module does'nt manage nothing. Because
> ata_piix also manage ICH6 sata controller, hard drives are managed, but b=
ecause
> ata_piix module is used in place of ahci module, because ahci module is'n=
t
> used, hotplug (and other ahci functionnalities indeed) does'nt works.
[...]
> The solution is to load ahci module before ata_piix module, then we can h=
ave
> SATA drives managed by ahci module and IDE drives managed by ata_piix mod=
ule.
[...]

You can force ahci to be loaded first:
1. Add the line 'ahci' to /etc/initramfs-tools/modules.
2. Run 'update-initramfs -u' to regenerate the initramfs.
3. Reboot.

But it seems like it would be better if ahci was automatically
preferred.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-SH9WkzjaDG6an/e/NEd4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUATKO9OOe/yOyVhhEJAQJqLRAAziqE1J9aKlUSUh10qk+cR1k6JcjaqMf5
ee9VAAqpvavwbbRzWacB2rLv2bHR3I7hafsX1neSh6ezgfM1FJ97a/ZPMAOdOP2F
8e8tRViC8Q/lDk2LpJNEI3a4hkc2QjYl5tuHN3jJdZ6/4v/N07H3jDTLVwF1fwEr
ZxWcb1jrOgybxeImh3tmFAiBF8mBdOm8bvsoUZiaI0a8JOqkwnefcrLqqMItuLr+
P/yLB/pHOF2YIQo8K1sG8DKeX3k94rKtTlBIn6WoXeqqW2aDW77bh0oqNaR4EH31
x7MJLTxaHdJ2TmWBiyFCYrWZ541UUQ1OwtRcyRXvyb4QDLuo4n7yOeiP+ZQgCcBg
NPTCYVRoGpAEvlNknUb3/Qdv43jPfNlGj0qTIJzw7GjA9JIIoCPBTi5Leh2uElT8
ori+UqtbNvJxcSpIhSFmIVYBRJVXvJybkaVDV86McKI2f7WUjJvJreo0O3vehQZ/
Ws73cZViF2gpC4zaC4oela99RHACNPdUQz5RJXsIRUkfTuLf/BDbz2UXY7/h740F
8ia4N6oHa47bTUHN3523VyGQ27A9DSWnNsFAPnjSuzU+Gri5qlpOYp7du3LOtKg4
9L2yGdleWsWq0ZpTZEB1XdR7vRBWNgu2A9Q86qrtimS0nMbhFCSr1OaI0dRs0e8c
c250/ESt7/U=
=Dav5
-----END PGP SIGNATURE-----

--=-SH9WkzjaDG6an/e/NEd4--
