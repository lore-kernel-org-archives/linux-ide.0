From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: sata_via and SATA DVD drive (PX-712SA)
Date: Fri, 21 Apr 2006 15:24:30 +0800
Message-ID: <444888AE.8000706@tw.ibm.com>
References: <200604202020.22010.r.brandstaedter@gmx.at>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:35805 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751256AbWDUHYj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Apr 2006 03:24:39 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3L7OYxv031358
	for <linux-ide@vger.kernel.org>; Fri, 21 Apr 2006 03:24:34 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3L7KqJi085062
	for <linux-ide@vger.kernel.org>; Fri, 21 Apr 2006 01:20:53 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3L7OXcX000844
	for <linux-ide@vger.kernel.org>; Fri, 21 Apr 2006 01:24:34 -0600
In-Reply-To: <200604202020.22010.r.brandstaedter@gmx.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>
Cc: linux-ide@vger.kernel.org

Reinhard Brandst=E4dter wrote:
> Hi,
>=20
> since 2.6.12 I try to get a Plextor PX-712SA (SATA DVD-RW) drive to w=
ork on a=20
> VIA SATA controller. Without success.
>=20
> When I load the sata_via module the controller is initialized and two=
 sata=20
> interfaces are found (ata4 and ata5).
> Scanning the attached drive fails, and i think the returned code indi=
cates the=20
> drive is busy:
>=20
> ...
> ata4: command 0xa0 timeout, stat 0xd0 host_stat 0x61
> ata4: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ...
>=20
> The controller seems to lock up (IDE LED is on) after that.
> I can unload the module and load it again, resulting in a timeout:
>=20
> ...
> ata6 is slow to respond, please be patient
> ata6 failed to respond (30 secs)
> ...
>=20
> Attached my dmesg output with the messages of loading the module, unl=
oading it=20
> and loading it again. (ata4 & ata5 found, then ata6 & ata7)
>=20
> I also tried with SCSI debugging but this gives no additional info.
>=20

=46rom the dmesg, PX-712SA looks like a PATA drive bridged to SATA.
Could you try the atapi_dmadir=3D1 module parameter and check if it hel=
ps?
(For older kernels, please #define ATAPI_ENABLE_DMADIR
in include/linux/libata.h and recompile the kernel.)
--
albert


