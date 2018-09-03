From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
Date: Mon, 3 Sep 2018 10:31:31 +0200
Message-ID: <20180903083131.asgh6wp54e2fs62l@flea>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
 <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
 <8fa866c5-6800-505f-53bc-5c1b27582ca6@kernel.dk>
 <20180831074024.w7yicj5y4imy57e2@flea>
 <39f89b9d-f5bf-7c4a-8e68-252bfc0b91a4@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bqnc4wmife4rizom"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <39f89b9d-f5bf-7c4a-8e68-252bfc0b91a4@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Chen-Yu Tsai <wens@csie.org>, LABBE Corentin <clabbe.montjoie@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Kishon Vijay Abraham I <kishon@ti.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>
List-Id: linux-ide@vger.kernel.org


--bqnc4wmife4rizom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 08:35:23AM -0600, Jens Axboe wrote:
> On 8/31/18 1:40 AM, Maxime Ripard wrote:
> > Hi Jens,
11;rgb:0000/2b2b/3636> >=20
> > On Thu, Aug 30, 2018 at 08:52:52PM -0600, Jens Axboe wrote:
> >> On 8/30/18 8:32 PM, Chen-Yu Tsai wrote:
> >>> Hi,
> >>>
> >>> On Fri, Aug 31, 2018 at 4:31 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>
> >>>> On 8/30/18 1:01 PM, Corentin Labbe wrote:
> >>>>> Hello
> >>>>>
> >>>>> This patchset add support for allwinner R40 AHCI controller.
> >>>>>
> >>>>> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> >>>>> on sun7i-a20-cubieboard2 which doesnt have any of the ressources ad=
ded
> >>>>> by this serie, so no regression should come with it.
> >>>>>
> >>>>> The last patch(ata: ahci_sunxi: remove PHY code) should not be merg=
ed,
> >>>>> but will be resent for inclustion when all patchs will have hit lin=
us
> >>>>> tree.
> >>>>
> >>>> Applied 1-12 with Hans's blessing, thanks Corentin.
> >>>
> >>> Please don't merge device tree ("dts") patches, i.e. patches 9-12. We=
 will
> >>> merge them through the sunxi / armsoc tree. Having them in separate t=
rees
> >>> introduces conflicts when we have other stuff going through our tree.
> >>
> >> OK, fair enough, I can drop those.
> >=20
> > And the DT bits actually have some issues that would need to change
> > the code significantly.
> >=20
> > Can you drop all of them please?
>=20
> OK, can do.

Thanks!

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--bqnc4wmife4rizom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluM8WIACgkQ0rTAlCFN
r3TKYRAAhFvCHyzVXOZC/BzDb2cLoagfdyqL6PmDJrLnIywHrqkfEAIDGc3L9MBs
V88pX2q/85lyW6GyadGpD+Tj+vTDcZlLi/ZZadPwFzLsgBhabY7mhsGHtp9+1GTN
0i4rvz+xm2blUv2fQpCa4xJ/JW/FHQdgC5NvNl0LaPjMFFp1EL7DrRy9GYBs3fNP
a1Y0hiiBVCQ5HzkiTjXLQv5bG8QLVJCnTzRU8pCE69hN+WuiXsrmAp1l7I3ovcLx
fpIwbCs+wFv87TiTGthRaFrwb6udwYgKeUi94jZJP4VSEs2cSaDtnDUwsaSLts5O
GfztSy9JADpKz59jtsjKjBHlEDUS34mmnzo5rg4/HOhj0mrTMP6eSmRc2FTU8z0O
XTeBrNzMBlXUC/nnBxUrCuggKLD5b2avB6bfwayv5p8ZxdE90gB8wKTcnWxZqYut
/irhff7nqc4WN1xvMuOGMTbidPqLX5FByXOJhE7BCXOrsUMwGtBCN9DJdFdjtXEy
F32514jBAuiX+JCzHEC5F9PlfOZmNS15wwwOPDUNZoIrGpzrs/0LSzwn/PQuO/jD
Fl0AbkPskhhOAtX5OO/Eb3Sj6MeJF3dihAMEAlOGaa64eXQyXzW5TVp1qH31E4f1
LeI5BFWSCTpB+x6f2LTQKATzHQUiuamSOPc9hPtUS9ojhhCDFS0=
=lSQ9
-----END PGP SIGNATURE-----

--bqnc4wmife4rizom--
