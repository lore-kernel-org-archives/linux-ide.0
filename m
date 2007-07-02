From: Stefan Skotte <sfs@enhance-it.dk>
Subject: Re: State of Port Multiplier Support in libata?
Date: Mon, 02 Jul 2007 09:37:53 +0200
Message-ID: <4688AB51.8080801@enhance-it.dk>
References: <4684D54A.8030307@enhance-it.dk> <4688A74B.7000604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from csmtp.b-one.net ([195.47.247.21]:43155 "EHLO csmtp1.b-one.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbXGBIDX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 04:03:23 -0400
In-Reply-To: <4688A74B.7000604@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tejun Heo wrote:
> Stefan Skotte wrote:
>> Hi,
>>
>> I was wondering what the odds are that my setup could be supported:
>>
>> * Stardom/Raidon SOHOTANK ST-6600 (5 disk SATA array)
>> (http://www.stardom.com.tw/sohotank%20st6600.htm)
>> * STLab Silicon Image 3531 NCQ/FIS PMP PCIe adapter with one eSATA p=
ort
>> (uses sata_sil24).
>> (http://www.st-lab.com/assign.asp?keyid=3Dbf9)
>>
>> The classical example of it not working properly is that only one di=
sk
>> in bay 2 is recognized; all other does not respond at all:
>=20
> Get 2.6.22-rc6 and apply patches from the following page.
>=20
>   http://home-tj.org/wiki/index.php/Libata-tj-stable
>=20
> It should work.
>=20

Thanks alot :) - I'm actually building it now on 2.6.22-rc6.

However there seems to be something within ipr.c that doesn't compile r=
ight:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Error Msg:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
drivers/scsi/ipr.c: In function =E2=80=98__ipr_eh_dev_reset=E2=80=99:
drivers/scsi/ipr.c:3955: warning: passing argument 4 of =E2=80=98ata_do=
_eh=E2=80=99 from
incompatible pointer type
drivers/scsi/ipr.c: In function =E2=80=98ipr_ata_phy_reset=E2=80=99:
drivers/scsi/ipr.c:5049: error: =E2=80=98struct ata_port=E2=80=99 has n=
o member named
=E2=80=98device=E2=80=99
drivers/scsi/ipr.c:5053: error: =E2=80=98struct ata_port=E2=80=99 has n=
o member named
=E2=80=98device=E2=80=99
drivers/scsi/ipr.c:5056: error: =E2=80=98struct ata_port=E2=80=99 has n=
o member named
=E2=80=98device=E2=80=99
make[3]: *** [drivers/scsi/ipr.o] Error 1
make[2]: *** [drivers/scsi] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.22-rc6'
make: *** [debian/stamp-build-kernel] Error 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I just removed the ipr module since I'm not going to use it, but maybe
I'm doing something wrong since I'm usng the debian build process (?),
anyways I downloaded 2.6.22-rc6 from testing on kernel.org, so that
should atleast be right.

Thanks for getting back to me, I will report back how well my 3531-base=
d
controller fares...

Kind regards,
Stefan


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGiKs/+vG8YFo3LPMRAjVVAJ9Zg1mKZh5UKuRzcm/8pB1Oh4tAfQCdGV5R
Ejekf0OS2bfmf0UqGnp7jAY=3D
=3DZg0T
-----END PGP SIGNATURE-----
