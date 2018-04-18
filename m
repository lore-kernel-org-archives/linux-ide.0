From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] Revert "ata: ahci-platform: add reset control support"
Date: Wed, 18 Apr 2018 10:36:47 +0200
Message-ID: <20180418083647.GA5503@ulmo>
References: <1523237554-7928-1-git-send-email-hayashi.kunihiko@socionext.com>
 <c8ec7474-7eb4-24cf-1f53-b4bcee5508dd@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c8ec7474-7eb4-24cf-1f53-b4bcee5508dd@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 09:02:33AM +0200, Hans de Goede wrote:
> HI,
>=20
> On 09-04-18 03:32, Kunihiko Hayashi wrote:
> > This reverts commit f0f56716fc3e5d547fd7811eb218a30ed0695605.
> >=20
> > According to Thierry's view,
> > https://www.spinics.net/lists/linux-ide/msg55357.html
> > some hardware-specific drivers already use their own resets,
> > and the common reset might make a path to occur double controls of rese=
ts.
> >=20
> > For now, revert the commit that adds reset control support to ahci-plat=
form,
> > and hold until the solution is confirmed not be affect all hardware-spe=
cific
> > drivers.
> >=20
> > Fixes: f0f56716fc3e ("ata: ahci-platform: add reset control support")
> > Reported-by: Thierry Reding <thierry.reding@gmail.com>
> > Suggested-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>=20
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Hi Tejun,

I see that you've applied this to your for-next branch. However, this is
a fix that needs to go into v4.17 because that's where the regression
was introduced. Is there any way you can promote this to a fixes branch?

Thanks,
Thierry

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrXA5wACgkQ3SOs138+
s6FJlBAAv/nfRiMasHog1uChBDJIxUNKLiFTXIjw9IhC4ek++LE9xNi1oDOl+MiQ
56XUNBMSv8fo/qwcA7rEDjVUn4nej1YQTqTCZjnW0xd0Gd0z99QbucWvCz0b2ocg
DHJRZF07BlPJoptCpaHgEcaNC6va8UXsbEZMp56gDnXYH5o87p246evlxnPL1nR5
8QkGLdHOgyxCiG4j9T9E53mRJLhpqbKzgp7l7F2N+Lh8JDyhlOUODCdv/ykhdzkA
A8q30xQKcgQeiUVvDpmTvqfGxIl6p+hwEpyXD7j0yN1Nfpmjxhzy1ujLmDM8VGR7
enJiSUmWNgfYfBJU/J+FZ/4GrZZ27JkJUWWWZFVIVe6ye2rfkOWq87U0ODbfcpDH
q3Hh2Xr9lHBBf3GJfm1DIUzmDqKdi4lforuDtIWrrmAweoNELzsBIBFz8kkcJ86w
TGksOtR+kfVVk9DjnNS0rbPt9U1Q9DDjMMU2076NuVZ8u6NJNjTOCaFZ9Tx6Sq6/
htT2AKF9uu7H4NJ0Hkcbro7e/ZMoJdotckCGy/Em/GR9KX342TcknZuHLSciEya1
KwGT9qT3ft5q3B8zFoxwr90T15Do/vLzwvKQnRukxx7MZahAK2JYYtyoCwp4Z9X9
Q5tsoB1TjoqlD0+/NUut8v2BbgklT8vHDEncquhXzTCES4hS1dc=
=jGuO
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
