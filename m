Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286B0C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 14 Feb 2022 17:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiBNRu6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:50:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbiBNRun (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Feb 2022 12:50:43 -0500
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3C8652C4
        for <linux-ide@vger.kernel.org>; Mon, 14 Feb 2022 09:50:35 -0800 (PST)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 2CB73342FE3
        for <linux-ide@vger.kernel.org>; Mon, 14 Feb 2022 17:50:32 +0000 (UTC)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        by grubbs.orbis-terrarum.net (Postfix) with ESMTP id CF5AF260A6F
        for <linux-ide@vger.kernel.org>; Mon, 14 Feb 2022 17:50:31 +0000 (UTC)
Received: (qmail 22034 invoked by uid 10000); 14 Feb 2022 17:50:31 -0000
Date:   Mon, 14 Feb 2022 17:50:31 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 0/2][RFC] Make delay before debouncing configurable
Message-ID: <robbat2-20220214T174203-740445772Z@orbis-terrarum.net>
References: <20220113154635.17581-1-pmenzel@molgen.mpg.de>
 <85153d62-15b6-e055-00aa-74b728bb0195@opensource.wdc.com>
 <robbat2-20220119T172913-356389698Z@orbis-terrarum.net>
 <5cc9bb8d-e228-c11f-feef-5cfba631057a@opensource.wdc.com>
 <036507f3-91bb-6480-7252-ff100a282ebe@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eonemrNsM7zQx4tq"
Content-Disposition: inline
In-Reply-To: <036507f3-91bb-6480-7252-ff100a282ebe@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


--eonemrNsM7zQx4tq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 08:09:53AM +0100, Paul Menzel wrote:
> >> This series esp of a code approach that didn't get merged might be
> >> interesting, that implements hotplug by polling:
> >> https://dev.gentoo.org/~robbat2/patches/libata-development/2007/00-hp-=
poll/
> Polling and a warning, when polling time exceeds like 10 ms, so users=20
> can contact the hardware vendor, would indeed be the most flexible soluti=
on.
>=20
> Robin, do you remember, why these patches were not applied? Just lack of=
=20
> time and review, or where there issues?
Disagreement on the per-link configurability via sysfs, and then lack of
time to come to an agreed solution there.

The 2007 linux-ide list has some of that discussion, but there was also
some on IRC that is lost to time.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--eonemrNsM7zQx4tq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmIKlmZfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQClQ/+IsmFxVjydvA0kdao6RLbA9KNnewrtKM+oCYB02QTNFLNKBQExJf0wt4d
ulZ72Ay3UiDNfH4tqDXtlrrlW6+eZiDVtGvFWZkw4XBONj3xMF2mSooGWG2D6yPo
GkhOhuLEHbbC2Cn1fLB13fEQmeJPIlH/7f8qv9jf6oPoR5fajZzRsWfLjC3pvwF/
7RD4++Mg0qWPnkIdYSBFUCE1zlJs+a/wpIYtUtUwxbjmDyN1w617IO6SFvcVOi0D
/huoog+sJJAuafnZiUmjvk1Eh33QsQ8rCZJmJYdz3xoZ88mGOKqyREupDIwfz7cL
SoD8P+xth6rFOjPGZlgedho3bEE0CuasizS48zHxFbW3A7tfsJOQgUKtvNxPVDsf
ZWGNxE6NNCuIMlhM7ud4/tSEBKlT9d7qP/MUMbho13hENo9Qm2kx6FUsyQvFsGty
nrh2Oo+a5WNLi+OMQNMlwKSaLAMReOzSo1QxNg4oSw+wuxpw4ldKBp1j3IutzTWg
5wWxSeEzH7tc0Pk7VrBGoXzkZBwrP/GQSGXUCUsCgnftcz79OB9uEzIr7KJZIWE3
L7qcpkuG+r1HWgWJKsOPFgO+pOkWECMNa8u3FFMuOUYOQ5h9u6cYqx16h2K1czT3
h+Ej6Mjm6bluKxy1Irnvb8cpewN64Fduo6Rg0BB1JKGAZxdqSw8=
=C9/1
-----END PGP SIGNATURE-----

--eonemrNsM7zQx4tq--
