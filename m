Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C96C6FA8E
	for <linux-ide@archiver.kernel.org>; Mon, 26 Sep 2022 16:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiIZQDL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Sep 2022 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiIZQCh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Sep 2022 12:02:37 -0400
Received: from se22-yh-out3.route25.eu (se22-yh-out3.route25.eu [IPv6:2a01:b941:2::88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4326D71BF2
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 07:50:50 -0700 (PDT)
Message-ID: <410a6734-298c-d116-43e3-0956a73f67ac@staalenberk.nl>
Date:   Mon, 26 Sep 2022 16:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
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
 <43161bf3-5a92-ae25-fdc4-57ca2721b359@staalenberk.nl>
Subject: Re: Multiple errors with DVD drive
In-Reply-To: <43161bf3-5a92-ae25-fdc4-57ca2721b359@staalenberk.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1jracJi0g99VzD0YE9rguCpY"
X-PPP-Message-ID: <20220926145044.20074.14956@server108.yourhosting.nl>
X-PPP-Vhost: staalenberk.nl
X-Originating-IP: 185.37.71.73
X-SpamExperts-Domain: filter.yourhosting.nl
X-SpamExperts-Username: 185.37.71.73
Authentication-Results: route25.eu; auth=pass smtp.auth=185.37.71.73@filter.yourhosting.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT90ccW21JuponP0snvhPIGWPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5zDsDF2MZ+M89jYnN6oF9I+t8C9mOBdONdnsxgsk1D2p/oZ
 ZbyP4142nSc2QuPs0RQql8Nqr1R/pRkus5DLF8nqKl7C3VNLpylCT3YVY9TC/lprjQPFk8m4tSTf
 ORUp3yn8qwQcwkW9qHuCQjXdrDqXQ/xIA3SGk9LYWqQ3SwN+guq0SJO8PsIXxhRJrljod+D58Uml
 vZK0vgkd/lF74hEcG4WmRrOg18lHBWWsQFpG2H8PdEQuSDV08olg1de+lAFcnCWmvQOO5HM1JS3V
 BCKjKkYO20nWtC2Npm3zFUeOyIdpU1PrTsz2Rk0RohBJRyF6AT/i//6Iltsv+VGfA9NLnPEgmsr6
 IZraprHR4B97q+owzgqSco1Y2zKw3Rw0n6upXU9vhg3eFNKCLHdrQwNAFk//G2W+Ia+39HnICSrS
 jj43X7+YlS7e5PJZKZY2eeXsuSmKOJypJqWtbaslvoc+wVRVkqzR54Lbq5UWzSgCSA6meqWshfTJ
 CeTCBklcVX+rOzrLpyv+WKATF0cC/dGZ6r3C2Qgzc+xROZfGnoE3614HqV8NrjpIfAVmkZmE2qRJ
 7laYEbvuQrJ+TKp9BDpkOMyeV7249X2e1GQHGQCkcdScOAccA0K2QJwiOZ4f41hHlAW00nA5DWRx
 efaRKYaUaoyQIe5O/iUV19PWPqhGNYtsqS/34vosJPVNq5CVtkWeVnL2DtRKvRiefG1lboMfLypP
 fi/26oO2cauHDD/6kb9ImdpEhHDWytHzb0NplphzuHt3AhNafM37QAVbp5VE54NWPr2H4rhM4Gk+
 NYCTpWjmIM+uWwchRg98UNr4f9OePT59SxTWp8a4ZbQ+WTcqCnZnpOMu4MiH8gsrbrmJQZVICyy8
 kOZ7gN54+KBywypSsRwf3rRhvoymIv7bzlshJS8XNHE22jNoXXtgm8RhivY1/VgEIaJ0RaTl8kLC
 IIkf/Rs8OT6wxvYYliUXjLizMMQrbXgpYquub9AstiyqT62jqR7dcFNQKOKCf7cCVZg8RkD6fOEc
 6Toql0SSRV0uoAimSXlFR6J71QKpIh1GyTEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@semaster01.route25.eu
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1jracJi0g99VzD0YE9rguCpY
Content-Type: multipart/mixed; boundary="------------VtiZPphVW7RtG0BsJN4oI5xm";
 protected-headers="v1"
From: "J.J. Berkhout" <j.j.berkhout@staalenberk.nl>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Message-ID: <410a6734-298c-d116-43e3-0956a73f67ac@staalenberk.nl>
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
 <43161bf3-5a92-ae25-fdc4-57ca2721b359@staalenberk.nl>
In-Reply-To: <43161bf3-5a92-ae25-fdc4-57ca2721b359@staalenberk.nl>

--------------VtiZPphVW7RtG0BsJN4oI5xm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 26-09-2022 14:59, J.J. Berkhout wrote:
>=20
>=20
> On 21-09-2022 20:32, Niklas Cassel wrote:
>> On Wed, Sep 21, 2022 at 02:38:51PM +0200, J.J. Berkhout wrote:
>>> On 21-09-2022 13:58, Niklas Cassel wrote:
>>>> Another way do disable lpm is to do:
>>>> $ sudo sh -c "echo max_performance > /sys/class/scsi_host/host13/lin=
k_power_management_policy"
>>>
>>> Yes, this worked and did the trick!  Reading without any errors.  I d=
id
>>> not yet try to write, but will do so today.
>>> When booting with libata.force=3Dnolpm  the link_power_management_pol=
icy
>>> was still med_power_with_dipm and I got the dmesg:
>>>
>>> [    0.291452] ata: failed to parse force parameter "nolpm" (unknown =
value)
>>>
>>> so the ineffectiveness of this boot parameter seems to be explained.
>>> Might there be some other syntax for this parameter?
>>
>> Apparently this was introduced quite recently, in
>> commit 2c33bbdac28c ("ata: libata-core: Allow forcing most horkage fla=
gs")
>> which was first included in kernel v5.19.
>>
>>>
>>> Nevertheless, my problem now has a work-around and I am very happy.
>>>  Thanks, Niklas.
>>
>> Great news!
>>
>> Then I believe that
>> +       { "PIONEER BD-RW   BDR-207M",   NULL,   ATA_HORKAGE_NOLPM },
>> should be the proper quirk for your device.
>>
>> If you could test it when you have time (again, no rush),
>> then we could send out a proper fix for this.
>>
>>
>> Kind regards,
>> Niklas
>=20
> OK, I got around to testing the patch.
> I used kernel 5.19.11 (from https://cdn.kernel.org/pub).
> After solving the problem with errors with the compilation (I removed
> the NVIDIA driver and switched to the nouveau driver) and space problem=
s
> on my /boot partition (solved by using sudo make INSTALL_MOD_STRIP=3D1
> modules_install) I got the following results:
>=20
> Try 1:
> patching libata-core.c with the lines
>  	/* PIONEER BD-RW BDR-207M and PIONEER BD-RW BDR-205 have broken LPM
> support */
> 	{ "PIONEER BD-RW   DVR-207M",	NULL,	ATA_HORKAGE_NOLPM },
> 	{ "PIONEER BD-RW   DVR-205",	NULL,	ATA_HORKAGE_NOLPM },
>=20
> resulted in
> link_power_management_policy still "med_power_with_dipm"
> problem with pioneer DOES occur
>=20
> Try 2:
> patching libata-core.c with the lines
>  	/* PIONEER BD-RW BDR-207M and PIONEER BD-RW BDR-205 have broken LPM
> support */
> 	{ "PIONEER BD-RW   DVR-207M",	NULL,	ATA_HORKAGE_NOSETXFER },
> 	{ "PIONEER BD-RW   DVR-205",	NULL,	ATA_HORKAGE_NOSETXFER },
>=20
> resulted in
> link_power_management_policy still "med_power_with_dipm"
> problem with pioneer DOES occur
>=20
> Try 3:
> patching libata-core.c with the lines
> 	/* PIONEER BD-RW BDR-207M and PIONEER BD-RW BDR-205 have broken LPM
> support */
> 	{ "PIONEER BD-RW   DVR-207M",	NULL,	ATA_HORKAGE_NOSETXFER |
> 											ATA_HORKAGE_NOLPM },
> 	{ "PIONEER BD-RW   DVR-205",	NULL,	ATA_HORKAGE_NOSETXFER |
> 											ATA_HORKAGE_NOLPM },
>=20
> resulted in
> link_power_management_policy still "med_power_with_dipm"
> problem with pioneer DOES occur, additional error in log:
> device offline error, dev sr0, sector 1365828 op 0x0:(READ) flags 0x0
> phys_seg 1 prio class 0
> (not sure if this is significant)'
>=20
> Try 4:
> unpatched libata-core.c
> using boot kernel parameter "libata.force=3D1:nolpm"
>=20
> resulted in
> link_power_management_policy now "max_performance"
> problem with pioneer DOES NOT occur
> so libata.force=3Dnolpm kernel parameter works, which might interest
> Damien ;-)
>=20
> Niklas, if you want to try other patches for this problem, I wouldbe
> happy to be of assistance.
>=20
> With kind regards,
>=20
> Jaap Berkhout

Update:

I am sorry to have to report I made a mistake.  Instead of "PIONEER
BD-RW BDR-207M" I used  "BD-RW   DVR-207M", which is obviously wrong.  I
just now corrected this am am happy to report that with the patch:
  	/* PIONEER BD-RW BDR-207M and PIONEER BD-RW BDR-205 have broken LPM
support */
 	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_HORKAGE_NOLPM },
 	{ "PIONEER BD-RW   BDR-205",	NULL,	ATA_HORKAGE_NOLPM },

the problem with the optical drive is solved.
Please consider this mistake as a senior moment.

With kind regards,

Jaap Berkhout.

--------------VtiZPphVW7RtG0BsJN4oI5xm--

--------------1jracJi0g99VzD0YE9rguCpY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEoR3751BhG/27nT45Zx3W/nHBYkoFAmMxvCwACgkQZx3W/nHB
YkrMzQ/9HFMcUa14W9a+BgioY5mczjGVcE3svGFnOrq0DsTRpUHRg9NuPjYke4cH
6Aucxx3xeg0IO8DQOaTcwq6bTj7yfD6bYTlV2MBM50vZ9zvu3jOFwpLvDY6Y9hpR
KWlYhzR9lWDweNxIKzW/7+4pBQLLRI33qt/vSRakIdDC0urW8Tnjk7aaYlfU2swm
RGBbQXHfsnyE7t3H3b0uFpOUjl35l8isaz1rGZ1iDX6/5we/W/zbw13yfJacFzMg
5PEQoz3qEz/Vh9xf6y5Pa9oRJB4bBAP8mGu4yBYIB7LXQf1iZH39ZH+pxqtdzP3d
NShiIGWdJy9xupUPOrE/ssV5wELXwH38PdYfqSRpLsniJFlpW0E7NUkgC/0LaTNe
wAFliDwm5SfNxiW4sIQDFyW7ld7NXge+wsP8PixIj26GXGMYFDMylHyXLxMFuTrs
ouoGqYTDNEun8PXwn3Gx8v9+GggE7tz05Ft8qjZ9hhf48QkV7kEQlShWr3OKVkiH
aInNf5RB3tqU9F7WvmQZnRkTOZ5hy/qIXN+LxL6Wdacr+xxhcB5yB2FF4Zo+0l77
ls/NkqpKBl415BANDExrK2a7/PHMGXeE+SdONdAWrbpqd0ENHkSzZ86Ede/BcNq+
R0KrNY0RG/VxrG2JDmxm6+hsvgDApvl3OXdyW6eXyYyo3hOCMY8=
=yBv/
-----END PGP SIGNATURE-----

--------------1jracJi0g99VzD0YE9rguCpY--
