From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
Subject: Re: IDENTIFY DEVICE not working any more?
Date: Mon, 15 Aug 2005 15:18:58 +0200
Message-ID: <43009642.40805@conterra.de>
References: <43005B4D.1090801@conterra.de> <1124102095.8189.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vvv.conterra.de ([212.124.44.162]:18125 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S932363AbVHONTQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Aug 2005 09:19:16 -0400
Received: from localhost (unknown [127.0.0.1])
	by conterra.de (-) with ESMTP id 719BC1C88E2
	for <linux-ide@vger.kernel.org>; Mon, 15 Aug 2005 15:19:11 +0200 (CEST)
In-Reply-To: <1124102095.8189.45.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>

Erik Slagter wrote:
> On Mon, 2005-08-15 at 11:07 +0200, Dieter St=FCken wrote:
>=20
>>I used smartmontools for sata devices quite successfully awhile.
>>Since 2.6.12.2 however, I get an ioerror on "DENTIFY DEVICE"
>>errno=3D25 [Inappropriate ioctl for device] and smartctl gives up.
>=20
> Over here it works fine (sata_promise driver + 2.6.12.3 +
> smartmontools).
>=20
> Also afaik the .1/.2/.3 patches did not contain changes to the libata=
 or
> scsi layer.

strange. I Have written a tiny test with: rc =3D ioctl(fd, HDIO_GET_IDE=
NTITY, &id);
and definitely got: "/dev/sda: Inappropriate ioctl for device" with 2.6=
=2E12.2.
I did not test any other 2.6.12.x, but it works fine for an other 2.6.1=
1 system.

Unfortunalely I can't install an other kernel today, as all my systems =
are in
production. Is there any new kernel config I missed? The only differenc=
e ist,
that my 2.6.12 system is a x86_64, where as the 2.6.11 system is an i68=
6.
I'll try some constellations later at home, where I have an other x86_6=
4 system.

Dieter.
--=20
Dieter St=FCken, con terra GmbH, M=FCnster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
