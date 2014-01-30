From: "matson" <lists-matsonpa@luxsci.me>
Subject: Re: additional model for sata_sil Mod15Write list
Date: Thu, 30 Jan 2014 03:24:15 +0000
Message-ID: <201401300324.s0U3OFFs006205@rs101.luxsci.com>
Reply-To: lists-matsonpa@luxsci.me
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rs101.luxsci.com ([74.205.104.180]:36213 "EHLO rs101.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbaA3DaR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2014 22:30:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org


Tejun Heo:
> Matson, can you please post the results of dd tries with varying io s=
izes=A0
> from your previous email?

Those were numbers off the top of my head. =A0Here are real results:



dd oflag=3Ddirect if=3D/dev/zero of=3D/dev/sdb bs=3D7680
Never caused a problem. =A0I tried count as high as 100000.

dd oflag=3Ddirect if=3D/dev/zero of=3D/dev/sdb bs=3D8192 count=3D1
Caused timeout one time in one hundred trials.

dd oflag=3Ddirect if=3D/dev/zero of=3D/dev/sdb bs=3D8192 count=3D2
Caused timeout one time in one hundred trials.

dd oflag=3Ddirect if=3D/dev/zero of=3D/dev/sdb bs=3D8192 count=3D4
Caused timeout four times in one hundred trials.

dd oflag=3Ddirect if=3D/dev/zero of=3D/dev/sdb bs=3D8192 count=3D8
Caused timeout four times in one hundred trials.

dd oflag=3Ddirect if=3D/dev/zero of=3D/dev/sdb bs=3D8192 count=3D16
Caused timeout nine times in one hundred trials.

dd oflag=3Ddirect if=3D/dev/zero of=3D/dev/sdb bs=3D8192 count=3D32
Caused timeout fourteen times in fifty trials.

dd oflag=3Ddirect if=3D/dev/zero of=3D/dev/sdb bs=3D8192 count=3D64
Caused timeout thirteen times in twenty-five trials.
(Nine runs with one 30s timeout; two runs with 60 seconds of timeouts.)

dd oflag=3Ddirect if=3D/dev/zero of=3D/dev/sdb bs=3D8192 count=3D128
Caused timeout seventeen times in ten trials.
(Two runs with one 30s timeout; one run with 60 seconds of timeouts;
three runs with 90 seconds of timeouts; one run with 120 seconds of tim=
eouts.)



dd oflag=3Ddirect of=3D/dev/sdb if=3D/dev/zero count=3D1 bs=3D16k
Caused timeout zero times in one hundred trials.

dd oflag=3Ddirect of=3D/dev/sdb if=3D/dev/zero count=3D1 bs=3D32k
Caused timeout six times in fifty trials.

dd oflag=3Ddirect of=3D/dev/sdb if=3D/dev/zero count=3D1 bs=3D64k
Caused timeout three times in fifty trials.

dd oflag=3Ddirect of=3D/dev/sdb if=3D/dev/zero count=3D1 bs=3D128k
Caused timeout five times in fifty trials.

dd oflag=3Ddirect of=3D/dev/sdb if=3D/dev/zero count=3D1 bs=3D256k
Caused timeout eight times in fifty trials.
(Six runs with one 30s timeout; one run with 60 seconds of timeouts.)

dd oflag=3Ddirect of=3D/dev/sdb if=3D/dev/zero count=3D1 bs=3D512k
Caused timeout sixteen times in twenty-five trials.
(Three runs with one 30s timeout; two runs with 60 seconds of timeouts;
three runs with 90 seconds of timeouts.)



dd oflag=3Ddirect of=3D/dev/sdb if=3D/dev/zero count=3D1 bs=3D1024k

Yielded somewhat different information in dmesg:
ata9.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata9.00: failed command: WRITE DMA EXT
ata9.00: cmd 35/00:00:00:00:00/00:04:00:00:00/e0 tag 0 dma 524288 out
=A0 =A0 =A0 =A0 =A0res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (t=
imeout)
ata9.00: status: { DRDY }
ata9: hard resetting link
ata0: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata9.00: configured for UDMA/33
ata9.00: device reported invalid CHS sector 0
sd 8:0:0:0: [sdb]
Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
sd 8:0:0:0: [sdb]
Sense Key : Aborted Command [current] [descriptor]
Descriptor sense data with sense discriptors (in hex):
=A0 =A0 =A0 =A0 72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
=A0 =A0 =A0 =A0 00 00 00 00
sd 8:0:0:0: [sdb]
Add. Sense: No additional sense information
sd 8:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 00 00 00 00 04 00 00
end_request: I/O error, dev sdb, sector 0
ata9: EH complete



>> My HDD is HP part 625239, firmware is MH000C. =A0I do know whether
> =A0
> I suppose you meant to write "do not know"?

You are correct, I mistyped. =A0I have only this one drive, and I do _n=
ot_ know=A0
whether other models or firmwares have this problem.  Mine is dated 22N=
OV2011.



> Can you please post the output "hdparm -I" on your device?

here it is:

/dev/sdb:

ATA device, with non-removable media
	Model Number: =A0 =A0 =A0 TOSHIBA MK2561GSYN =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0
	Serial Number: =A0 =A0 =A0Y1MGP3F0T
	Firmware Revision: =A0MH000C =A0
	Transport: =A0 =A0 =A0 =A0 =A0Serial, ATA8-AST, SATA 1.0a, SATA II Ext=
ensions,=20
SATA Rev 2.5, SATA Rev 2.6
Standards:
	Supported: 8 7 6 5=A0
	Likely used: 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors: =A0 16514064
	LBA =A0 =A0user addressable sectors: =A0268435455
	LBA48 =A0user addressable sectors: =A0488397168
	Logical =A0Sector size: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 512 bytes
	Physical Sector size: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 512 bytes
	device size with M =3D 1024*1024: =A0 =A0 =A0238475 MBytes
	device size with M =3D 1000*1000: =A0 =A0 =A0250059 MBytes (250 GB)
	cache/buffer size =A0=3D 16384 KBytes
	Form Factor: 2.5 inch
	Nominal Media Rotation Rate: 7200
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max =3D 16	Current =3D 16
	Advanced power management level: 128
	DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4=
=20
*udma5=A0
	 =A0 =A0 Cycle time: min=3D120ns recommended=3D120ns
	PIO: pio0 pio1 pio2 pio3 pio4=A0
	 =A0 =A0 Cycle time: no flow control=3D120ns =A0IORDY flow control=3D1=
20ns
Commands/features:
	Enabled	Supported:
	 =A0 *	SMART feature set
	 =A0 =A0	Security Mode feature set
	 =A0 *	Power Management feature set
	 =A0 *	Write cache
	 =A0 *	Look-ahead
	 =A0 *	WRITE_BUFFER command
	 =A0 *	READ_BUFFER command
	 =A0 *	NOP cmd
	 =A0 *	DOWNLOAD_MICROCODE
	 =A0 *	Advanced Power Management feature set
	 =A0 *	48-bit Address feature set
	 =A0 *	Device Configuration Overlay feature set
	 =A0 *	Mandatory FLUSH_CACHE
	 =A0 *	FLUSH_CACHE_EXT
	 =A0 *	SMART error logging
	 =A0 *	SMART self-test
	 =A0 *	General Purpose Logging feature set
	 =A0 *	64-bit World wide name
	 =A0 *	IDLE_IMMEDIATE with UNLOAD
	 =A0 *	WRITE_UNCORRECTABLE_EXT command
	 =A0 *	{READ,WRITE}_DMA_EXT_GPL commands
	 =A0 *	Segmented DOWNLOAD_MICROCODE
	 =A0 *	Gen1 signaling speed (1.5Gb/s)
	 =A0 *	Gen2 signaling speed (3.0Gb/s)
	 =A0 *	Native Command Queueing (NCQ)
	 =A0 *	Phy event counters
	 =A0 *	Idle-Unload when NCQ is active
	 =A0 =A0	DMA Setup Auto-Activate optimization
	 =A0 =A0	Device-initiated interface power management
	 =A0 *	Software settings preservation
	 =A0 *	SMART Command Transport (SCT) feature set
	 =A0 *	SCT Read/Write Long (AC1), obsolete
	 =A0 *	SCT Write Same (AC2)
	 =A0 *	SCT Error Recovery Control (AC3)
	 =A0 *	SCT Features Control (AC4)
	 =A0 *	SCT Data Tables (AC5)
Security:=A0
	Master password revision code =3D 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
		supported: enhanced erase
	54min for SECURITY ERASE UNIT. 54min for ENHANCED SECURITY ERASE UNIT.=
=A0
Logical Unit WWN Device Identifier: 50000393a290a53e
	NAA		: 5
	IEEE OUI	: 000039
	Unique ID	: 3a290a53e
Checksum: correct

