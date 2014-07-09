From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
Date: Wed, 9 Jul 2014 12:25:52 +0200
Message-ID: <20140709102551.GA19357@ulmo>
References: <20140617215119.GC24743@mithrandir>
 <20140618121806.GJ3407@tbergstrom-lnx.Nvidia.com>
 <53A1B252.1030204@wwwdotorg.org>
 <20140619080234.GK3407@tbergstrom-lnx.Nvidia.com>
 <53A3096B.1040409@wwwdotorg.org>
 <20140623101441.GU3407@tbergstrom-lnx.Nvidia.com>
 <20140708130501.GC9516@ulmo>
 <20140708141135.GC23218@tbergstrom-lnx.Nvidia.com>
 <20140709063130.GA3170@ulmo>
 <20140709083311.GE23218@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140709083311.GE23218-Rysk9IDjsxmJz7etNGeUX8VPkgjIgRvpAL8bYrjMMd8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2014 at 11:33:11AM +0300, Peter De Schrijver wrote:
> On Wed, Jul 09, 2014 at 08:31:32AM +0200, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Tue, Jul 08, 2014 at 05:11:35PM +0300, Peter De Schrijver wrote:
> > > > >=20
> > > > > Yes, but the problem is that you also need clocks and reset of ot=
her modules
> > > > > in the same domain to safely control the domain's status. Eg: the=
 ISPs, VI and
> > > > > CSI share a domain. VI and CSI are useable without ISP and the IS=
P lacks
> > > > > public documentation. So it's not unlikely a VI and CSI driver wi=
ll upstreamed
> > > > > someday which means we would need to control the domain and there=
fore would
> > > > > need to tell that driver about the ISPs clocks and resets even th=
ough the
> > > > > driver doesn't know anything about the ISP hw otherwise.
> > > >=20
> > > > Can't we make powergates reference counted so that they don't get
> > > > disabled as long as there are any users? Looking for example at the
> > >=20
> > > We could, but then why not switch to the powerdomain code and make po=
wering
> > > off a domain a NOP until we sorted out the context save/restore or fi=
xed
> > > the framework to allow for suspend without turning off the domains?
> >=20
> > Well, one of the reasons why I'm not sure it's worth the effort at this
> > point is that we can't get rid of the tegra_powergate_*() API anyway
> > because of backwards compatibility. So we're going to add code (without
> > getting rid of old code) merely to support some generic framework. That
> > doesn't sound very useful to me.
> >=20
>=20
> We can also convert the existing users to genpd. Today there are only 2 u=
sers
> (gpu/drm/tegra/gr3d.c and pci/host/pci-tegra.c), so that doesn't seem to =
be
> an impossible task.

We can certainly do that. What I'm trying to say is that since people
may be running newer versions of the kernel with a DTB that doesn't have
the necessary properties to hook up power domains, we have to keep calls
to tegra_powergate_*() functions as-is, lest we break those setups.

That then means that each such driver needs a way to figure out whether
power domains are hooked up (which will be rather clumsy to do if it's
all supposed to work transparently) and fallback to the legacy API
otherwise.

So essentially we'll be adding code without the possibility to remove
any of the old code.

Thierry

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTvRivAAoJEN0jrNd/PrOhBeIP/jAiJeAv4rwYs7TAAeF4Gc++
b90eOrw3UTW+bAIRq3x4raOrKbfht5ONk7YjmXEPid9l0XLxaAHzbBvGLsgEqXUP
csLLO8VHBRuGIENUjHZ5tER5HO/zQE4Cg+sWfDdd2RPLQDyD0SLTAIKPnotEGSv+
SRG0JToTa36g9MbiiI5UuabFsAF9MneKvnAqjiUnCkL9euWB7MteJ/iVhyGNh65w
KakGxXtPonnnnBx0FN8VheoGsmAAV9nJWeN1B+kCipIJBmwQ6j4GuT3WvTMVSw3s
fU3mbg55Cx3NZg9F6s4aZTp7B3mR/T0ERA5zwPLhovfOjdzQm9Www/10LwaE6eG6
wiUsoONZhBzmQG2HFZvCS7lbNGgSmViveaJVdLupBNbmYfR/+t18RUaTjlP0MyFn
li8zxXLdO/weVBCcq7L4QRC0tZj6qUxkmNbG+6VuO40gEEEmdMt8eR7s6DFP5AQA
w57xfVRWRlQE3s/2ExPCzD2TwPcl3wFDgDWUXUESID/QYCzQGcNFIu+zEOW+Wksm
WH7WHuCBML4f09FHE/uJnDHzzqodGigORpDaMNTcN6QSOlxJXkAr1EKl2qjOxYO2
L7/OO5+WYiRDKs48f48hyBkfHQ+SSXK5XVKtT9N6RFMHsBnKsWdl0ipmUQaBSl+u
8mI4gyp+ofyyZpEbboXg
=rE/b
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
