From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/4] ARM: mvebu: Armada 385 GP: Add regulators to the
 SATA port
Date: Fri, 16 Jan 2015 15:34:51 +0000
Message-ID: <20150116153451.GA3856@sirena.org.uk>
References: <1421330978-9694-1-git-send-email-gregory.clement@free-electrons.com>
 <1421330978-9694-5-git-send-email-gregory.clement@free-electrons.com>
 <54B8C933.7020502@redhat.com>
 <54B8D97B.3090908@free-electrons.com>
 <54B8E38A.6020709@redhat.com>
 <20150116123705.GM3043@sirena.org.uk>
 <54B91FB4.5080707@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54B91FB4.5080707-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 16, 2015 at 03:27:00PM +0100, Gregory CLEMENT wrote:
> On 16/01/2015 13:37, Mark Brown wrote:

> > regulator-always-on is a bit fuzzy for suspend, if the regulator has
> > suspend control it'll kick in - it's really about the Linux refcounting
> > while it's running.  What's more concerning here is that the quick
> > sample of the regulators flagged as always on like the above that I
> > looked at in the patch don't seem to have any enable control in the DT
> > so this will have absolutely no effect.

> Actually the reg_sata[0-4] are controlled by gpio, so there is a mean
> to enable/disable them. For the reg_5v_sata[0-4] and reg_12v_sata[0-4]
> they depend on their respective reg_sata and I just propagated the
> regulator-always-on, this was maybe a mistake.

It certainly makes everything confusing if you have control related
stuff on regulators that are not directly controllable.

> >> It is probably a good idea to use regulator-boot-on and
> >> then test things this way, and if that works use
> >> regulator-boot-on.

> > No, it's unlikely that boot-on makes sense here - it's there for cases
> > where we can't read back the hardware state at power on.  Generally
> > drivers should work regardless of the initial state of the regulator
> > (and modular drivers will actually break if they try to rely on boot-on
> > since we clean up unused regulators at boot).

> As pointed by Hans my concern here was be sure that during boot the disk
> are not power off. In this case which property would be accurate?

None, the core won't do anything with the regulator until the end of
init anyway.

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUuS+aAAoJECTWi3JdVIfQKNgH/iCKWQY2+aKb+dO9noEIqfEE
bbz5hA4zbaLkLmNBkQug7NPlzJa86y5NTSqUp9wJjPhJbdvdeCFubJDCTYfpFsiH
+2xtvzYzkH+yYEcxMZFWs0tRdN02GbYXrAwfVlmI6S/FpNBCXHzSjwzfVQTcHLSA
SQbfMu/SyptuJbWsBQmA7KbKtqm2SRgDrTHDWfOcz50H4SGX1g0ytxUQfUTm3k0a
HAiwoHd356IXVugZ2yJxgUoOQBo35FyucNrM3cHnOPoN8iRjrrv7SjeNgJ6Iq1D4
ldAPiC1hsGvCfd1T+xJzi3ISnuBaQDbqNthUuOsV3DFLEzaG6x8VPnLZ4oYS1MM=
=69LJ
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
