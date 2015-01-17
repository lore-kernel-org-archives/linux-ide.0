From: Mark Brown <broonie@kernel.org>
Subject: Re: [systemd-devel] Making udev emit a signal when it is done
 loading modules
Date: Sat, 17 Jan 2015 14:12:48 +0000
Message-ID: <20150117141248.GD6414@sirena.org.uk>
References: <54BA20D0.7060402@redhat.com>
 <20150117135630.GA25585@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44263 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbbAQONL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jan 2015 09:13:11 -0500
Content-Disposition: inline
In-Reply-To: <20150117135630.GA25585@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Hans de Goede <hdegoede@redhat.com>, systemd-devel@lists.freedesktop.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 17, 2015 at 05:56:30AM -0800, Greg KH wrote:
> On Sat, Jan 17, 2015 at 09:44:00AM +0100, Hans de Goede wrote:

> > If however the ahci_platform driver is a module, then as soon as
> > the kernel is ready to start init, unused regulators are turned off
> > and the disk looses its power while spinning and ends up doing an
> > emergency heads park.

> What turns off the power in this situation?  The kernel?  Or userspace?
> Don't you have control of this?

The kernel turns off the power in late_initcall because it noticed that
nothing is using the regulator, it does this because otherwise we're
just left with whatever the bootloader had which will may well be
wasting power on unused rails due to inflexible PMICs (we do similar
things for other subsystems like clocks).  This works fine for most use
cases since in embedded systems anything critical tends to end up built
in.

There is configurability to allow things to be flagged as always on so
they never get turned off.

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUum3fAAoJECTWi3JdVIfQm+kH/0HUApLmcI7p3Yi6npf1bqH7
sId0i/epl7MsZKUuz0aBPtRs9nuZp1yNBwPaQqbQw/2m8/Sts+OECMXxGZVJ8mNG
wjJscIVE3uVEiBqGp8+SlavcSHREYvQjqFpQNrJQTBtKrECawAvlF7+PS0HD3Ikp
BVE6yrxAx/m5w6XCz5o4pF1YVWvC1CaI8AOcpvP61M1dMJXwR0+KfywJB70Sa2Ih
DQDyUZ9/hdsgQ87sBo8bS2hoF/6YS50UY6lUU/dB6i5vLAVxaCT3V+R8LiDvDr6r
t3yoFYl1Ye/ZcONkgkOt1pmlMh8KCrzb1TanVU3EV8x3r0TjvtwOJoRs7qfaAKQ=
=DvwQ
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
