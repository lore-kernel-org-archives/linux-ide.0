Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F520C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 26 May 2022 13:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbiEZNCV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 May 2022 09:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiEZNCU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 May 2022 09:02:20 -0400
X-Greylist: delayed 1372 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 May 2022 06:02:15 PDT
Received: from se19-yh-out3.route25.eu (se19-yh-out3.route25.eu [IPv6:2a01:b941:2::91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A28CCFE15
        for <linux-ide@vger.kernel.org>; Thu, 26 May 2022 06:02:13 -0700 (PDT)
Message-ID: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
Date:   Thu, 26 May 2022 14:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     linux-ide@vger.kernel.org
From:   "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
Subject: Multiple errors with DVD drive
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0fD8SRhvkRLKZL4498Kn0jXB"
X-PPP-Message-ID: <20220526123917.27412.63123@server108.yourhosting.nl>
X-PPP-Vhost: staalenberk.nl
X-Originating-IP: 185.37.71.73
X-SpamExperts-Domain: filter.yourhosting.nl
X-SpamExperts-Username: 185.37.71.73
Authentication-Results: route25.eu; auth=pass smtp.auth=185.37.71.73@filter.yourhosting.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/Ik4R2KGRO6MWn4rxNWqIZPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wbKGKgvDNtko52zmlKj9u4U2Itm39BdCc4FEP6OrUewhPm
 p87GC1OZvsh7yKER8spmk5K29Ldt/0gY6O53I/Cyeb4o0/MLsfRXq2B6Bj1eqLdRg4TfZq2twbxK
 ne3bTxREkSF2RwjLlNyLHQr71RxeYzDzG2yBl+P6SMBMGH3GzmHsVhwt8dbKhbdn7deZ07Pt6JtT
 TglxNZAq/da6Ra+kV1jRduzSeTlLA4KONKsfZbm2yKklKs/xwV8kE9t47ZiZOZh/196Uh/xDSW9g
 kA3LEWgKIJ7Ay0RVJqlA03GHx7ObK052/jLuewOcI5amMxstChAJ8MhPXbXvhZAyklffRAwX31WV
 Y5lWjWxuGSRuxbb9wsrnUxyV5R6XweswXiYy2dhy85T3A96mF1Evp4++cd3QbXHil9nVohJvu6B5
 vcQRHhpp7PEHhQA50A063668oLWVcEFIP6cB4qvhjDlE8SRu8s3H6BxpZmNpeigyegX81Q2b6Us7
 siSVRTTv3earEPGaUfvTQD8mTYnm5Vyb/eB36XvbBuC1U1srT4VxcBqZR3KVQgqF/fPYYAfEfsg1
 1Ad23U0cZ9WVVTbpTmmUZrGhqUDaqras7LqiHi35vbMHwRfzaSU5FsHqIjos197mzfV669FmRwFs
 RSOwswyQAcVCbFO9oZq2JrkUu2Y0bcen5bW2mj7gpl+Nel82aV6t85jdQ1W7xM52M4KvSDibJS8X
 NHE22jNoXXtgm8Rhij9YHcdrxh7ntAaPP6XHE+ux3UngHmmej3FmzKkqBXsKLO5CFt1KNiXMKT/q
 NzUI6CG7X+t1TW39Ja77LGPpOwAT4kZm3AYrwwubjkeENJKdbGMwes7NyHuYBdQjd1YteIi7YBpB
 LYUph4jPimJS/7Zi/131P3mdLzgr+UhVxYKZoSyaA1TzQpMNBxbB7RLiYFYq922Wf+VLnUUJCa5X
 EkPBdYzH5SHs7OXwC7D2RhUaKfhganupwSWw7cas29IGI3Ms1dwieR5pqJIe+glXHys9mi+FbRwZ
 y3X+fQbaXDYb
X-Report-Abuse-To: spam@semaster01.route25.eu
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0fD8SRhvkRLKZL4498Kn0jXB
Content-Type: multipart/mixed; boundary="------------Rp5hM3uRlea3p60DiPZIRonT";
 protected-headers="v1"
From: "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
To: linux-ide@vger.kernel.org
Message-ID: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
Subject: Multiple errors with DVD drive

--------------Rp5hM3uRlea3p60DiPZIRonT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Firstly, if this is not the right place for this message, I apologize.
In this case, disregard.

I have a problem which I suspect is a bug in libata, but of course I
could be wrong.

The problem is:
After going from Linux Mint 19.3 Cinnamon kernel 5.4.0-97 to Linux Mint
20.3 Cinnamon kernel 5.4.0-107 I discovered that I could not (reliably)
access my optical drive anymore.
It produces errors like:
	ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xe frozen
	ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
	ata1.00: cmd a0/00:00:00:00:fc/00:00:00:00:00/a0 tag 0 pio 131072 in
         Read(10) 28 00 00 00 05 61 00 00 40 00res
50/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)
	blk_update_request: I/O error, dev sr0, sector 5508 op 0x0:(READ) flags
0x80700 phys_seg 19 prio class 0
	ata1.00: failed to set xfermode (err_mask=3D0x1)

The system was Linux Mint 20.3 Cinnamon with kernel 5.4.0-107-generic,
mobo ASRock model X570 Taichi.
After some tests I found out:
Kernel 5.4.0-99 works OK;
Kernel 5.4.0-100 has the problem;
Kernel 5.13.0-30 works OK;
Kernel 5.13.0-35 has the problem.

The problem is described more fully in
	https://forums.linuxmint.com/viewtopic.php?f=3D47&t=3D371251

I reported the bug to the Launchpad Ubuntu site under number #1968155:
	https://bugs.launchpad.net/bugs/1968155

One other person (as far as I know) has the same problem.

I froze my kernel at 5.13.0-30, so for the moment I can use my system.
I realize that there are probably not many users with an ASRock X570
mobo, and in that group only a few would be using a BD reader/burner.
However, it would be nice if I could again keep my kernel current.

With kind regards,

Jaap Berkhout

--------------Rp5hM3uRlea3p60DiPZIRonT--

--------------0fD8SRhvkRLKZL4498Kn0jXB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEoR3751BhG/27nT45Zx3W/nHBYkoFAmKPdN0ACgkQZx3W/nHB
YkqFpw//V5/MnRWxc+K4KR5Ur0Gw+23z+g384xU34TxoEVsxUeUxDZwuxZC/r8r3
ulzul7DCzagZfa6vtQ8KkacTmac7bcit9w6Rphusk8l2G4YWlgc8svc9ntYH+p1w
+YtSKCxSDdknaSDY/z2VDMRnIaSDL1QfYmjfntNQ9xZsYVyoSLc+gIeNtlpeMoj0
Hn93WLpn5udlQNnINxgNPKU2sPw0uTM/W3NWjAwym9WToOGvlt0Th38BtCkBv8v6
NYoujbUK0LZMkJ2w4K2QCdtr6mhLyxTUBsqdH1rBfOihcAR+cCIO+y1ovgAEAqRF
8y2YDfdFP6HjgCwwxJtb1M75DRkxzTJUYshWkrxbhbv1x6422/oVqtnaE794v2w9
W9K5vuvXTv9VgAtIN7AuECvn0Vn0+whgu/+7jegonuewXL8NwYadgbF7A9zwQg+0
ueV0BGVOmSFWoAQqUWdEOF6zxRIMsBZZ5x2FpS6vgcpUN9X3NXwMHpa6KXZJ8bSy
yHVQyMvoAimNM+tMS3vFxgZUTAYMw8HQK8TnhH0YHu0eVkRNZIRHTmROA/ze4QZg
/1Bw1ljAgM73yK3IFOiDIuRcxVxOQVzJeZrXYx09KTjGCNucEsHf4RHDC4V4kw0G
708YiPN9sfqPYR6c53SBYXd3a34PHgqBbm3DyqyiFXBWQkDNnpE=
=fr75
-----END PGP SIGNATURE-----

--------------0fD8SRhvkRLKZL4498Kn0jXB--
