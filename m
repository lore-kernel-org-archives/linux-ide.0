Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8FDC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  3 Feb 2022 06:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiBCGrU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Feb 2022 01:47:20 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55865 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiBCGrT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2022 01:47:19 -0500
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFVre-0003ZD-0G; Thu, 03 Feb 2022 07:45:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFVrD-00EDHi-Iw; Thu, 03 Feb 2022 07:44:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFVrB-0057vk-Mb; Thu, 03 Feb 2022 07:44:37 +0100
Date:   Thu, 3 Feb 2022 07:44:34 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Viresh Kumar <vireshk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] libata: make ata_host_suspend() *void*
Message-ID: <20220203064434.j6b4oozzduxqkahe@pengutronix.de>
References: <7cb64472-9e37-704a-0b9a-52ed050c1826@omp.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yy4e5fdl2phug67a"
Content-Disposition: inline
In-Reply-To: <7cb64472-9e37-704a-0b9a-52ed050c1826@omp.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-ide@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--yy4e5fdl2phug67a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 02, 2022 at 11:58:21PM +0300, Sergey Shtylyov wrote:
> ata_host_suspend() always returns 0, so the result checks in many drivers
> look pointless.  Let's make this function return *void* instead of *int*.
>=20
> Found by Linux Verification Center (linuxtesting.org) with the SVACE stat=
ic
> analysis tool.
>=20
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yy4e5fdl2phug67a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmH7edAACgkQwfwUeK3K
7AmJMQf9FWZ7f/d6iNsBouQ161pjB9RaXio/tUvgG7dvJ9JFqB846RC05Xvn3fYA
+my25J7yNyM6pXZKXkmVuafViwGqPPZvl7iTj9otUUrNFYGIeFmJc98t8gW2ul4r
d/KfrhDmVI2WX767ZSocpsldFhDXsCQVp2D3ipEHKIKefRiBkfpmRuYNfLjR1TzF
OdkzXxKSTxvQiSopNN3z+LgcVbsjmlX5gw3/5xAAvPIQzGGRgb09JA2GNYv8Kb2h
AA/9grelMYIqJT/EXoi+af1toIdXeIVI/1adh0KizqWQl33zdWPhCUvcDK0VzvsE
7WjzzUqPckdBdriZhLQvpi8jwx5vvw==
=VpcW
-----END PGP SIGNATURE-----

--yy4e5fdl2phug67a--
