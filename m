From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [systemd-devel] Making udev emit a signal when it is done
 loading modules
Date: Wed, 11 Feb 2015 13:28:27 +0800
Message-ID: <20150211052827.GP2593@finisterre.sirena.org.uk>
References: <54BA20D0.7060402@redhat.com>
 <20150117160319.GO18247@in.waw.pl>
 <20150128013852.GA8177@gardel-login>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U+NfgObvpQT1Q9Yq"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150128013852.GA8177@gardel-login>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lennart Poettering <lennart-mdGvqq1h2p+GdvJs77BJ7Q@public.gmane.org>
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek-wrcVdnn0TatmR6Xm/wNWPw@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org


--U+NfgObvpQT1Q9Yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2015 at 02:38:52AM +0100, Lennart Poettering wrote:

> To clarify this: if people do this, then this pulls in
> systemd-udev-settle.service, which slows down boot. Every service that
> does that is hence a majour source of slowness.=20

> It's a hack to use this, not a solution.=20

Well, yes.  There aren't really any good solutions with our event driven
model - we never "finish" booting, we just get to a point where nothing
has been happening for a while.  I have been thinking that we need to
just admit that properly and do something timer based - have a timer
that gets reset every time we instantiate something, then do all our
"end of boot" actions when nothing happened for a while.  It's not
elegant but I don't think elegant is a realistic goal here.

--U+NfgObvpQT1Q9Yq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2uh3AAoJECTWi3JdVIfQXiMH/3q96kHm4HxrwoIHxRnpiMPn
1Mwo44BpdSn4pefOpRTgR6u1myLxzpsasCvmt/F7m/DMSFyGczSX42p2FXv+4IpO
Np/Up9xCljmBq4HT9/X5bcJneuFgvTMjJrTynPrwcO/JZpzmjVRl5TykmEZsESMi
MV7OCuLflbxsSITpSbhd/BTRtRjvR2ANppqv6vEStKq/o1GMSN49cspB+chKRRQP
OMLasFHW2T/ef0E0Xybui2XX7e5bMQ/sxzPQ14XLJXKd+n4md108z45qaHtsQRnp
N3fHCV5ookwqPYjFLl6DfjS7xeHfM5zTs0FkaIUActbeFnFRaKVyQrhz9vdBpOo=
=O2OM
-----END PGP SIGNATURE-----

--U+NfgObvpQT1Q9Yq--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
