From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/4] ARM: mvebu: Armada 385 GP: Add regulators to the
 SATA port
Date: Sun, 18 Jan 2015 12:35:31 +0000
Message-ID: <20150118123531.GA2809@sirena.org.uk>
References: <1421330978-9694-5-git-send-email-gregory.clement@free-electrons.com>
 <54B8C933.7020502@redhat.com>
 <54B8D97B.3090908@free-electrons.com>
 <54B8E38A.6020709@redhat.com>
 <20150116123705.GM3043@sirena.org.uk>
 <54B9629C.9090800@redhat.com>
 <20150116202516.GL3856@sirena.org.uk>
 <54BA21F9.5050408@redhat.com>
 <20150117131404.GA6414@sirena.org.uk>
 <54BA7197.40301@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54BA7197.40301-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 17, 2015 at 03:28:39PM +0100, Hans de Goede wrote:
> On 17-01-15 14:14, Mark Brown wrote:

> >Following your argument to the logical conclusion means we can never
> >turn any regualtor off - we always have the risk that there's another
> >shared user which is going to get a power bounce if we power down.  More
> >directly we'll also get people complaining that we're burning power
> >pointlessly on their systems for devices they've not even got drivers
> >enabled for.  This powering down is something there's been user demand
> >for.

> Right, note I'm only advocating to not turn off regulators marked as
> regulator-boot-on. I would expect any regulator to have such a
> marking to have at least one user with an actual driver. If people decide
> to not build that driver, and then complain we can simply tell them to
> build the driver ...

Right, but that's not what regulator-boot-on actually means (and I'm not
sure why you would think it would TBH) so this will disrupt existing
users who are expecting the current behaviour.  We could try adding a
new property but it doesn't feel very idiomatic for DT which isn't very
nice.

Telling people not to build the driver doesn't in general work any
better than telling them to build it in I fear, it seems like it's
essentially just shuffling things around so people have to change their
kernel config in a different way to avoid issues.

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUu6iSAAoJECTWi3JdVIfQT5IIAINLhGsWZ56mnsaeos3XRjtX
jQIimV1Gj7q0PM01cdhS4lwZgdvfaFAvL12lCBrnJ69Jyk9Jywa4O9Ic/5p03bum
ikk2WJuNUqm0KIGSBT9FOvH6EI3ArwZ5FhzdvxxUaOauB4g+IaJhZAMJ0/Kjlnp/
dVYb2yGatkVdt8nSS5IqBVH80dclnNhEsw+ZBt4k04IG4XjnYrGYORx8tI7L9vD+
QvoDMjmklOZgCr9dY3XkDqDBVI6qXIvRNuHE34nRCOTpc6SHNZUcnZfxXkLsc1Zn
1gvWdgtnB6C1gnY+r/RQv6flT5NPbF43SDis2XzfNidHWO3Arta9pA0piE1BynA=
=/l0+
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
