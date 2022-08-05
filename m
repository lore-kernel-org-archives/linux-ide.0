Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AABAC00140
	for <linux-ide@archiver.kernel.org>; Fri,  5 Aug 2022 10:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbiHEKfU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 5 Aug 2022 06:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiHEKfT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 5 Aug 2022 06:35:19 -0400
X-Greylist: delayed 4616 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Aug 2022 03:35:15 PDT
Received: from se16-yh-out2.route25.eu (se16-yh-out2.route25.eu [IPv6:2a01:b941:2::62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F3EF4F
        for <linux-ide@vger.kernel.org>; Fri,  5 Aug 2022 03:35:15 -0700 (PDT)
Message-ID: <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
Date:   Fri, 5 Aug 2022 11:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Multiple errors with DVD drive
Content-Language: en-US
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
To:     linux-ide@vger.kernel.org
From:   "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
In-Reply-To: <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qzaSM8OrQOl0orY0F5jcEAcH"
X-PPP-Message-ID: <20220805091815.24892.35621@server108.yourhosting.nl>
X-PPP-Vhost: staalenberk.nl
X-Originating-IP: 185.37.71.73
X-SpamExperts-Domain: filter.yourhosting.nl
X-SpamExperts-Username: 185.37.71.73
Authentication-Results: route25.eu; auth=pass smtp.auth=185.37.71.73@filter.yourhosting.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8iHlCDkcQlgZqRd8B5qKcZPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wbKGKgvDNtko52zmlKj9u4U2Itm39BdCc4FEP6OrUewhPm
 p87GC1OZvsh7yKER8srNH7mON6woshjmJcagCejweb4o0/MLsfRXq2B6Bj1eqLdRg4TfZq2twbxK
 ne3bTxREkSF2RwjLlNyLHQr71RxeYzDzG2yBl+P6SMBMGH3GzsLLWVdJsjFn8sL+siZ0cSXt6JtT
 TglxNZAq/da6Ra+kAsc9Agw59L8q416i9sn+77m2yKklKs/xwV8kE9t47ZiZOZh/196Uh/xDSW9g
 kA3LEWgKIJ7Ay0RVJqlA03GHx7ObK052/jLuewOcI5amMxstChAJ8MhPXbXvhZAyklffRAwX31WV
 Y5lWjWxuGSRuxbb9wsrnUxyV5R6XweswXiYy2dhy85T3A96mF1Evp4++cd3QbXHil9nVohJvu6B5
 vcQRHhpp7PEHhQA50A063668oLWVcEFIP6cB4qvhjDlE8SRu8s3H6BxpZmNpeigyegX81Q2b6Us7
 siSVRTTv3earEPGaUfvTQD8mTYnm5Vyb/eB36XvbBuC1U1srT4VxcBqZR3KVQgqF/fPYYAfEfsg1
 1Ad23U0cZ9WVVTbpTmmUCjW9Rz3JU7/b93qIWlguFUPbvROIR24PU6MvaCAx81nmzfV669FmRwFs
 RSOwswyQAcVCbFO9oZq2JrkUu2Y0bcen5bW2mj7gpl+Nel82aV6t85jdQ1W7xM52M4KvSDibJS8X
 NHE22jNoXXtgm8Rhij9YHcdrxh7ntAaPP6XHE+t6TDWcyxXYrwAVfXzJhtGIEeg2ciYIQrf8qTZB
 4wuZmyG7X+t1TW39Ja77LGPpOwAT4kZm3AYrwwubjkeENJKdbGMwes7NyHuYBdQjd1YteIi7YBpB
 LYUph4jPimJS/7Zi/131P3mdLzgr+UhVxYKZoSyaA1TzQpMNBxbB7RLiYFYq922Wf+VLnUUJCa5X
 EkPBdYzH5SHs7OXwC7D2RhUaKfhganupwSWw7cas29IGI3Ms1dwieR5pqJIe+glXHys9mi+FbRwZ
 y3X+fQbaXDYb
X-Report-Abuse-To: spam@semaster01.route25.eu
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qzaSM8OrQOl0orY0F5jcEAcH
Content-Type: multipart/mixed; boundary="------------E10jqpURtImLFt9Xh8Zi0c0N";
 protected-headers="v1"
From: "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
To: linux-ide@vger.kernel.org
Message-ID: <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
Subject: Re: Multiple errors with DVD drive
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
In-Reply-To: <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>

--------------E10jqpURtImLFt9Xh8Zi0c0N
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

This morning I tried the 5.19 kernel from
https://kernel.ubuntu.com/~kernel-ppa/mainline/?C=3DN;O=3DD

The result regarding the problem with my optical drive still exists.

With kind regards,

Jaap Berkhout.

On 27-05-2022 12:32, J.J. Berkhout wrote:
> Hello,
>=20
> On 27-05-2022 01:36, Damien Le Moal wrote:
>> On 2022/05/26 21:38, J.J. Berkhout wrote:
> .
> .
>>> The problem is:
>>> After going from Linux Mint 19.3 Cinnamon kernel 5.4.0-97 to Linux Mi=
nt
>>> 20.3 Cinnamon kernel 5.4.0-107 I discovered that I could not (reliabl=
y)
>>> access my optical drive anymore.
>>> It produces errors like:
>>> 	ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x40d0000 action 0xe fro=
zen
>>> 	ata1: SError: { PHYRdyChg CommWake 10B8B DevExch }
>>> 	ata1.00: cmd a0/00:00:00:00:fc/00:00:00:00:00/a0 tag 0 pio 131072 in=

>>>          Read(10) 28 00 00 00 05 61 00 00 40 00res
>>> 50/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)
>>> 	blk_update_request: I/O error, dev sr0, sector 5508 op 0x0:(READ) fl=
ags
>>> 0x80700 phys_seg 19 prio class 0
>>> 	ata1.00: failed to set xfermode (err_mask=3D0x1)
>>>
>>> The system was Linux Mint 20.3 Cinnamon with kernel 5.4.0-107-generic=
,
>>> mobo ASRock model X570 Taichi.
>>> After some tests I found out:
>>> Kernel 5.4.0-99 works OK;
>>> Kernel 5.4.0-100 has the problem;
>>> Kernel 5.13.0-30 works OK;
>>> Kernel 5.13.0-35 has the problem.
>>
>> It looks like your distro is backporting patches so the patch causing =
the
>> problem could be found by bisecting. While 5.4 kernel is an LTS kernel=
, the
>> latest release is 5.4.196... 5.4.0-100 is the distro version number wh=
ich does
>> not tell me what set of patches it got on top of 5.4.0. These are not
>> stable/vanilla kernels.
>>
>> To get help from this list, you will need to try with a vanilla kernel=
, ideally
>> from git. You could try the latest mainline 5.18 first to see if the p=
roblem is
>> there or not.
>=20
> OK, I installed kernel 5.18.0 with 'mainline' (Ubuntu Mainline Kernel
> Installer).
> Kernel installed was 5.18.0-051800.202205222030.
> Same problem existed.
> I reverted to the ubuntu 5.13.0-30 kernel.
> A copy of the dmesg output is attached.
>=20
> With kind regards,
>=20
> Jaap Berkhout.

--------------E10jqpURtImLFt9Xh8Zi0c0N--

--------------qzaSM8OrQOl0orY0F5jcEAcH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEoR3751BhG/27nT45Zx3W/nHBYkoFAmLs4DsACgkQZx3W/nHB
YkplAg//SXGkMyG2oEfsdLscU4PUGbmJR4ufkvtUhE7KcBBYxx+k0s4neXS2AaxD
H74ETHnR2iBXxxItBpw2tjuOIvzPA/C83lC1jZW9dWN69Bzo8KwOXzH2u+4xo48i
v6ooViGRDXZxZscKMxEJXN75BBjRB4FUP3IBmIhkl8Bc3QIVP6Ujaf+gQpTEoLAu
EjsMXwEov+9W2OgErLrTspZs3FMhXk4k1vSXvDtS7fDuNXK5g0OT/QGi6O4y6qDY
/CSUtJHEUs4LK/ym0v0zsVSlfWzmcYPAwXbW5Qh4fZdXffgFjtb+Y4GNc0tzOWlV
p77iPmsYn3m9vDjxJIzBBqjy2G0UUSWdwbnkDUzd7Jr/veQAmcWDGFIhDteooz//
pu7oeCmInirno/QR4AliC8qKcg19oeuR6Y0PXIc59IIHhpN3f+jKE9KxArGVgwmV
Sjvs3uJxXBfXOAIHYI8ax0Jg7+G6olK10YCUge0EvgR34SjxhMaWNv9KNXPmcgO8
3AHIiqOAZ4u/iqBhHSV596gW11YolauPF0YV4iSZkQCK7mpwyLcn9t64rf72lQ0I
S8UUMSugXn+M/KBClHrpctzSBBkyNRzPZCUHzQ/aZ1wACgaIzmuG0jnpaDUAyciv
gHQnzWOqDm1alwnWqLfg/kKK1s6i41Dx5O8pITgRZS7ugJGP34k=
=DXo3
-----END PGP SIGNATURE-----

--------------qzaSM8OrQOl0orY0F5jcEAcH--
