From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v7 13/15] ARM: sun4i: dt: Remove grouping +
 simple-bus compatible for regulators
Date: Sat, 22 Feb 2014 22:44:21 +0100
Message-ID: <20140222214421.GC3610@lukather>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
 <1393084424-31099-14-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBX5UUSMAKGQE6Z2OORY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393084424-31099-14-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 22, 2014 at 04:53:42PM +0100, Hans de Goede wrote:
> According to Documentation/devicetree/bindings/regulator/regulator.txt
> regulator nodes should not be placed under 'simple-bus'.
>=20
> Mark Rutland also explains about it at:
> http://www.spinics.net/lists/linux-usb/msg101497.html
>=20
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Applied in my sunxi/dt-for-3.15 branch.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTCRo1AAoJEBx+YmzsjxAgO2YP/itx22fs3JZA5394U9QlgZA0
uqEVrxZPtXf30KFr11IQ3Ru0hFlp7mdEXKfsi3I0mi9oNOQG97fk0W/5/vWZ3Mud
g3sF+eXqhsoInV0HV/A6qmmO9NUuaRB6n2fX98wjl4KO1mKyuPYor246kXP8TWEX
vdd0S43V93jdvrbm32Xq1A96oEK16Gn1wr/dd/gAP4lbhAGA1kkmsFZvXHx8l5mh
H9bfyBCuHiutGcUUmWBcRo8ujjtg8h6gAyNiYtNUPtZLR5LfZnd1zgj4yW3xhWfB
f1IlcN1ZbPh5zIaYgegSdW9FztMXCf5aHKJ39S8RqdVPwOjOLge02girV4+KkjCv
ixrpG6ce2YSTIdVzLedp0Zl/s1xcwnkxpRjtAAD3gWt2MoFqIYf/tF6RADzps8zD
poOquhh84zG1OtchPNkaDat8lw4tlWdlWAEq2dwhbXg7Q8tgGzNtWUN/STs3cd6U
tA3etnV9Win9kDSeij/fcAPup1ntuI4VT7fgEHGRn+opiBad0F1jNI3DmW/t6lKG
hQ0N+OveZ2RTJ2DgWRYFGh3tW+NKlMwBF8CevBgcgCW6tsoKLxMoGM/jgg5NdXq7
7DjzKpk65q8dlmMwDAoyUj5vHhyPKpA4/qgxA83d+7Sb6/NM4rrvUeF1CfeRbvZK
uSlGZoZEy0j9VWyp+cDf
=W8u6
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
