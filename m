From: Stephan Linz <linz@li-pro.net>
Subject: Re: [PATCH v3 2/7] leds: documentation: 'ide-disk' to 'disk-activity'
Date: Wed, 22 Jun 2016 18:05:26 +0200
Message-ID: <576AB746.70509@li-pro.net>
References: <20160608223000.433-1-linz@li-pro.net>
 <20160608223000.433-2-linz@li-pro.net> <20160621150532.GG3302@leverpostej>
 <576A447F.2020002@samsung.com>
Reply-To: linz@li-pro.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="det7WpJRGBXnIDQaRLwwQTsGNKTBLFrsv"
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <576A447F.2020002@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org, Joseph Jezak <josejx@gentoo.org>, Nico Macrionitis <acrux@cruxppc.org>, =?UTF-8?Q?J=c3=b6rg_Sommer?= <joerg@alea.gnuu.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--det7WpJRGBXnIDQaRLwwQTsGNKTBLFrsv
Content-Type: multipart/mixed; boundary="nwxCnXaECChvFEg7jirCtVJvtLpcbJXmP"
From: Stephan Linz <linz@li-pro.net>
Reply-To: linz@li-pro.net
To: Jacek Anaszewski <j.anaszewski@samsung.com>,
 Mark Rutland <mark.rutland@arm.com>
Cc: linux-leds@vger.kernel.org, linux-ide@vger.kernel.org,
 Joseph Jezak <josejx@gentoo.org>, Nico Macrionitis <acrux@cruxppc.org>,
 =?UTF-8?Q?J=c3=b6rg_Sommer?= <joerg@alea.gnuu.de>,
 Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-ID: <576AB746.70509@li-pro.net>
Subject: Re: [PATCH v3 2/7] leds: documentation: 'ide-disk' to 'disk-activity'
References: <20160608223000.433-1-linz@li-pro.net>
 <20160608223000.433-2-linz@li-pro.net> <20160621150532.GG3302@leverpostej>
 <576A447F.2020002@samsung.com>
In-Reply-To: <576A447F.2020002@samsung.com>

--nwxCnXaECChvFEg7jirCtVJvtLpcbJXmP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jacek,

Am 22.06.2016 um 09:55 schrieb Jacek Anaszewski:
> On 06/21/2016 05:05 PM, Mark Rutland wrote:
>> On Thu, Jun 09, 2016 at 12:29:37AM +0200, Stephan Linz wrote:
>>> Cc: Joseph Jezak <josejx@gentoo.org>
>>> Cc: Nico Macrionitis <acrux@cruxppc.org>
>>> Cc: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
>>> Signed-off-by: Stephan Linz <linz@li-pro.net>
>>> ---
>>>   Documentation/devicetree/bindings/leds/common.txt    | 2 +-
>>>   Documentation/devicetree/bindings/leds/leds-gpio.txt | 2 +-
>>>   Documentation/laptops/asus-laptop.txt                | 2 +-
>>>   Documentation/leds/leds-class.txt                    | 2 +-
>>>   4 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/common.txt
>>> b/Documentation/devicetree/bindings/leds/common.txt
>>> index af10678..1e97169 100644
>>> --- a/Documentation/devicetree/bindings/leds/common.txt
>>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>>> @@ -26,7 +26,7 @@ Optional properties for child nodes:
>>>        "default-on" - LED will turn on (but for leds-gpio see
>>> "default-state"
>>>               property in
>>> Documentation/devicetree/bindings/gpio/led.txt)
>>>        "heartbeat" - LED "double" flashes at a load average based rat=
e
>>> -     "ide-disk" - LED indicates disk activity
>>> +     "disk-activity" - LED indicates disk activity
>>>        "timer" - LED flashes at a fixed, configurable rate
>>
>> We should not break the binding.
>>
>> Code must continue to support "ide-disk", though we can mark it
>> deprecated in the binding documentation, and update the in-kernel dts
>> files to use "disk-activity".
>=20
> The code in the version 4 of the patchset supports also "ide-disk".
>=20
> Stephan, could you send a new version of this patch, with preserved
> "ide-disk" property, marked as deprecated?

Yes, I can. I'll submit a new v5 patch set. You can pick out then the
right patch for the LED for-next branch, okay?


br,
Stephan

>=20


--nwxCnXaECChvFEg7jirCtVJvtLpcbJXmP--

--det7WpJRGBXnIDQaRLwwQTsGNKTBLFrsv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXardGAAoJEFebNK/earQ5TmYQAKMnz1ahazaX5NiwvyqqqBFs
XzIi6cPvFpf9dzyGc4jbqRD8iRgW6Y+/CUnBnXLHn594A+gGps1e9GmLHQBMF7nn
QB0tFBRZN5DhuFMj+TAEKYM3VW/BwoUkYogxSdSfiaVl/B8Zp+1B4+ooxpeoIPbR
uhQGu6PiQbGTzUYLylGm0g5MO4Y5uxfznrwtjhppIu/m9MH2Ev4LmB4SUOcmM8Yn
L0dLB7YIS19pznctfn8lnwX4dq/h+QPnowCLbofDP/nCIOx1zL11z4Mx/GnEhPFs
7acwLJLFyISxj9wMzMmZ6fh4QTNW9KPUkVkEsQgetZMzRfJN5US17UksXRZBajXc
oZqKnGcIEsQ8Km8/8cDtuhw07qurwDMyB9Dm4YAKSVyv+LHtnXS3YcUKenaJne7I
c+eyMZHg5yvEX5WaoimayPEYdoqnTnM/uLPiU5hTX4k4BWSRoA4EI+/5hnXWg4Kx
VrHklSqAtfYGdmMhqCQmm1PVqZWb50azP75mCOTxq1MgnLDfvOfkul54BZ9PE+uX
95VQRTHF/mQSUJWCHbDO7XPxP49hvuDGgBDSxMjBLnIOX4/6Ck55tI5EPYin37N4
4eUNjXnOjQdl7pt2BT4A5qgtPMfUNnY29FQNYUDxwBAEO66I1lfdbIK3M0oYrRpN
WqSSk312OFM3rTSX8RzL
=IC6S
-----END PGP SIGNATURE-----

--det7WpJRGBXnIDQaRLwwQTsGNKTBLFrsv--
