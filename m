From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: sunxi: dts: Add ahci support to a
 few A10 and A20 boards
Date: Mon, 9 Dec 2013 20:16:20 +0100
Message-ID: <20131209191620.GN24519@lukather>
References: <1386159055-10264-1-git-send-email-oliver@schinagl.nl>
 <1386159055-10264-4-git-send-email-oliver@schinagl.nl>
 <20131206183339.GG24519@lukather>
 <52A30ADB.7090106@schinagl.nl>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FhKpTYimqQF2+bfE"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB2FPTCKQKGQEQEBLYIY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52A30ADB.7090106-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Cc: oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--FhKpTYimqQF2+bfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 07, 2013 at 12:47:39PM +0100, Olliver Schinagl wrote:
> Hey maxime,
> On 06-12-13 19:33, Maxime Ripard wrote:
> >Hi Oliver,
> >
> >On Wed, Dec 04, 2013 at 01:10:55PM +0100, oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org wrote:
> >>From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
> >>
> >>This patch adds sunxi sata support to A10 and A20 boards that have such
> >>a connector. Some boards also feature a regulator via a GPIO and support
> >>for this is also added.
> >>
> >>Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
> >
> >Your git setup seems to be pretty uncertain about how your first name is=
 spelled :)
> I should have formally mention it to confuse less people,
>=20
> This is how officially my name is spelled (I left out any 'middle'
> letters. I never really used it as such, as it confuses people and
> they always write it wrong anyway. After years I decided that at
> least on these patches, I should write it down properly
> (googleability etc in the future). So formally it's Olliver 'oliver'
> M. Schinagl.
>=20
> And no, I won't share my middle name :p
>=20
> There! :)

My point was more that the spelling in your From is different from the
spelling in your SoB.

> >>diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i=
-a20.dtsi
> >>index 0552a64..b72c69e 100644
> >>--- a/arch/arm/boot/dts/sun7i-a20.dtsi
> >>+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> >>@@ -368,6 +368,15 @@
> >>  			};
> >>  		};
> >>
> >>+		sata: ahci@01c18000 {
> >>+			compatible =3D "allwinner,sun4i-a10-ahci";
> >>+			reg =3D <0x01c18000 0x1000>;
> >>+			interrupts =3D <0 56 1>;
> Will always fix this to <0 56 4> if i'm not mistaken.

Only the GIC has a three-cells interrupts. So only the A20 and A31 are
supposed to have this value.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--FhKpTYimqQF2+bfE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSphcEAAoJEBx+YmzsjxAggvkP/REzOU6lkQXL/DoVRWmei9hT
P4GtbD5//V72PYEP75SM5QIXoUMJyQ9pQ602UecySO8hbljZIvus4po5D9RTX0Ex
eovynNucLo1X7LJeNrg7Jj1aoLTLMTQtJgUJoTOwppA7M/JkBZFby7q4vUZTWZVt
Gq2hk17apFhtB4icZFUTLme/Wb9JV5Rx10z6LZHMGLnV0aSzv/DWUSv9MChRrPjt
k89W7AvL+/paa1bZ8lwlkIFfXwWCQkSbrNdRbbkfui+zFz2+wtmLJAmHq5Pg/GQW
SUQieKyZL5AVttgvoibF8NvSZe7FLd0LR5sWtauZndDAW3cOmpnkBiDVsr/V+9Af
vW1UHFMDYotPv2DR3ldzGAhuMlOudLaRrqtZ+5IjXup1PyO66twupB3Ea21QCsWI
eZEs9wgc8bxeGg4gmPf8xWWytvEa43OF4hS4WlqE8rX6RXI4MSzEJC5lxPK+Y71s
QR4SpVwRts6s1QijD8KwJiCamO0Rj+nXqt+wCMH7zdf9XgkwuUJMn0yktnSV7qNU
kVgKGzWq0Yh91XfQHGfA3a5fvLSQ/c97mMQ8hyvUn+TQIHAOd6cVXUfgp9A9HZ/G
z298cdTSHNDLikNQymeTNKqilh1B3qGY2CJ5u7ycOiC25KY3Dk28BW05ud/6En70
o9v8slSKVNJ3pihspiJJ
=h+M3
-----END PGP SIGNATURE-----

--FhKpTYimqQF2+bfE--
