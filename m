From: =?ISO-8859-1?Q?Guillaume_Laur=E8s?=
	<guillaume.laures@club-internet.fr>
Subject: Re: sata disk failure?
Date: Tue, 15 Feb 2005 23:38:42 +0100
Message-ID: <8a8e3658e83b16145dc64b4efa140f9f@club-internet.fr>
References: <420D5FAE.7040109@linux.it> <20050212155420.GA13468@harddisk-recovery.com> <170b0d7e63345e9b7dba9341a87a8a01@club-internet.fr> <20050213150102.GB13468@harddisk-recovery.com> <353ee8ef7c34573b3e1322ba7502c529@club-internet.fr> <42122859.9060609@pobox.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-27--796579678"
Content-Transfer-Encoding: 7bit
Received: from relay-bv.club-internet.fr ([194.158.96.102]:10199 "EHLO
	relay-bv.club-internet.fr") by vger.kernel.org with ESMTP
	id S261923AbVBOWjT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Feb 2005 17:39:19 -0500
In-Reply-To: <42122859.9060609@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-ide@vger.kernel.org, debian-amd64@lists.debian.org


--Apple-Mail-27--796579678
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed

Thanks for your help Jeff.

During my experiments I plugged an unpluged the drive numerous times. I =20=

also tried another SATA cable, but same thing. Even on the other =20
motherboard SATA plug. I closely examined the drive and it seems right. =20=

like new in fact. The motherboard is even newer, and so is the cable.

Is your idea consistent with the fact that the drive is _alays_ =20
recognized in the bios, and _always_ recognized in linux ? All the time =20=

it fails with the messages "nv_sata: Primary/Secondary device removed" =20=

a few seconds after the console promt is displayed. Sometimes I have =20
the time to mount the drive, sometimes not even.

Later,

GoM

Le 15 f=E9vr. 05, =E0 17:50, Jeff Garzik a =E9crit :

> Guillaume Laur=E8s wrote:
>> Hello,
>> Here is a small report in attachement, done with 2.6.11-rc4.
>> =
----------------------------------------------------------------------=20=

>> --
>>  * Hardware is nforce3 250GB, booting debian pure64 on pata (Maxtor =20=

>> 30Gb 6E030L0) drive. The goal is to mount data found on a sata disk =20=

>> (seagate 200Gb ST3200822AS). The pata drive holds / and lvm partition =
=20
>> with /usr, /var /tmp and /home.
>> The ultimate goal is to switch all this to the sata drive, which =20
>> already holds a (barely used) swap partition.
>>  * Soon after boot the console displays:
>> nv_sata: Primary device removed
>> nv_sata: Primary device removed
>> nv_sata: Primary device removed
>> nv_sata: Primary device removed
>> ...
>> nv_sata: Primary device removed
>> nv_sata: Primary device removed
>> nv_sata: Primary device removed
>> nv_sata: Primary device removed
>> nv_sata: Primary device removed
>> nv_sata: Primary device added
>> nv_sata: Primary device added
>> and the sata disk seems to spin down at the same time.
>> This is currently on 2.6.11-rc4, although I got the same behaviour =20=

>> with 2.6.10 and 2.6.11-rc3. Removing power from the drive and pluging =
=20
>> it again seems to make te drive work some time , until it spins down =20=

>> again...
>
> Seems like the hotplug code is triggering.  That signals to me there =20=

> is some connection problem.  Maybe you have a bad cable, or maybe the =20=

> cable is just seated improperly in one of the two SATA plugs.
>
> It's also possible your motherboard or drive SATA plug is faulty, but =20=

> I would replace the cable first.
>
> 	Jeff
>
>
>
>
> --=20
> To UNSUBSCRIBE, email to debian-amd64-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact =20
> listmaster@lists.debian.org
>

--Apple-Mail-27--796579678
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: =?ISO-8859-1?Q?Ceci_est_une_signature_=E9lectronique_PGP?=
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFCEnnyxnIJde5abSkRAjFqAKDBFExuBPW5Ty7ItH2LqiDopwSUJgCguYNB
bHxwl+DGBCLqd2nTC+4fKPc=
=Gubd
-----END PGP SIGNATURE-----

--Apple-Mail-27--796579678--

