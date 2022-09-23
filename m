Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37062C6FA82
	for <linux-ide@archiver.kernel.org>; Fri, 23 Sep 2022 12:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiIWMOU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 23 Sep 2022 08:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiIWMMT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 23 Sep 2022 08:12:19 -0400
Received: from se18-yh-out3.route25.eu (se18-yh-out3.route25.eu [IPv6:2a01:b941:2::92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0810A131987
        for <linux-ide@vger.kernel.org>; Fri, 23 Sep 2022 05:08:27 -0700 (PDT)
Message-ID: <223632d5-6d6f-f957-0a27-0b5b5d5ad91a@staalenberk.nl>
Date:   Fri, 23 Sep 2022 14:07:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     linux-ide@vger.kernel.org
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
 <4c72e57c-2544-1163-320d-0ec6420deef5@opensource.wdc.com>
From:   "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
Subject: Re: Multiple errors with DVD drive
In-Reply-To: <4c72e57c-2544-1163-320d-0ec6420deef5@opensource.wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AUOPSjuL8d0f3vgPmVWcJEJS"
X-PPP-Message-ID: <20220923120822.30848.58186@server108.yourhosting.nl>
X-PPP-Vhost: staalenberk.nl
X-Originating-IP: 185.37.71.73
X-SpamExperts-Domain: filter.yourhosting.nl
X-SpamExperts-Username: 185.37.71.73
Authentication-Results: route25.eu; auth=pass smtp.auth=185.37.71.73@filter.yourhosting.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9G0Yo2NKT9LLn1fylDth8WPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wbKGKgvDNtko52zmlKj9u4U2Itm39BdCc4FEP6OrUewhPm
 p87GC1OZvsh7yKER8srkPRhCHfaIFCgZzFXFfogheb4o0/MLsfRXq2B6Bj1eqLdRg4TfZq2twbxK
 ne3bTxREkSF2RwjLlNyLHQr71RxeYzDzG2yBl+P6SMBMGH3GzhZ53TcoV3yK32bHTR6GRn3t6JtT
 TglxNZAq/da6Ra+kPW9eZUrl1cUPp5JEW8+O1Lm2yKklKs/xwV8kE9t47ZiZOZh/196Uh/xDSW9g
 kA3LEWgKIJ7Ay0RVJqlA03GHx7ObK052/jLuewOcI5amMxstChAJ8MhPXbXvhZAyklffRAwX31WV
 Y5lWjWxuGSRuxbb9wsrnUxyV5R6XweswXiYy2dhy85T3A96mF1Evp4++cd3QbXHil9nVohJvu6B5
 vcQRHhpp7PEHhQA50A063668oLWVcEFIP6cB4qvhjDlE8SRu8s3H6BxpZmNpeigyegX81Q2b6Us7
 siSVRTTv3earEPGaUfvTQD8mTYnm5Vyb/eB36XvbBuC1U1srT4VxcBqZR3KVQgqF/fPYYAfEfsg1
 1Ad23U0cZ9WVVTbpTmmUNhQc00X22M9a1uA8dEkubzeHgSD9ia6LV/14NRzVRE/mzfV669FmRwFs
 RSOwswyQAcVCbFO9oZq2JrkUu2Y0bcen5bW2mj7gpl+Nel82aV6t85jdQ1W7xM52M4KvSDibJS8X
 NHE22jNoXXtgm8Rhij9YHcdrxh7ntAaPP6XHE+uXwmbidTh6i9oWjtiBfNqKrgNKNHhLyYQg4v16
 L7M/FSG7X+t1TW39Ja77LGPpOwAT4kZm3AYrwwubjkeENJKdbGMwes7NyHuYBdQjd1YteIi7YBpB
 LYUph4jPimJS/7Zi/131P3mdLzgr+UhVxYKZoSyaA1TzQpMNBxbB7RLiYFYq922Wf+VLnUUJCa5X
 EkPBdYzH5SHs7OXwC7D2RhUaKfhganupwSWw7cas29IGI3Ms1dwieR5pqJIe+glXHys9mi+FbRwZ
 y3X+fQbaXDYb
X-Report-Abuse-To: spam@semaster01.route25.eu
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AUOPSjuL8d0f3vgPmVWcJEJS
Content-Type: multipart/mixed; boundary="------------GYRUQI6J6FUowJKULJYI6xzc";
 protected-headers="v1"
From: "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
To: linux-ide@vger.kernel.org
Message-ID: <223632d5-6d6f-f957-0a27-0b5b5d5ad91a@staalenberk.nl>
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
 <4c72e57c-2544-1163-320d-0ec6420deef5@opensource.wdc.com>
In-Reply-To: <4c72e57c-2544-1163-320d-0ec6420deef5@opensource.wdc.com>

--------------GYRUQI6J6FUowJKULJYI6xzc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 23-09-2022 00:08, Damien Le Moal wrote:
> On 9/21/22 21:38, J.J. Berkhout wrote:
>> Hello,
>>
>>
>>
>> On 21-09-2022 13:58, Niklas Cassel wrote:
>>> Another way do disable lpm is to do:
>>>
>>> $ ls -al /sys/class/scsi_host/host*
>>>
>>> Find your device in the list. My device is:
>>> /sys/class/scsi_host/host13/
>>>
>>> Print the current lpm policy for your device:
>>> $ cat /sys/class/scsi_host/host13/link_power_management_policy
>>> med_power_with_dipm
>>>
>>> Anything other than "max_performance" means that you have (a varying =
degree)
>>> of low power modes enabled.
>>>
>>> $ sudo sh -c "echo max_performance > /sys/class/scsi_host/host13/link=
_power_management_policy"
>>>
>>> $ cat /sys/class/scsi_host/host13/link_power_management_policy=20
>>> max_performance
>>>
>>> Try reading from the optical drive after ensuring that the policy is
>>> "max_performance".
>>>
>>
>> Yes, this worked and did the trick!  Reading without any errors.  I di=
d
>> not yet try to write, but will do so today.
>> When booting with libata.force=3Dnolpm  the link_power_management_poli=
cy
>> was still med_power_with_dipm and I got the dmesg:
>>
>> [    0.291452] ata: failed to parse force parameter "nolpm" (unknown v=
alue)
>=20
> What kernel version are you running ? This should work with the latest
> kernels. Your kernel likely pre-dates the addition of all the ata horka=
ge
> flag as boot parameter options, which I think was with 5.18 kernel.

Yep, I run Ubuntu 5.15.0-48-generic kernel.  I circumvented this by
using sysfsutils with
	class/scsi_host/host0/link_power_management_policy =3D max_performance
in the /etc/sysfs.conf file.  As long as I don't mess around with my
hardware, the host number should stay the same.

Kind regards,

Jaap Berkhout

--------------GYRUQI6J6FUowJKULJYI6xzc--

--------------AUOPSjuL8d0f3vgPmVWcJEJS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEoR3751BhG/27nT45Zx3W/nHBYkoFAmMtoZsACgkQZx3W/nHB
Ykq12hAAhQXdOvQuJpCi4Z3Px6g31XewdkCESk5GNcPSyd+L226g0Cm0SDeKtqis
tnM+kLgix0wd/nyhkz8IoStpaYQLblzZFnB4WJ7gU0lGSowc8H13QtxcAkCEJ4Va
4PAbSv+U94Q1E2Mq/76P8z9B+yQ5eZ/qwaABKb7HtkmG+AJ4baQ93oRSHsPjijPf
WWLToCxxK0t/75me5OaLmvD44Oh6CcMPrej3mXXtSCSN0aHP6V621XJ4HxaqH99l
zmYGm0USAhO39o5FQRgmLy6bRSxtf3PcE5g1TeZFejvR+2GcOdOtmYc3JYTCJsSA
Bj4cxOwZGYPLDu1pZ45RH6s66ebtznKjPTtEFuByL4mzqif9jG9GVDieX1wj303I
cIH4Il+VgAOWkwNThN70YvXzNEu6oHy+KuCbmi0FQ41xHyzUg+NZGSiJm9lWQmqL
JHEuLZI1OhTKOW1wQDl+dYSNTbYxJg51qPIYaLpcFlwmZ/aRwZXV2JLJdvCe4q6S
30yuaKZLFzcYCKbN8AU48pp0yFszgIYYAnMe6oIisbupxmTasGnWtI8ySNJqrj85
xSm89e6YxA1umVUTSlixXoWdQ7hbEcAJRi/TXBFBwu/HZ7PPhkpoF9f8SIM0zqxG
r/WDXZ7+sJC+a3MO/ptBw0u08mLSJNZgVnP+HtYib+aoj7ZTOFQ=
=Vl9e
-----END PGP SIGNATURE-----

--------------AUOPSjuL8d0f3vgPmVWcJEJS--
