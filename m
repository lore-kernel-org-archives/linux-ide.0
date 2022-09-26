Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A9DC6FA83
	for <linux-ide@archiver.kernel.org>; Mon, 26 Sep 2022 14:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiIZOjY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiIZOio (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Sep 2022 10:38:44 -0400
Received: from se19-yh-out3.route25.eu (se19-yh-out3.route25.eu [IPv6:2a01:b941:2::91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF8744573
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 05:59:51 -0700 (PDT)
Message-ID: <43161bf3-5a92-ae25-fdc4-57ca2721b359@staalenberk.nl>
Date:   Mon, 26 Sep 2022 14:59:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
 <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
 <Yym65wlizZydJ/Tn@x1-carbon>
 <9756ac37-6790-7b83-5840-abe04f8ab838@staalenberk.nl>
 <Yyor5zsqHAoNimF3@x1-carbon>
 <f3111c18-704b-1845-1d39-e220642eec34@staalenberk.nl>
 <Yyr8aV5CEOuChpre@x1-carbon>
 <e9893bab-f2af-bae0-18df-924f9ff4652f@staalenberk.nl>
 <YytYzTIsqcB9nElM@x1-carbon>
From:   "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
Subject: Re: Multiple errors with DVD drive
In-Reply-To: <YytYzTIsqcB9nElM@x1-carbon>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------U3dXKrA5qYVStleGpTldt74P"
X-PPP-Message-ID: <20220926125945.7841.33766@server108.yourhosting.nl>
X-PPP-Vhost: staalenberk.nl
X-Originating-IP: 185.37.71.73
X-SpamExperts-Domain: filter.yourhosting.nl
X-SpamExperts-Username: 185.37.71.73
Authentication-Results: route25.eu; auth=pass smtp.auth=185.37.71.73@filter.yourhosting.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.05)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+sFQTiJUolvzQ9nENOJ1JOPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5zDsDF2MZ+M89jYnN6oF9I+t8C9mOBdONdnsxgsk1D2p/oZ
 ZbyP4142nSc2QuPs0RQql8Nqr1R/pRkus5DLF8nqHZYyDpn394JrQfkb6QN8a1prjQPFk8m4tSTf
 ORUp3yn8qwQcwkW9qHuCQjXdrDqXQ/xIA3SGk9LYWqQ3SwN+guq0SJO8PsIXxhRJrljod+D58Uml
 vZK0vgkd/lF74hEcG4WmRrOg18lHBWWsQFpG2H8PdEQuSDV08olg1de+lAFPp9nY5xjsnfyy8mWk
 DvCVKkYO20nWtC2Npm3zFUeOyIdpU1PrTsz2Rk0RohBJRyF6AT/i//6Iltsv+VGfA9NLnPEgmsr6
 IZraprHR4B97q+owzgqSco1Y2zKw3Rw0n6upXU9vhg3eFNKCLHdrQwNAFk//G2W+Ia+39HnICSrS
 jj43X7+YlS7e5PJZKZY2eeXsuSmKOJypJqWtbaslvoc+wVRVkqzR54Lbq5UWzSgCSA6meqWshfTJ
 CeTCBklcVX+rOzrLpyv+WKATF0cC/dGZ6r3C2Qgzc+xROZfGnoE3614HqV8NrjpIfAVmkZmE2qRJ
 7laYEbvuQrJ+TKp9BDpkOMyeV7249X2e1GQHGQCkcV2bvPviwgifAretHhDJP8lHlAW00nA5DWRx
 efaRKYaUqynr1kGHInGvOcpxBumoMYtsqS/34vosJPVNq5CVtkWeVnL2DtRKvRiefG1lboMfLypP
 fi/26oO2cauHDD/6kb9ImdpEhHDWytHzb0NplphzuHt3AhNafM37QAVbp5VE54NWPr2H4rhM4Gk+
 NYCTpc8SMRZInqoHNAMg29r4QsaCwSF/qmJVDCwpGWZiedQXCnZnpOMu4MiH8gsrbrmJQZVICyy8
 kOZ7gN54+KBywypSsRwf3rRhvoymIv7bzlshJS8XNHE22jNoXXtgm8RhivY1/VgEIaJ0RaTl8kLC
 IIkf/Rs8OT6wxvYYliUXjLizMMQrbXgpYquub9AstiyqT62jqR7dcFNQKOKCf7cCVZg8RkD6fOEc
 6Toql0SSRV0uoAimSXlFR6J71QKpIh1GyTEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@semaster01.route25.eu
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------U3dXKrA5qYVStleGpTldt74P
Content-Type: multipart/mixed; boundary="------------UgMFwcYu0p2OS0ENMeUx00kS";
 protected-headers="v1"
From: "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Message-ID: <43161bf3-5a92-ae25-fdc4-57ca2721b359@staalenberk.nl>
Subject: Re: Multiple errors with DVD drive
References: <40946617-7f37-b5a6-f94c-d47d1b4b21f3@opensource.wdc.com>
 <f7efabe8-79ab-8c6b-81d5-2cd0a396f148@staalenberk.nl>
 <a4326505-f52b-7a7b-d626-a77fb546642e@staalenberk.nl>
 <0baf58ab-4e7e-e8bf-d1e8-0897542d1bc6@staalenberk.nl>
 <Yym65wlizZydJ/Tn@x1-carbon>
 <9756ac37-6790-7b83-5840-abe04f8ab838@staalenberk.nl>
 <Yyor5zsqHAoNimF3@x1-carbon>
 <f3111c18-704b-1845-1d39-e220642eec34@staalenberk.nl>
 <Yyr8aV5CEOuChpre@x1-carbon>
 <e9893bab-f2af-bae0-18df-924f9ff4652f@staalenberk.nl>
 <YytYzTIsqcB9nElM@x1-carbon>
In-Reply-To: <YytYzTIsqcB9nElM@x1-carbon>

--------------UgMFwcYu0p2OS0ENMeUx00kS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 21-09-2022 20:32, Niklas Cassel wrote:
> On Wed, Sep 21, 2022 at 02:38:51PM +0200, J.J. Berkhout wrote:
>> On 21-09-2022 13:58, Niklas Cassel wrote:
>>> Another way do disable lpm is to do:
>>> $ sudo sh -c "echo max_performance > /sys/class/scsi_host/host13/link=
_power_management_policy"
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
>>
>> so the ineffectiveness of this boot parameter seems to be explained.
>> Might there be some other syntax for this parameter?
>=20
> Apparently this was introduced quite recently, in
> commit 2c33bbdac28c ("ata: libata-core: Allow forcing most horkage flag=
s")
> which was first included in kernel v5.19.
>=20
>>
>> Nevertheless, my problem now has a work-around and I am very happy.
>>  Thanks, Niklas.
>=20
> Great news!
>=20
> Then I believe that
> +       { "PIONEER BD-RW   BDR-207M",   NULL,   ATA_HORKAGE_NOLPM },
> should be the proper quirk for your device.
>=20
> If you could test it when you have time (again, no rush),
> then we could send out a proper fix for this.
>=20
>=20
> Kind regards,
> Niklas

OK, I got around to testing the patch.
I used kernel 5.19.11 (from https://cdn.kernel.org/pub).
After solving the problem with errors with the compilation (I removed
the NVIDIA driver and switched to the nouveau driver) and space problems
on my /boot partition (solved by using sudo make INSTALL_MOD_STRIP=3D1
modules_install) I got the following results:

Try 1:
patching libata-core.c with the lines
 	/* PIONEER BD-RW BDR-207M and PIONEER BD-RW BDR-205 have broken LPM
support */
	{ "PIONEER BD-RW   DVR-207M",	NULL,	ATA_HORKAGE_NOLPM },
	{ "PIONEER BD-RW   DVR-205",	NULL,	ATA_HORKAGE_NOLPM },

resulted in
link_power_management_policy still "med_power_with_dipm"
problem with pioneer DOES occur

Try 2:
patching libata-core.c with the lines
 	/* PIONEER BD-RW BDR-207M and PIONEER BD-RW BDR-205 have broken LPM
support */
	{ "PIONEER BD-RW   DVR-207M",	NULL,	ATA_HORKAGE_NOSETXFER },
	{ "PIONEER BD-RW   DVR-205",	NULL,	ATA_HORKAGE_NOSETXFER },

resulted in
link_power_management_policy still "med_power_with_dipm"
problem with pioneer DOES occur

Try 3:
patching libata-core.c with the lines
	/* PIONEER BD-RW BDR-207M and PIONEER BD-RW BDR-205 have broken LPM
support */
	{ "PIONEER BD-RW   DVR-207M",	NULL,	ATA_HORKAGE_NOSETXFER |
											ATA_HORKAGE_NOLPM },
	{ "PIONEER BD-RW   DVR-205",	NULL,	ATA_HORKAGE_NOSETXFER |
											ATA_HORKAGE_NOLPM },

resulted in
link_power_management_policy still "med_power_with_dipm"
problem with pioneer DOES occur, additional error in log:
device offline error, dev sr0, sector 1365828 op 0x0:(READ) flags 0x0
phys_seg 1 prio class 0
(not sure if this is significant)'

Try 4:
unpatched libata-core.c
using boot kernel parameter "libata.force=3D1:nolpm"

resulted in
link_power_management_policy now "max_performance"
problem with pioneer DOES NOT occur
so libata.force=3Dnolpm kernel parameter works, which might interest
Damien ;-)

Niklas, if you want to try other patches for this problem, I wouldbe
happy to be of assistance.

With kind regards,

Jaap Berkhout

--------------UgMFwcYu0p2OS0ENMeUx00kS--

--------------U3dXKrA5qYVStleGpTldt74P
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEoR3751BhG/27nT45Zx3W/nHBYkoFAmMxoicACgkQZx3W/nHB
YkqBIg//WSgGUkSU8k79dbQbVTquWXHldE7onnbnGExuznOtdKPWj3stL3ptvpiB
FAO41jH8JSvF5fw73nGIDrZsxTO8BpzIjdp2GjWeMr5Gx03F4Vj9fPBcQ2JwG6PV
Fb7slIu/5kr6/cPAeuyUOWyOt65Ydowgo3jxOQ8V575+zF2dWwZ0su3PtC3HbOBx
vF+Fk/4Ju99pCgUqa8TnuX5GHHpgXa+760LDzxjoqP9JHQT9Txh+OVE97Qr4kiZS
2+HpS8L/qKO85birZOi5ot9NoVUpK948lNas77gNI9rf9ngpqEq03IkqEFczkyVA
t9BeglzPlaj/PWtz7DEYSTJj7QqXFxeI6lwjBHb4A58uZeqReYt45BJFFO83F9dv
FMyTLyKmU264uMu/e/PbksgXHxxHygZkm1G8pfAnovQNls+wdJCXM0czmBpyieAH
M7yUEYgvhrpdPx1nOJKbpkNgq7rj+h3rjg3C1y5SgQC//60/67lWifFLlCvyiQWN
/BKKKWOdQfGHVxAtpQ7tnzxJmWXeYnMR24/TTpLUQuNMV/EW4wtndCUg6xq07s2B
9VyCGHWyvpxE7895YCnL2Hj0W57KmzEZOGkrLR0xqwsQ6VCUWr5G4MwvQ/DLaqTz
X83afVQY4taq61thnonseDc/hYsAdMJYrUIfgdN+TxdsjSSnIb8=
=Q1Uz
-----END PGP SIGNATURE-----

--------------U3dXKrA5qYVStleGpTldt74P--
