From: =?ISO-8859-1?Q?Fran=E7ois?= Chenais <francois@chenais.net>
Subject: Re: kernel 2.6.3 hdparm : HDIO_SET_DMA failed: Operation not
	permitted
Date: Mon, 08 Mar 2004 12:37:46 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1078745866.1939.9.camel@tanna>
References: <1078506007.2210.84.camel@tanna>
	 <200403051826.16650.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.citb.bull.net ([192.90.76.5]:54794 "EHLO
	loupiac.citb.bull.net") by vger.kernel.org with ESMTP
	id S262471AbUCHLcH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Mar 2004 06:32:07 -0500
In-Reply-To: <200403051826.16650.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Le ven 05/03/2004 =E0 18:26, Bartlomiej Zolnierkiewicz a =E9crit :

> CONFIG_BLK_DEV_PIIX is not set in your .config and due to the fact
> that NEC VERSA L320 has Intel IDE chipset you need to set it to 'y'.

It's better with this option, hdparm works now. Thanks a lot.

/dev/hda:
 multcount    =3D 16 (on)
 IO_support   =3D  3 (32-bit w/sync)
 unmaskirq    =3D  0 (off)
 using_dma    =3D  1 (on)
 keepsettings =3D  0 (off)
 readonly     =3D  0 (off)
 readahead    =3D 256 (on)
 geometry     =3D 58140/16/63, sectors =3D 58605120, start =3D 0




But I still have a problem of latency when the disk seems starting afte=
r
about 30 sec of inactivity. It's strange. I don't find any disk option
in the ACPI configuration entries. Or perhaps it's the=20
ACPI_SLEEP experimental option. I'll try without it.

	Fran=E7ois






--=20
Debian SID
Linux tanna 2.6.3 #1 Tue Feb 24 03:06:51 CET 2004 i686 GNU/Linux
Linux Counter #59413
PGP fingerprint : 9AFA 15EC 96C9 F607 EBC1  DD41 70C5 F0E0 25A5 105B

