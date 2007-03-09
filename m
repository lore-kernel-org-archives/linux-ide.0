From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: timeout errors on sata_sil24 with port multiplier & PCI-X
Date: Fri, 9 Mar 2007 15:31:51 -0800
Message-ID: <20070309233151.GD14319@curie-int.orbis-terrarum.net>
References: <20070309221628.GA12330@jim.sh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:54247 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1767647AbXCIXbl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 18:31:41 -0500
Content-Disposition: inline
In-Reply-To: <20070309221628.GA12330@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2007 at 05:16:28PM -0500, Jim Paris wrote:
> If not I think my next course of action will be to try swapping the
> controller to a PCIe SiI3132, then maybe give Robin H. Johnson's
> 2.6.20 port of the PMP patches a try.

Here's paste of the equivalent stuff on my patches. Notice that it takes 49
seconds to bring the disk array up :-(. I've had plenty of people complain =
to
me that they have struggled to apply my patches (because they were against =
the
Linus tree with libata-upstream as of a specific point), and they definitely
need a lot more work to apply to newer kernels.

Also, afaik there has been no resolution of the performance issue - while t=
he
controller shows 3Gb, the actual combined speeds I get are only at the 1.5Gb
level.

03:00.0 Mass storage controller [0180]: Silicon Image, Inc. SiI 3132 Serial=
 ATA Raid II Controller [1095:3132] (rev 01)
	Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller [109=
5:3132]
	Flags: bus master, fast devsel, latency 0, IRQ 18
	Memory at b0404000 (64-bit, non-prefetchable) [size=3D128]
	Memory at b0400000 (64-bit, non-prefetchable) [size=3D16K]
	I/O ports at 3000 [size=3D128]
	Expansion ROM at b0b00000 [disabled] [size=3D512K]
	Capabilities: [54] Power Management version 2
	Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=3D0/0 =
Enable-
	Capabilities: [70] Express Legacy Endpoint IRQ 0

Feb 28 20:30:52 [kernel] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 actio=
n 0x42 frozen
Feb 28 20:30:52 [kernel] ata1: (irq_stat 0x00b00090, PHY RDY changed)
Feb 28 20:30:52 [kernel] ata1: waiting for device to spin up (8 secs)
Feb 28 20:31:01 [kernel] ata1: soft resetting port
Feb 28 20:31:01 [kernel] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
Feb 28 20:31:01 [kernel] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5=
 ports, feat 0x9/0x9
Feb 28 20:31:01 [kernel] ata1.00: hard resetting port
Feb 28 20:31:01 [kernel] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:01 [kernel] ata1.01: hard resetting port
Feb 28 20:31:02 [kernel] ata1.01: softreset failed (SRST command error)
Feb 28 20:31:02 [kernel] ata1.01: follow-up softreset failed, retrying in 5=
 secs
Feb 28 20:31:07 [kernel] ata1.01: hard resetting port
Feb 28 20:31:07 [kernel] ata1.01: hardreset failed (port not ready)
Feb 28 20:31:07 [kernel] ata1.01: reset failed, giving up
Feb 28 20:31:07 [kernel] ata1.15: hard resetting port
Feb 28 20:31:07 [kernel] ata1: controller in dubious state, performing PORT=
_RST
Feb 28 20:31:09 [kernel] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
Feb 28 20:31:09 [kernel] ata1.00: hard resetting port
Feb 28 20:31:10 [kernel] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:10 [kernel] ata1.01: hard resetting port
Feb 28 20:31:11 [kernel] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:11 [kernel] ata1.02: hard resetting port
Feb 28 20:31:11 [kernel] ata1.02: softreset failed (SRST command error)
Feb 28 20:31:11 [kernel] ata1.02: follow-up softreset failed, retrying in 5=
 secs
Feb 28 20:31:16 [kernel] ata1.02: hard resetting port
Feb 28 20:31:16 [kernel] ata1.02: COMRESET failed (errno=3D-5)
Feb 28 20:31:16 [kernel] ata1.02: reset failed, giving up
Feb 28 20:31:16 [kernel] ata1.15: hard resetting port
Feb 28 20:31:16 [kernel] ata1: controller in dubious state, performing PORT=
_RST
Feb 28 20:31:18 [kernel] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
Feb 28 20:31:19 [kernel] ata1.00: hard resetting port
Feb 28 20:31:19 [kernel] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:19 [kernel] ata1.01: hard resetting port
Feb 28 20:31:20 [kernel] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:20 [kernel] ata1.02: hard resetting port
Feb 28 20:31:20 [kernel] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:20 [kernel] ata1.03: hard resetting port
Feb 28 20:31:21 [kernel] ata1.03: softreset failed (SRST command error)
Feb 28 20:31:21 [kernel] ata1.03: follow-up softreset failed, retrying in 5=
 secs
Feb 28 20:31:26 [kernel] ata1.03: hard resetting port
Feb 28 20:31:26 [kernel] ata1.03: COMRESET failed (errno=3D-5)
Feb 28 20:31:26 [kernel] ata1.03: reset failed, giving up
Feb 28 20:31:26 [kernel] ata1.15: hard resetting port
Feb 28 20:31:26 [kernel] ata1: controller in dubious state, performing PORT=
_RST
Feb 28 20:31:28 [kernel] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
Feb 28 20:31:28 [kernel] ata1.00: hard resetting port
Feb 28 20:31:29 [kernel] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:29 [kernel] ata1.01: hard resetting port
Feb 28 20:31:29 [kernel] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:29 [kernel] ata1.02: hard resetting port
Feb 28 20:31:30 [kernel] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:30 [kernel] ata1.03: hard resetting port
Feb 28 20:31:30 [kernel] ata1.03: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:30 [kernel] ata1.04: hard resetting port
Feb 28 20:31:31 [kernel] ata1.04: softreset failed (SRST command error)
Feb 28 20:31:31 [kernel] ata1.04: follow-up softreset failed, retrying in 5=
 secs
Feb 28 20:31:36 [kernel] ata1.04: hard resetting port
Feb 28 20:31:36 [kernel] ata1.04: hardreset failed (port not ready)
Feb 28 20:31:36 [kernel] ata1.04: reset failed, giving up
Feb 28 20:31:36 [kernel] ata1.15: hard resetting port
Feb 28 20:31:36 [kernel] ata1: controller in dubious state, performing PORT=
_RST
Feb 28 20:31:38 [kernel] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 0)
Feb 28 20:31:38 [kernel] ata1.00: hard resetting port
Feb 28 20:31:39 [kernel] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:39 [kernel] ata1.01: hard resetting port
Feb 28 20:31:40 [kernel] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:40 [kernel] ata1.02: hard resetting port
Feb 28 20:31:40 [kernel] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:40 [kernel] ata1.03: hard resetting port
Feb 28 20:31:41 [kernel] ata1.03: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:41 [kernel] ata1.04: hard resetting port
Feb 28 20:31:41 [kernel] ata1.04: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
Feb 28 20:31:41 [kernel] ata1.00: ATA-7, max UDMA/133, 625142448 sectors: L=
BA48 NCQ (depth 31/32)
Feb 28 20:31:41 [kernel] ata1.00: configured for UDMA/133
Feb 28 20:31:41 [kernel] ata1.01: ATA-7, max UDMA/133, 625142448 sectors: L=
BA48 NCQ (depth 31/32)
Feb 28 20:31:41 [kernel] ata1.01: configured for UDMA/133
Feb 28 20:31:41 [kernel] ata1.02: ATA-7, max UDMA/133, 625142448 sectors: L=
BA48 NCQ (depth 31/32)
Feb 28 20:31:41 [kernel] ata1.02: configured for UDMA/133
Feb 28 20:31:41 [kernel] ata1.03: ATA-7, max UDMA/133, 625142448 sectors: L=
BA48 NCQ (depth 31/32)
Feb 28 20:31:41 [kernel] ata1.03: configured for UDMA/133
Feb 28 20:31:41 [kernel] ata1.04: ATA-7, max UDMA/133, 625142448 sectors: L=
BA48 NCQ (depth 31/32)
Feb 28 20:31:41 [kernel] ata1.04: configured for UDMA/133
Feb 28 20:31:41 [kernel] ata1: EH complete

--=20
Robin Hugh Johnson
Gentoo Linux Developer
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFF8e5nPpIsIjIzwiwRAp4tAKDm5CM7M+OVs0w6YgO7t735GTy37gCg8/5T
efVTEX5iB+Unc1H+4mFx7f0=
=Hluz
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
