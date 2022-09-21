Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998B9C32771
	for <linux-ide@archiver.kernel.org>; Wed, 21 Sep 2022 10:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiIUK3L (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 21 Sep 2022 06:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIUK3I (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2022 06:29:08 -0400
Received: from se21-yh-out2.route25.eu (se21-yh-out2.route25.eu [IPv6:2a01:b941:2::57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1689E18B03
        for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2022 03:29:05 -0700 (PDT)
Message-ID: <f3111c18-704b-1845-1d39-e220642eec34@staalenberk.nl>
Date:   Wed, 21 Sep 2022 12:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
 <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
 <Yym65wlizZydJ/Tn@x1-carbon>
 <9756ac37-6790-7b83-5840-abe04f8ab838@staalenberk.nl>
 <Yyor5zsqHAoNimF3@x1-carbon>
To:     linux-ide@vger.kernel.org
From:   "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
Subject: Re: Multiple errors with DVD drive
In-Reply-To: <Yyor5zsqHAoNimF3@x1-carbon>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------r6PPXCVd1N2AE4NJcMh0fLnb"
X-PPP-Message-ID: <20220921102858.17828.5209@server108.yourhosting.nl>
X-PPP-Vhost: staalenberk.nl
X-Originating-IP: 185.37.71.73
X-SpamExperts-Domain: filter.yourhosting.nl
X-SpamExperts-Username: 185.37.71.73
Authentication-Results: route25.eu; auth=pass smtp.auth=185.37.71.73@filter.yourhosting.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9oY0+k+yK5UKoEle24QRrBPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wbKGKgvDNtko52zmlKj9u4U2Itm39BdCc4FEP6OrUewhPm
 p87GC1OZvsh7yKER8sri5bXzK/hVMZvCSPO6mSU+eb4o0/MLsfRXq2B6Bj1eqLdRg4TfZq2twbxK
 ne3bTxREkSF2RwjLlNyLHQr71RxeYzDzG2yBl+P6SMBMGH3GzhZ53TcoV3yK32bHTR6GRn3t6JtT
 TglxNZAq/da6Ra+kzsLfXfprfrktIHePOCuQY7m2yKklKs/xwV8kE9t47ZiZOZh/196Uh/xDSW9g
 kA3LEWgKIJ7Ay0RVJqlA03GHx7ObK052/jLuewOcI5amMxstChAJ8MhPXbXvhZAyklffRAwX31WV
 Y5lWjWxuGSRuxbb9wsrnUxyV5R6XweswXiYy2dhy85T3A96mF1Evp4++cd3QbXHil9nVohJvu6B5
 vcQRHhpp7PEHhQA50A063668oLWVcEFIP6cB4qvhjDlE8SRu8s3H6BxpZmNpeigyegX81Q2b6Us7
 siSVRTTv3earEPGaUfvTQD8mTYnm5Vyb/eB36XvbBuC1U1srT4VxcBqZR3KVQgqF/fPYYAfEfsg1
 1Ad23U0cZ9WVVTbpTmmUCiVDPWVg2jC+Q3dCispdo7K2OnTTSVgJjii06gIZmdfmzfV669FmRwFs
 RSOwswyQAcVCbFO9oZq2JrkUu2Y0bcen5bW2mj7gpl+Nel82aV6t85jdQ1W7xM52M4KvSDibJS8X
 NHE22jNoXXtgm8Rhij9YHcdrxh7ntAaPP6XHE+vIdknPBYCDoi7O+Lw5WvtEHtwgD4+ICMGPg9vH
 +YntSiG7X+t1TW39Ja77LGPpOwAT4kZm3AYrwwubjkeENJKdbGMwes7NyHuYBdQjd1YteIi7YBpB
 LYUph4jPimJS/7Zi/131P3mdLzgr+UhVxYKZoSyaA1TzQpMNBxbB7RLiYFYq922Wf+VLnUUJCa5X
 EkPBdYzH5SHs7OXwC7D2RhUaKfhganupwSWw7cas29IGI3Ms1dwieR5pqJIe+glXHys9mi+FbRwZ
 y3X+fQbaXDYb
X-Report-Abuse-To: spam@semaster01.route25.eu
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------r6PPXCVd1N2AE4NJcMh0fLnb
Content-Type: multipart/mixed; boundary="------------rPLPrn0z0TMvd8ym79AisXqa";
 protected-headers="v1"
From: "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
To: linux-ide@vger.kernel.org
Message-ID: <f3111c18-704b-1845-1d39-e220642eec34@staalenberk.nl>
Subject: Re: Multiple errors with DVD drive
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
 <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
 <Yym65wlizZydJ/Tn@x1-carbon>
 <9756ac37-6790-7b83-5840-abe04f8ab838@staalenberk.nl>
 <Yyor5zsqHAoNimF3@x1-carbon>
In-Reply-To: <Yyor5zsqHAoNimF3@x1-carbon>

--------------rPLPrn0z0TMvd8ym79AisXqa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 20-09-2022 23:08, Niklas Cassel wrote:
> Readding linux-ide to CC.
>=20
> On Tue, Sep 20, 2022 at 06:23:07PM +0200, J.J. Berkhout wrote:
>> Hello,
>>
>> Thanks for looking into this.
>> I do not see anything like "ASMT109x-".
>> Output of lsscsi:
>>
>> [0:0:0:0]    cd/dvd  PIONEER  BD-RW   BDR-207M 1.60  /dev/sr0 [11:0]
>=20
> Ok, then we can rule out the patch that adds the ASMT109x quirk.
>=20
>>
>> The output with the last non-working kernel is the same.
>>
>> Concerning the patch: I do not (yet) known how to apply it.  Help woul=
d
>> very much be appreciated.
>=20
> Basically:
> git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
> cd linux
>=20
> Try to copy the running kernel's config:
> zcat /proc/config.gz > .config
>=20
> If that didn't work, try copying the config file from /boot:
> cp /boot/config-$(uname -r) .config
>=20
> Since the patch is only one line, you can apply it manually now.
> (Note that there are three spaces between "BD-RW   BDR-207M".)
>=20
> make olddefconfig
> make -j$(nproc)
>=20
> sudo make modules_install
> sudo make install
>=20
>=20
>=20
> Looking at the logs in the bug report, you do have a AMD Green Sardine
> AHCI controller.
>=20
> The commit 1527f69204fe ("ata: ahci: Add Green Sardine vendor ID as
> board_ahci_mobile") added the PCI vendor and device id to the list of
> supported AHCI controllers using the low power board version:
> 	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardi=
ne */
>=20
> Before the commit in question, your AHCI controller relied on this
> catch-all entry:
> 	/* Generic, PCI class code for AHCI */
> 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
> which does not enable/allow any low power mode at all.
>=20
> Now, I do think that low power modes *should* work with this AHCI
> controller. Most likely, it is simply the optical drive that does
> not work well when the HBA initiates a low power mode on the link.
>=20
> You should be able to test this theory by adding libata.force=3Dnolpm
> on the kernel command line on a recent (non-working) kernel, low power
> modes should then be disabled, and the drive should work again.
> (You can press 'e' in grub to temporarily add something to the kernel
> command line, and then ctrl+x to boot.)
>=20
> But the proper fix is probably to add a quirk for you device, either:
> +       { "PIONEER BD-RW   BDR-207M",   NULL,   ATA_HORKAGE_NOSETXFER }=
,
> or
> +       { "PIONEER BD-RW   BDR-207M",   NULL,   ATA_HORKAGE_NOLPM },
>=20
>=20
> Kind regards,
> Niklas

I just tested the libata.force=3Dnolpm kernel parameter on my system
running kernel 5.15.0-48-generic x86_64 (linux mint 20.3, base Ubuntu
20.04 focal).  I am sorry to say, this parameter did not solve the proble=
m.

As for your patch concerning NOSETXFER, I will try to test this shortly,
but it could take one or two days (medical stuff for me and my wife).

Thanks for your help.
With kind regards,

Jaap Berkhout

--------------rPLPrn0z0TMvd8ym79AisXqa--

--------------r6PPXCVd1N2AE4NJcMh0fLnb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEoR3751BhG/27nT45Zx3W/nHBYkoFAmMq51IACgkQZx3W/nHB
YkpiJxAAszjY95s47EGZ7Xi6b3csapaDKsUioGwxG5RtRTM8d0F7qkgw5mKXNLRs
JNEckxFfMiFuL9T4+LdR9kx+K0pK263AXdyVAEK6c67TyQ7s4dE8tgwhQFfIOPhj
55hF/CuJWfMrBA5dhGrMu93NP4jGQ7gQr6KAJf0EKRv2ZhiOGwEFcxO5IlecLtRW
vmK8suzWATFscFKB+n0ljLOII8oGvtO01z/KAWkUeDtOY6NMGOov/7qxTz4yNhcB
q+y2l3tOf3xwxlrxmuCl1fpF1Ew9CaX98/F8MorcnpYy8Dr8hxy78np1e/MhXWlj
CIPidp6spCPLpXAsPdbmyuiq/GI26nvLqD/Bia7FuiiZ2L0dHeaDdLgBPPYLyfwB
f2SqJjePVBRp2j2BHPTzCEBLSwH8rPa9vTZbVQKSH17eKnimPcol9KP3wNK1D/H4
sArd3lWV2FTm6FBNYnh4qNdG6A992AH3nBshHunrl+34V77JR3R5YMKBHWviblow
idaGfSjf2q7QX1oW/WtCFmdO+KPf5GLEO2da8PMhiUHxOy5IjcyLqK23SPvz+dHJ
AhQ5XeDMlPCnL/+55U8XUZU08xfjG9sOpCIKWp1sfCByI9M5bym0HlLrhdGt610b
ODvtqUM9I3ZmdnTY27arzfRgRFA9poz2BTC5L2Ig+XLy/cwrcbA=
=Qm5J
-----END PGP SIGNATURE-----

--------------r6PPXCVd1N2AE4NJcMh0fLnb--
