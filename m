From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Sat, 13 May 2006 12:02:40 +0200
Message-ID: <4465AEC0.30300@stesmi.com>
References: <44614592.7080301@gmail.com> <446536C5.80503@pobox.com> <44653807.3030101@gmail.com> <44655496.9030402@pobox.com> <44655986.3060007@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig51D1154F1EA9EB49FDCDABAA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxfep02.bredband.com ([195.54.107.73]:57532 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932203AbWEMKCq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 06:02:46 -0400
In-Reply-To: <44655986.3060007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig51D1154F1EA9EB49FDCDABAA
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Tejun Heo wrote:
> Jeff Garzik wrote:
>=20
>> Tejun Heo wrote:
>>
>>> Jeff Garzik wrote:
>>>
>>>> Tejun Heo wrote:
>>>>
>>>>> tested.  I implemented AHCI PM support half-way but then realized I=

>>>>> don't have any AHCI controller which supports PM (I have ICH7R).=20
>>>>> Is there any AHCI controller which reports PM support?
>>>>
>>>>
>>>> You can always use SCR-based PM support...
>>>>
>>>
>>> Can you elaborate a bit?
>>
>>
>> Sections A.1 and 6.1 of the PM spec.  You set the PMP field of the
>> SControl register.  This has obvious parallelism limitations, which is=

>> why "hardware context switching support" aka native PM support is
>> greatly preferred.
>>
>=20
> That cmd-switching PM support is what AHCI SPM bit indicates.  As of
> v1.1, AHCI doesn't define FIS-switching PM support yet.
>=20
> Supports Port Multiplier (SPM): Indicates whether the HBA can support a=

> Port Multiplier. When set, a Port Multiplier using command-based
> switching is supported. When cleared to =910=92, a Port Multiplier is n=
ot
> supported, and a Port Multiplier may not be attached to this HBA.
>=20
> And. the SControl section says...
>=20
> 19:16 RO 0h  Port Multiplier Port (PMP): This field is not used by AHCI=
=2E
>=20
> Which is understandable considering AHCI doesn't construct FISes itself=
=2E
>  I don't think PM requires more hardware support than being capable for=

> setting PMP in the FISes, which AHCI certainly can (standing down on
> collision for SDB notify aside).  I can give it a shot but it clearly
> violates the spec, and even if it works, we would need to print big fat=

> warning message while attaching PM.
>=20

Are you saying that the next big thing since sliced bread (AHCI) that's
supposed to unite the world and make everybody sing Kumbayah doesn't
support port multipliers (according to the spec) ?

Or am I totally misreading this.

// Stefan


--------------enig51D1154F1EA9EB49FDCDABAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEZa7EBrn2kJu9P78RA9InAKCjh1atGQWdd/pCAHzm7+mIdAUfwACfSNdj
NM+W6XLLW1I1QdBmwLbxDCw=
=f+sY
-----END PGP SIGNATURE-----

--------------enig51D1154F1EA9EB49FDCDABAA--
