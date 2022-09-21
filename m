Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8026AECAAD8
	for <linux-ide@archiver.kernel.org>; Wed, 21 Sep 2022 14:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiIUO5K (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 21 Sep 2022 10:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiIUO4X (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2022 10:56:23 -0400
Received: from se21-yh-out2.route25.eu (se21-yh-out2.route25.eu [IPv6:2a01:b941:2::57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22636C123
        for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2022 07:55:21 -0700 (PDT)
Message-ID: <d1683a01-005a-3588-a63d-e52781275516@staalenberk.nl>
Date:   Wed, 21 Sep 2022 16:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Multiple errors with DVD drive
Content-Language: en-US
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
 <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
 <Yym65wlizZydJ/Tn@x1-carbon>
 <9756ac37-6790-7b83-5840-abe04f8ab838@staalenberk.nl>
 <Yyor5zsqHAoNimF3@x1-carbon>
 <f3111c18-704b-1845-1d39-e220642eec34@staalenberk.nl>
 <Yyr8aV5CEOuChpre@x1-carbon>
 <e9893bab-f2af-bae0-18df-924f9ff4652f@staalenberk.nl>
To:     linux-ide@vger.kernel.org
From:   "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
In-Reply-To: <e9893bab-f2af-bae0-18df-924f9ff4652f@staalenberk.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3SpZreKYCMxZrqYdchushBAu"
X-PPP-Message-ID: <20220921145517.6059.25956@server108.yourhosting.nl>
X-PPP-Vhost: staalenberk.nl
X-Originating-IP: 185.37.71.73
X-SpamExperts-Domain: filter.yourhosting.nl
X-SpamExperts-Username: 185.37.71.73
Authentication-Results: route25.eu; auth=pass smtp.auth=185.37.71.73@filter.yourhosting.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.05)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8YSbZel1yDd5EU2iBI90sIPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wbKGKgvDNtko52zmlKj9u4U2Itm39BdCc4FEP6OrUewhPm
 p87GC1OZvsh7yKER8srmI2BiYodkYGBMdWyjOHkBeb4o0/MLsfRXq2B6Bj1eqLdRg4TfZq2twbxK
 ne3bTxREkSF2RwjLlNyLHQr71RxeYzDzG2yBl+P6SMBMGH3GzhZ53TcoV3yK32bHTR6GRn3t6JtT
 TglxNZAq/da6Ra+kzsLfXfprfrktIHePOCuQY7m2yKklKs/xwV8kE9t47ZiZOZh/196Uh/xDSW9g
 kA3LEWgKIJ7Ay0RVJqlA03GHx7ObK052/jLuewOcI5amMxstChAJ8MhPXbXvhZAyklffRAwX31WV
 Y5lWjWxuGSRuxbb9wsrnUxyV5R6XweswXiYy2dhy85T3A96mF1Evp4++cd3QbXHil9nVohJvu6B5
 vcQRHhpp7PEHhQA50A063668oLWVcEFIP6cB4qvhjDlE8SRu8s3H6BxpZmNpeigyegX81Q2b6Us7
 siSVRTTv3earEPGaUfvTQD8mTYnm5Vyb/eB36XvbBuC1U1srT4VxcBqZR3KVQgqF/fPYYAfEfsg1
 1Ad23U0cZ9WVVTbpTmmUCiVDPWVg2jC+Q3dCispdoz8BY8aNT8azziAnFylBxLPmzfV669FmRwFs
 RSOwswyQAcVCbFO9oZq2JrkUu2Y0bcen5bW2mj7gpl+Nel82aV6t85jdQ1W7xM52M4KvSDibJS8X
 NHE22jNoXXtgm8Rhij9YHcdrxh7ntAaPP6XHE+u7xS0WDw/IGcY7vSWOyzoCSHa9Wtinw9ABNti+
 VLYjeyG7X+t1TW39Ja77LGPpOwAT4kZm3AYrwwubjkeENJKdbGMwes7NyHuYBdQjd1YteIi7YBpB
 LYUph4jPimJS/7Zi/131P3mdLzgr+UhVxYKZoSyaA1TzQpMNBxbB7RLiYFYq922Wf+VLnUUJCa5X
 EkPBdYzH5SHs7OXwC7D2RhUaKfhganupwSWw7cas29IGI3Ms1dwieR5pqJIe+glXHys9mi+FbRwZ
 y3X+fQbaXDYb
X-Report-Abuse-To: spam@semaster01.route25.eu
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3SpZreKYCMxZrqYdchushBAu
Content-Type: multipart/mixed; boundary="------------mvb8Yf0M6bZhBSWFm3ZZx3W7";
 protected-headers="v1"
From: "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
To: linux-ide@vger.kernel.org
Message-ID: <d1683a01-005a-3588-a63d-e52781275516@staalenberk.nl>
Subject: Re: Multiple errors with DVD drive
References: <c7e0c932-2e20-18b5-fe9f-36572807f59b@staalenberk.nl>
 <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
 <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
 <Yym65wlizZydJ/Tn@x1-carbon>
 <9756ac37-6790-7b83-5840-abe04f8ab838@staalenberk.nl>
 <Yyor5zsqHAoNimF3@x1-carbon>
 <f3111c18-704b-1845-1d39-e220642eec34@staalenberk.nl>
 <Yyr8aV5CEOuChpre@x1-carbon>
 <e9893bab-f2af-bae0-18df-924f9ff4652f@staalenberk.nl>
In-Reply-To: <e9893bab-f2af-bae0-18df-924f9ff4652f@staalenberk.nl>

--------------mvb8Yf0M6bZhBSWFm3ZZx3W7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,



On 21-09-2022 14:38, J.J. Berkhout wrote:
> On 21-09-2022 13:58, Niklas Cassel wrote:
>> Another way do disable lpm is to do:
>>
>> $ ls -al /sys/class/scsi_host/host*
>>
>> Find your device in the list. My device is:
>> /sys/class/scsi_host/host13/
>>
>> Print the current lpm policy for your device:
>> $ cat /sys/class/scsi_host/host13/link_power_management_policy
>> med_power_with_dipm
>>
>> Anything other than "max_performance" means that you have (a varying d=
egree)
>> of low power modes enabled.
>>
>> $ sudo sh -c "echo max_performance > /sys/class/scsi_host/host13/link_=
power_management_policy"
>>
>> $ cat /sys/class/scsi_host/host13/link_power_management_policy=20
>> max_performance
>>
>> Try reading from the optical drive after ensuring that the policy is
>> "max_performance".
>>
>=20
> Yes, this worked and did the trick!  Reading without any errors.  I did=

> not yet try to write, but will do so today.

I just wrote two Blu-Ray disks without problems.
Perfect.

Jaap Berkhout.

--------------mvb8Yf0M6bZhBSWFm3ZZx3W7--

--------------3SpZreKYCMxZrqYdchushBAu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEoR3751BhG/27nT45Zx3W/nHBYkoFAmMrJb4ACgkQZx3W/nHB
YkpH8Q/8D8LBD6A8pLcY0ur5ZDa6N+oQOxsjyE540lI/LSbPGC2nXra8q9gUY03w
86bK+Gr3dhid3WxDlf7kNNMS0YVdyoVZOUnEGblxC9lXb5uwpKH9zrhLW8ST/qXl
sX+KDKA9CNxDqp7dYB2l04jtvSjsiUyRnV8+MmQIpEWoMCsLnbw+KvW7b1PL4O7H
4KbTNj38HYu5Pfz3pFBtsnKQTliKqx6tf+Qj4C0eDjW5y5xM/yr2LoCo/2P5nC1a
NKN/VqwZUrEKPdgX92IYRVgQi4VUrk6aE0NLVraHtwzj87GdkI+zFT6AxWI+CdK5
i6WSZJWHQZZt/aSO+VXqCAkxb4Nna9JjWQZBXR/ubfimBfPK+Luk4BhK2Ot63l+h
3TiM/redHq42Uq1IY788XmaYp5X1NWeSEFFplqZp0HOR8m3bumqn0KZbhcpCz/FM
QPBEnN73GZEHaf7iOK16pAj0VXqwbIf739n4vyGNtlJ3fijZ/x9zBaXj1jYmthso
zN3+KG6S90FYqzj1b4/YANPHvkGv9duFisiVWFQfMdV7Z1rOzDTn8wkgr5X03H8p
Y8CjLoZeiHdTy3jI3OxPXB/+PkY1WUqwarfKQZtB9HuU+hbC5udcJqCwCTk9WlvC
1Wr+Yp7kTAJ4bLf/hsI/dlmOxCsVMfAaXRWaSwsM4wbz/1vxC6w=
=6tfH
-----END PGP SIGNATURE-----

--------------3SpZreKYCMxZrqYdchushBAu--
