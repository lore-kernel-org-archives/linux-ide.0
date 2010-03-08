From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Mon, 08 Mar 2010 16:07:14 -0500
Message-ID: <yq1bpeya5fh.fsf@sermon.lab.mkp.net>
References: <4B947393.2050002@kernel.org>
	<1268031640.4389.11.camel@mulgrave.site>
	<yq1vdd6bzgz.fsf@sermon.lab.mkp.net>
	<yq1mxyibz7o.fsf@sermon.lab.mkp.net>
	<yq1iq96bz22.fsf@sermon.lab.mkp.net> <4B9546E6.6050006@zytor.com>
	<1268074705.10660.23.camel@mulgrave.site>
	<20100308200206.dac60db7.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:59665 "EHLO
	rcsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410Ab0CHVJP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Mar 2010 16:09:15 -0500
In-Reply-To: <20100308200206.dac60db7.ctpm@ist.utl.pt> (=?utf-8?Q?=22Cl?=
 =?utf-8?Q?=C3=A1udio?= Martins"'s
	message of "Mon, 8 Mar 2010 20:02:06 +0000")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?utf-8?Q?Cl=C3=A1udio?= Martins <ctpm@ist.utl.pt>
Cc: James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Jeff Garzik <jeff@garzik.org>, Mark Lord <kernel@teksavvy.com>, tytso@mit.edu, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, Matthew Wilcox <matthew@wil.cx>, aschnell@suse.de, knikanth@suse.de, jdelvare@suse.de

>>>>> "Cl=C3=A1udio" =3D=3D Cl=C3=A1udio Martins <ctpm@ist.utl.pt> writ=
es:

Cl=C3=A1udio> So the question is: what are hard drive makers guaranteei=
ng (if
Cl=C3=A1udio> anything at all)?

No guarantees.  Nothing that you can get in writing, anyway.


Cl=C3=A1udio> Was a 512B sector write really atomic?

Sometimes.


Cl=C3=A1udio> Is a 4k one? =20

Sometimes, maybe.

The problem with 4KB physical blocks is that if you do a partial or
misaligned write you'll end up having to do read-modify-write.  And tha=
t
introduces are scenario where a subsequent write error will affect
logical blocks that were not part of the I/O request.

However, you also have that with regular drives because they often writ=
e
more than the actual block undergoing I/O.  For instance to reduce
hotspot bleed to adjacent sectors.

There have been several unsuccessful attempts at nudging the drive
vendors into giving us real guarantees (supercapacitors, NVRAM or
flash-backed write cache).  No luck so far.  So people that care use
arrays with non-volatile caches.

--=20
Martin K. Petersen	Oracle Linux Engineering
