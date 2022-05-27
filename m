Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5025C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 27 May 2022 08:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347199AbiE0Iuy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 27 May 2022 04:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245159AbiE0Iux (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2022 04:50:53 -0400
Received: from se22-yh-out3.route25.eu (unknown [IPv6:2a01:b941:2::88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54063F1369
        for <linux-ide@vger.kernel.org>; Fri, 27 May 2022 01:50:48 -0700 (PDT)
Message-ID: <01e23194-d117-9473-37dc-a001caac1305@staalenberk.nl>
Date:   Fri, 27 May 2022 10:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     linux-ide@vger.kernel.org
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
From:   "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
Subject: Re: Multiple errors with DVD drive
In-Reply-To: <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------R8tpCTynJ0nZgsoCMFU7IYkD"
X-PPP-Message-ID: <20220527085043.8353.87662@server108.yourhosting.nl>
X-PPP-Vhost: staalenberk.nl
X-Originating-IP: 185.37.71.73
X-SpamExperts-Domain: filter.yourhosting.nl
X-SpamExperts-Username: 185.37.71.73
Authentication-Results: route25.eu; auth=pass smtp.auth=185.37.71.73@filter.yourhosting.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/dS77bgBjA+kYqjsWn0TflPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wbKGKgvDNtko52zmlKj9u4U2Itm39BdCc4FEP6OrUewhPm
 p87GC1OZvsh7yKER8sqPAga2N78Hggj70Pg5H0QSeb4o0/MLsfRXq2B6Bj1eqLdRg4TfZq2twbxK
 ne3bTxREkSF2RwjLlNyLHQr71RxeYzDzG2yBl+P6SMBMGH3GzmHsVhwt8dbKhbdn7deZ07Pt6JtT
 TglxNZAq/da6Ra+kh3sHUZE0RhjWpmCOxopjjLm2yKklKs/xwV8kE9t47ZiZOZh/196Uh/xDSW9g
 kA3LEWgKIJ7Ay0RVJqlA03GHx7ObK052/jLuewOcI5amMxstChAJ8MhPXbXvhZAyklffRAwX31WV
 Y5lWjWxuGSRuxbb9wsrnUxyV5R6XweswXiYy2dhy85T3A96mF1Evp4++cd3QbXHil9nVohJvu6B5
 vcQRHhpp7PEHhQA50A063668oLWVcEFIP6cB4qvhjDlE8SRu8s3H6BxpZmNpeigyegX81Q2b6Us7
 siSVRTTv3earEPGaUfvTQD8mTYnm5Vyb/eB36XvbBuC1U1srT4VxcBqZR3KVQgqF/fPYYAfEfsg1
 1Ad23U0cZ9WVVTbpTmmUk5JAzTEbG4umBpH9JLUebywI4y4kj1VJ3CG5FiBYsYbmzfV669FmRwFs
 RSOwswyQAcVCbFO9oZq2JrkUu2Y0bcen5bW2mj7gpl+Nel82aV6t85jdQ1W7xM52M4KvSDibJS8X
 NHE22jNoXXtgm8Rhij9YHcdrxh7ntAaPP6XHE+t8BWI3HZJpyo8ggxhWGkIPAgVqDJrSm1Fxjwp4
 gvx6jiG7X+t1TW39Ja77LGPpOwAT4kZm3AYrwwubjkeENJKdbGMwes7NyHuYBdQjd1YteIi7YBpB
 LYUph4jPimJS/7Zi/131P3mdLzgr+UhVxYKZoSyaA1TzQpMNBxbB7RLiYFYq922Wf+VLnUUJCa5X
 EkPBdYzH5SHs7OXwC7D2RhUaKfhganupwSWw7cas29IGI3Ms1dwieR5pqJIe+glXHys9mi+FbRwZ
 y3X+fQbaXDYb
X-Report-Abuse-To: spam@semaster01.route25.eu
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------R8tpCTynJ0nZgsoCMFU7IYkD
Content-Type: multipart/mixed; boundary="------------SSEKb0v9TkJf6TErfuROGwmF";
 protected-headers="v1"
From: "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
To: linux-ide@vger.kernel.org
Message-ID: <01e23194-d117-9473-37dc-a001caac1305@staalenberk.nl>
Subject: Re: Multiple errors with DVD drive
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
In-Reply-To: <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>

--------------SSEKb0v9TkJf6TErfuROGwmF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 27-05-2022 01:36, Damien Le Moal wrote:
> On 2022/05/26 21:38, J.J. Berkhout wrote:
>> The problem is:
>> After going from Linux Mint 19.3 Cinnamon kernel 5.4.0-97 to Linux Min=
t
>> 20.3 Cinnamon kernel 5.4.0-107 I discovered that I could not (reliably=
)
>> access my optical drive anymore.
>> It produces errors like:
>> 	ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xe froz=
en
>> 	ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
>> 	ata1.00: cmd a0/00:00:00:00:fc/00:00:00:00:00/a0 tag 0 pio 131072 in
>>          Read(10) 28 00 00 00 05 61 00 00 40 00res
>> 50/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)
>> 	blk_update_request: I/O error, dev sr0, sector 5508 op 0x0:(READ) fla=
gs
>> 0x80700 phys_seg 19 prio class 0
>> 	ata1.00: failed to set xfermode (err_mask=3D0x1)
>>
>> The system was Linux Mint 20.3 Cinnamon with kernel 5.4.0-107-generic,=

>> mobo ASRock model X570 Taichi.
>> After some tests I found out:
>> Kernel 5.4.0-99 works OK;
>> Kernel 5.4.0-100 has the problem;
>> Kernel 5.13.0-30 works OK;
>> Kernel 5.13.0-35 has the problem.
>=20
> It looks like your distro is backporting patches so the patch causing t=
he
> problem could be found by bisecting. While 5.4 kernel is an LTS kernel,=
 the
> latest release is 5.4.196... 5.4.0-100 is the distro version number whi=
ch does
> not tell me what set of patches it got on top of 5.4.0. These are not
> stable/vanilla kernels.
>=20
> To get help from this list, you will need to try with a vanilla kernel,=
 ideally
> from git. You could try the latest mainline 5.18 first to see if the pr=
oblem is
> there or not.

OK, will start working on it.  I never before tried a kernel not from
the repository, so I have to find out how to manage it.

>> Also, what AHCI adapter is this machine using (lspci) ?

Output from sudo lspci | grep -i ahci:

0b:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 51)
0c:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 51)


--------------SSEKb0v9TkJf6TErfuROGwmF--

--------------R8tpCTynJ0nZgsoCMFU7IYkD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEoR3751BhG/27nT45Zx3W/nHBYkoFAmKQkMoACgkQZx3W/nHB
YkqCvA//X4NCRsmnxnebFQrrhT7dgqsUPkuK1okliUeKRQ/KdPtKcum/noQbEtQY
E+JAPl2GSclq1mjarDLxHvSIjFBjRalcikCslQ9G7NqWwrA3SNNjJLB3XD/jimlu
GSZk+ZndMMrR8M1trMz8Ldnc+RaBtZnVxFinoGxFZ8R9skCb/GpmmYwHV0pAy27C
L8VxKVqScT5ur5aAbxZ88yuTiFQ8SMJ9wHzSnod0p3YMjAya1QMPGczcWLWUh/6L
H7A8FesMiZ0dCweKNMrJMpJtgT8OpEw7M16zqQvuAkpxAHrEp7ASsQYUhA8IIHf4
ouziUDWkve/Wo5ENhu7nnGvj3yyIwICYUoeEg1dRDwtX/oBXb6II5bWCobXBVkzU
JQI6prPiPo4pUUEgF+fQMXiDdHZWFfrJss5k8rZyNTkshVk+Rh4g24/5GqjCAAi+
KjoA4OYIoMi3eXlj2RFhQ8zrnRMr9x85rLple3htPCofXAvKQSiX9jvtdOwwlD5Z
FpMWXwRyA18/ZSsEyLyqb3bl0tqi8MUlYp54zLFK3BuxSlTkb8LYyjC4joReANxI
QoL2p676OSz00ruCdPe4SguIZbkVgYiRr4GWDxFzFDKB1MSvl7FPxUPw2eM8CJ5S
6ibh72cI0BAaPxwBb7Il8lLIaVZJIhQ8pC/MpkV355iysudxMVg=
=KG+N
-----END PGP SIGNATURE-----

--------------R8tpCTynJ0nZgsoCMFU7IYkD--
