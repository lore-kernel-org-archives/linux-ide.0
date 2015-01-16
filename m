From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/4] ARM: mvebu: Armada 385 GP: Add regulators to the
 SATA port
Date: Fri, 16 Jan 2015 20:25:16 +0000
Message-ID: <20150116202516.GL3856@sirena.org.uk>
References: <1421330978-9694-1-git-send-email-gregory.clement@free-electrons.com>
 <1421330978-9694-5-git-send-email-gregory.clement@free-electrons.com>
 <54B8C933.7020502@redhat.com>
 <54B8D97B.3090908@free-electrons.com>
 <54B8E38A.6020709@redhat.com>
 <20150116123705.GM3043@sirena.org.uk>
 <54B9629C.9090800@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L/Qt9NZ8t00Dhfad"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54B9629C.9090800-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--L/Qt9NZ8t00Dhfad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 16, 2015 at 08:12:28PM +0100, Hans de Goede wrote:
> On 16-01-15 13:37, Mark Brown wrote:

> >>It is probably a good idea to use regulator-boot-on and
> >>then test things this way, and if that works use
> >>regulator-boot-on.

> >No, it's unlikely that boot-on makes sense here - it's there for cases
> >where we can't read back the hardware state at power on.

> Which we cannot here since we've a gpio driven regulator, with the pin
> in output mode, so we cannot read it back. Or at least the current kernel
> implementation relies on regulator-boot-on rather then reading the
> state back from the hardware.

Right, this always seems like a problem with the GPIO API - not being
able to read the state back is a total pain for boot handover, we should
really have a way of reading back the current output state.  This is one
of the few cases where boot-on can be useful, though ideally it'd be set
by the bootloader rather than as a static thing since otherwise you have
the opposite problem in the case where the disk isn't being used at the
current time.

> While we're discussing this I would also like to advocate to change the
> behavior for regulator-boot-on to be the same as always-on when it comes
> to regulator_init_complete(), iow regulator-boot-on regulators should
> not be touched by regulator_init_complete(). It makes no sense to have
> different behavior for build in versus module drivers here.

Like I say boot-on is *only* intended to support bootstrapping, if you
want the regulator to be always on then mark it as always on.  If you
want some way of marking the end of userspace init so we can defer
cleanup of unused resources then go do that - it's a change I've
advocated before, it'd help with modular drivers in general.

> I believe we should still leave these on once userspace starts running,
> there is a reason they are marked as regulator-boot-on and the fact that
> we're ready to start running userspace does not take away that reason, to
> me regulator-boot-on means "do not turn off until explicitly told so by
> a driver which (hopefully) knows wtf it is doing".

No, that's not it at all - it just means that either the hardware didn't
support readback or we're working around our own limitations in not
being capable of doing that.  Remember, regulators are reference counted
so with a few exceptions drivers aren't saying "turn this off now"
they're saying "this device doesn't need this regulator right now, turn
it off if you like" and there's no guarantee that a driver will ever be
loaded in the first place.

--L/Qt9NZ8t00Dhfad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUuXOrAAoJECTWi3JdVIfQz+AH/iTVjM6UoztE8KH6D4cdKvEC
K62qWmJP5la171aLSd1HF9W0NnF+SGQmc0tpeTNnj59pPhORznMcBP0aPzvLFIA+
Qjr19QzdIDo4z8Hd6EHhpJV/N25pLwHQb2Ei3r52vwArIx21TyedAReX73zBiyiX
zSDR/GSJzgOY/HN3Nxu8S+JxVfGseWEzvSubWKID5Lgjia1eLcH5uYjTaJsJM1QG
V14PPLaLXHQE1DUgam7IUstTO0ixeT8swTwZkxYF7lPngpZ2jfme7J3GhUofdaDn
ze7FcKfZY4XqJ/S/LNxo48SuMVSdmyFsTAjVKN5f5CpUZNZo+o7XFJ6r6TLvKTI=
=xv2A
-----END PGP SIGNATURE-----

--L/Qt9NZ8t00Dhfad--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
