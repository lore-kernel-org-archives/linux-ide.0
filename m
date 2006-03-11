From: Jure =?UTF-8?Q?Pe=C4=8Dar?= <pegasus@nerv.eu.org>
Subject: Re: gigabyte iRam not seen by linux
Date: Sat, 11 Mar 2006 17:43:28 +0100
Message-ID: <20060311174328.c44628c2.pegasus@nerv.eu.org>
References: <20060310013604.1acac722.pegasus@nerv.eu.org>
	<4411BCB6.5080108@gmail.com>
	<44122FBD.9000909@tw.ibm.com>
	<20060311034630.4c12cf83.pegasus@nerv.eu.org>
	<20060311033143.GA12866@htj.dyndns.org>
	<20060311092013.487c1263.pegasus@nerv.eu.org>
	<20060311085843.GA9067@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.pecar.org ([193.95.219.68]:44648 "EHLO mail.pecar.org")
	by vger.kernel.org with ESMTP id S1751254AbWCKQnN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 11:43:13 -0500
In-Reply-To: <20060311085843.GA9067@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertl@mail.com, jgarzik@pobox.com

On Sat, 11 Mar 2006 17:58:43 +0900
Tejun Heo <htejun@gmail.com> wrote:

> The patch at the tail of this mail makes ata_dev_try_classify() ignor=
e
> diagnostic code in FEATURE.  If the iRam successfully gets attached
> with the patch, can you please post 'hdparm -I /dev/sdX' and 'hdparm
> --Istdout /dev/sdX' of the iRam? =20
>=20
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -477,7 +477,7 @@ ata_dev_try_classify(struct ata_port *ap
>  	else if ((device =3D=3D 0) && (err =3D=3D 0x81))
>  		/* do nothing */ ;
>  	else
> -		return ATA_DEV_NONE;
> +		/*return ATA_DEV_NONE*/;
> =20
>  	/* determine if device is ATA or ATAPI */
>  	class =3D ata_dev_classify(&tf);


That's return err; in my source ... and yes, commenting it out gives me=
 the sda:

# cat /proc/scsi/scsi=20
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: GIGABYTE i-RAM   Rev: v0.9
  Type:   Direct-Access                    ANSI SCSI revision: 05

# hdparm -I /dev/sda

/dev/sda:

ATA device, with non-removable media
	Model Number:       GIGABYTE i-RAM                         =20
	Serial Number:      374F93ABEF8FA122FC1C
	Firmware Revision:  v0.98  =20
Standards:
	Supported: 7 6 5 4=20
	Likely used: 7
Configuration:
	Logical		max	current
	cylinders	8319	8319
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:    8385552
	LBA    user addressable sectors:    8386559
	device size with M =3D 1024*1024:        4094 MBytes
	device size with M =3D 1000*1000:        4293 MBytes (4 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 1
	Standby timer values: spec'd by Vendor
	R/W multiple sector transfer: Max =3D 16	Current =3D 16
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6=20
	     Cycle time: min=3D120ns recommended=3D120ns
	PIO: pio0 pio1 pio2 pio3 pio4=20
	     Cycle time: no flow control=3D240ns  IORDY flow control=3D120ns
Commands/features:
	Enabled	Supported:

# hdparm --Istdout /dev/sda

/dev/sda:
 IO_support   =3D  0 (default 16-bit)
 readonly     =3D  0 (off)
 readahead    =3D 256 (on)
 geometry     =3D 522/255/63, sectors =3D 8386559, start =3D 0
045a 207f 0000 0010 0000 0000 003f 0000
0000 0000 3337 3446 3933 4142 4546 3846
4131 3232 4643 3143 0000 0000 0000 7630
2e39 3820 2020 4749 4741 4259 5445 2069
2d52 414d 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 0f00 0400 0002 0002 0007 207f 0010
003f f410 007f 0110 f7ff 007f 0000 0007
0003 0078 0078 00f0 0078 0000 0000 0000
0000 0000 0000 0000 0202 0000 0008 0000
00fc 0000 0000 4000 4000 0000 0000 4000
407f 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 1380 7510 1380 7520 1380 7530
1380 7540 1380 7550 1380 7560 1380 7570
1380 7580 0001 0000 0000 0000 01e0 01e0
01c0 01c0 01c0 01c0 01c0 01c0 7766 7777
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

> We're pretty curious.

So am I, but probably because of different reasons:

# time tar jxf linux-2.6.16-rc5.tar.bz2=20

real	0m16.662s
user	0m15.916s
sys	0m1.104s

:D

More thorough benchmarks soon.



--=20

Jure Pe=C4=8Dar
http://jure.pecar.org/
