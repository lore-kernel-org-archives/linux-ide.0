Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E86BC54EE9
	for <linux-ide@archiver.kernel.org>; Tue, 20 Sep 2022 11:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiITLWM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Sep 2022 07:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiITLWL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2022 07:22:11 -0400
X-Greylist: delayed 4514 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 04:22:05 PDT
Received: from se18-yh-out3.route25.eu (se18-yh-out3.route25.eu [IPv6:2a01:b941:2::92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06A15F202
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2022 04:22:05 -0700 (PDT)
Message-ID: <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
Date:   Tue, 20 Sep 2022 12:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Multiple errors with DVD drive
Content-Language: en-US
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
To:     linux-ide@vger.kernel.org
From:   "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
In-Reply-To: <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------J9xRkEe5phmJS7k4FHBUCZs2"
X-PPP-Message-ID: <20220920100644.31021.47485@server108.yourhosting.nl>
X-PPP-Vhost: staalenberk.nl
X-Originating-IP: 185.37.71.73
X-SpamExperts-Domain: filter.yourhosting.nl
X-SpamExperts-Username: 185.37.71.73
Authentication-Results: route25.eu; auth=pass smtp.auth=185.37.71.73@filter.yourhosting.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8he+etP8JO5OSMxyohwXhDPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wbKGKgvDNtko52zmlKj9u4U2Itm39BdCc4FEP6OrUewhPm
 p87GC1OZvsh7yKER8soP7BuBHZFKGBjWKEx56lCaeb4o0/MLsfRXq2B6Bj1eqLdRg4TfZq2twbxK
 ne3bTxREkSF2RwjLlNyLHQr71RxeYzDzG2yBl+P6SMBMGH3GzhZ53TcoV3yK32bHTR6GRn3t6JtT
 TglxNZAq/da6Ra+kPW9eZUrl1cUPp5JEW8+O1Lm2yKklKs/xwV8kE9t47ZiZOZh/196Uh/xDSW9g
 kA3LEWgKIJ7Ay0RVJqlA03GHx7ObK052/jLuewOcI5amMxstChAJ8MhPXbXvhZAyklffRAwX31WV
 Y5lWjWxuGSRuxbb9wsrnUxyV5R6XweswXiYy2dhy85T3A96mF1Evp4++cd3QbXHil9nVohJvu6B5
 vcQRHhpp7PEHhQA50A063668oLWVcEFIP6cB4qvhjDlE8SRu8s3H6BxpZmNpeigyegX81Q2b6Us7
 siSVRTTv3earEPGaUfvTQD8mTYnm5Vyb/eB36XvbBuC1U1srT4VxcBqZR3KVQgqF/fPYYAfEfsg1
 1Ad23U0cZ9WVVTbpTmmUNhQc00X22M9a1uA8dEkub42iQEC45ux3Gf0FJiZERhPmzfV669FmRwFs
 RSOwswyQAcVCbFO9oZq2JrkUu2Y0bcen5bW2mj7gpl+Nel82aV6t85jdQ1W7xM52M4KvSDibJS8X
 NHE22jNoXXtgm8Rhij9YHcdrxh7ntAaPP6XHE+vgr6j+YgoCZHsu5aitBbwluJor0hUVT4oNwfB1
 lWA6FiG7X+t1TW39Ja77LGPpOwAT4kZm3AYrwwubjkeENJKdbGMwes7NyHuYBdQjd1YteIi7YBpB
 LYUph4jPimJS/7Zi/131P3mdLzgr+UhVxYKZoSyaA1TzQpMNBxbB7RLiYFYq922Wf+VLnUUJCa5X
 EkPBdYzH5SHs7OXwC7D2RhUaKfhganupwSWw7cas29IGI3Ms1dwieR5pqJIe+glXHys9mi+FbRwZ
 y3X+fQbaXDYb
X-Report-Abuse-To: spam@semaster01.route25.eu
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------J9xRkEe5phmJS7k4FHBUCZs2
Content-Type: multipart/mixed; boundary="------------ZMNBQZOFSufO8LrmeYbSNVT6";
 protected-headers="v1"
From: "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
To: linux-ide@vger.kernel.org
Message-ID: <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
Subject: Re: Multiple errors with DVD drive
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
In-Reply-To: <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>

--------------ZMNBQZOFSufO8LrmeYbSNVT6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 05-08-2022 11:17, J.J. Berkhout wrote:

Hello,

This morning I updated my motherboard (ASRock model X570 Taichi) from
UEFI v. 3.60 to UEFI 4.80. Update went perfectly, but did not solve the
problem with my optical drive.  I am at a loss how to proceed next.
Any suggestions?

With kind regards,

Jaap Berkhout


> Hello,
>=20
> This morning I tried the 5.19 kernel from
> https://kernel.ubuntu.com/~kernel-ppa/mainline/?C=3DN;O=3DD
>=20
> The result regarding the problem with my optical drive still exists.
>=20
> With kind regards,
>=20
> Jaap Berkhout.
>=20
> On 27-05-2022 12:32, J.J. Berkhout wrote:
>> Hello,
>>
>> On 27-05-2022 01:36, Damien Le Moal wrote:
>>> On 2022/05/26 21:38, J.J. Berkhout wrote:
>> .
>> .
>>>> The problem is:
>>>> After going from Linux Mint 19.3 Cinnamon kernel 5.4.0-97 to Linux M=
int
>>>> 20.3 Cinnamon kernel 5.4.0-107 I discovered that I could not (reliab=
ly)
>>>> access my optical drive anymore.
>>>> It produces errors like:
>>>> 	ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xe fr=
ozen
>>>> 	ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
>>>> 	ata1.00: cmd a0/00:00:00:00:fc/00:00:00:00:00/a0 tag 0 pio 131072 i=
n
>>>>          Read(10) 28 00 00 00 05 61 00 00 40 00res
>>>> 50/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)
>>>> 	blk_update_request: I/O error, dev sr0, sector 5508 op 0x0:(READ) f=
lags
>>>> 0x80700 phys_seg 19 prio class 0
>>>> 	ata1.00: failed to set xfermode (err_mask=3D0x1)
>>>>
>>>> The system was Linux Mint 20.3 Cinnamon with kernel 5.4.0-107-generi=
c,
>>>> mobo ASRock model X570 Taichi.
>>>> After some tests I found out:
>>>> Kernel 5.4.0-99 works OK;
>>>> Kernel 5.4.0-100 has the problem;
>>>> Kernel 5.13.0-30 works OK;
>>>> Kernel 5.13.0-35 has the problem.
>>>
>>> It looks like your distro is backporting patches so the patch causing=
 the
>>> problem could be found by bisecting. While 5.4 kernel is an LTS kerne=
l, the
>>> latest release is 5.4.196... 5.4.0-100 is the distro version number w=
hich does
>>> not tell me what set of patches it got on top of 5.4.0. These are not=

>>> stable/vanilla kernels.
>>>
>>> To get help from this list, you will need to try with a vanilla kerne=
l, ideally
>>> from git. You could try the latest mainline 5.18 first to see if the =
problem is
>>> there or not.
>>
>> OK, I installed kernel 5.18.0 with 'mainline' (Ubuntu Mainline Kernel
>> Installer).
>> Kernel installed was 5.18.0-051800.202205222030.
>> Same problem existed.
>> I reverted to the ubuntu 5.13.0-30 kernel.
>> A copy of the dmesg output is attached.
>>
>> With kind regards,
>>
>> Jaap Berkhout.

--------------ZMNBQZOFSufO8LrmeYbSNVT6--

--------------J9xRkEe5phmJS7k4FHBUCZs2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEoR3751BhG/27nT45Zx3W/nHBYkoFAmMpkIUACgkQZx3W/nHB
Ykr1fRAAhF/dVTQZt0VMvcf/ct09ZpzQazWhuX8kTYR5pAM/6RtXYTcwfF/EKf11
S0sIR5QqMUtq4CdkPOkiPdXOT5Gy1bzO/YDwC9e8jK2ffpkIHSR+ilsGqoCct4iH
1G7xbQueqJ+QSM1/xPCgT0a29Q8sQSWKqOsI6lZ2dyIqo04MdzPToYF+SfP79Lfi
vB87+l4yWXNsYLoSGassbzXUTTo/nI7TH5mJX963/F8/E/UR8mKIwgnCiQyRXicW
zAOVSeev9tJhiXvczhbA0jNkVg1rzPr6G8WToZrTcBbJOgAgOBGk0W+AM/wPsI+N
HeuvxVBN5b8C7e11A8OhbPQ0O3Yy1MYuhtZ/Mi2Py9cO2q4cy9Bh6XrQbM9u8pVE
xB1v47O9Z8vvooTWyyIHz92RlbUrxBr6ErVD+PZdpAXLoG5kbV72aOtjAClHbkKf
gQiiSUBhtjo1pSPSlRdHis7vpKM0y5jULWo5bvMbxFDWwRI1Ns060sNV0hW57P6U
ebzBPk+jpionNeCLU7ZPOcteutERG1NAOe4ZzQBRtH7+VwymU28XUITWyjRjfrMq
SvCV+clw1NGiMxg7AyNpAd0OwXa1vpVHJLwWdtWR4t2jdwi9lE3cY2Pd5FwKFiv1
l4uQSOWlPLRiCxyA1ON0mlTq5w+bXyDKfHu4vdT7Dv8QPK3dFak=
=Rqdc
-----END PGP SIGNATURE-----

--------------J9xRkEe5phmJS7k4FHBUCZs2--
