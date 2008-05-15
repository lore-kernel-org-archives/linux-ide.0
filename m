From: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Subject: Re: [RESOLVED] Re: libata errors with smartctl on 2.6.24, WD3200AAKS and nVidia AHCI
Date: Thu, 15 May 2008 08:21:50 +0100
Message-ID: <200805150821.50975.tvrtko@ursulin.net>
References: <alpine.BSF.1.00.0805140952250.34461@anduin.net> <482BB1B1.9060804@gmail.com> <Pine.LNX.4.63.0805150027090.15384@trinity.phys.uwm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mk-outboundfilter-3.mail.uk.tiscali.com ([212.74.114.23]:33131
	"EHLO mk-outboundfilter-3.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752558AbYEOHV5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 May 2008 03:21:57 -0400
In-Reply-To: <Pine.LNX.4.63.0805150027090.15384@trinity.phys.uwm.edu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Jim Paris <jim@jtan.com>, Erik Inge =?iso-8859-15?q?Bols=F8?= <knan-ide@anduin.net>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Thursday 15 May 2008 06:28:34 Bruce Allen wrote:
> Gentlemen,
>
> Please reproduce the problem, adding the command-line switch '-r ioct=
l,3'
> which shows return status of various commands, then send session
> transcript.

Unfortunately since reporting this I switched away from vanilla 2.6.24 =
to
Ubuntu's 8.04 version of it so I can't exactly reproduce it right now.
However running smartctl -a still causes a SATA timeout, although the
output looks saner (to me at least).=20

Attached is what I can provide at the moment, for vanilla 2.6.24 I can'=
t
do it before the weekend.

SMART is enabled in the BIOS btw.

---<smartctl 1>--------------------------------------------------------=
----------------------------
root@sol:~# smartctl -a -r ioctl,3 /dev/sda
smartctl version 5.37 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6 B=
ruce Allen
Home page is http://smartmontools.sourceforge.net/

 [inquiry: 12 00 00 00 24 00 ]
  scsi_status=3D0x0, host_status=3D0x0, driver_status=3D0x0
  info=3D0x0  duration=3D0 milliseconds
  Incoming data, len=3D36:
 00     00 00 05 02 5b 00 00 00  41 54 41 20 20 20 20 20
 10     57 44 43 20 57 44 33 32  30 30 41 41 4b 53 2d 30
 20     31 32 2e 30
  status=3D0x0
 [ata pass-through(16): 85 08 0e 00 00 00 01 00 00 00 00 00 00 00 ec 00=
 ]
  scsi_status=3D0x0, host_status=3D0x0, driver_status=3D0x0
  info=3D0x0  duration=3D0 milliseconds
  Incoming data, len=3D512 [only first 256 bytes shown]:
 00     7a 42 ff 3f 37 c8 10 00  00 00 00 00 3f 00 00 00
 10     00 00 00 00 20 20 20 20  57 20 2d 44 43 57 52 41
 20     30 57 35 30 38 39 33 39  00 00 00 80 32 00 32 31
 30     30 2e 42 31 32 30 44 57  20 43 44 57 32 33 30 30
 40     41 41 53 4b 30 2d 56 30  41 59 20 30 20 20 20 20
 50     20 20 20 20 20 20 20 20  20 20 20 20 20 20 10 80
 60     00 00 00 2f 01 40 00 00  00 00 07 00 ff 3f 10 00
 70     3f 00 10 fc fb 00 00 01  ff ff ff 0f 00 00 07 00
 80     03 00 78 00 78 00 78 00  78 00 00 00 00 00 00 00
 90     00 00 00 00 00 00 1f 00  06 07 00 00 44 00 40 00
 a0     fe 01 00 00 6b 74 61 7f  23 41 68 74 41 bc 23 41
 b0     7f 40 2c 00 2c 00 00 00  fe ff 00 00 fe 80 00 00
 c0     00 00 00 00 00 00 00 00  b0 ea 42 25 00 00 00 00
 d0     00 00 00 00 00 00 00 00  01 50 e1 4e 48 00 55 56
 e0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 10 40
 f0     10 40 00 00 00 00 00 00  00 00 00 00 00 00 00 00
  status=3D0x0
Detected SAT interface, switch to device type 'sat'

REPORT-IOCTL: DeviceFD=3D3 Command=3DIDENTIFY DEVICE
 [ata pass-through(16): 85 08 0e 00 00 00 01 00 00 00 00 00 00 00 ec 00=
 ]
  scsi_status=3D0x0, host_status=3D0x0, driver_status=3D0x0
  info=3D0x0  duration=3D0 milliseconds
  Incoming data, len=3D512 [only first 256 bytes shown]:
 00     7a 42 ff 3f 37 c8 10 00  00 00 00 00 3f 00 00 00
 10     00 00 00 00 20 20 20 20  57 20 2d 44 43 57 52 41
 20     30 57 35 30 38 39 33 39  00 00 00 80 32 00 32 31
 30     30 2e 42 31 32 30 44 57  20 43 44 57 32 33 30 30
 40     41 41 53 4b 30 2d 56 30  41 59 20 30 20 20 20 20
 50     20 20 20 20 20 20 20 20  20 20 20 20 20 20 10 80
 60     00 00 00 2f 01 40 00 00  00 00 07 00 ff 3f 10 00
 70     3f 00 10 fc fb 00 00 01  ff ff ff 0f 00 00 07 00
 80     03 00 78 00 78 00 78 00  78 00 00 00 00 00 00 00
 90     00 00 00 00 00 00 1f 00  06 07 00 00 44 00 40 00
 a0     fe 01 00 00 6b 74 61 7f  23 41 68 74 41 bc 23 41
 b0     7f 40 2c 00 2c 00 00 00  fe ff 00 00 fe 80 00 00
 c0     00 00 00 00 00 00 00 00  b0 ea 42 25 00 00 00 00
 d0     00 00 00 00 00 00 00 00  01 50 e1 4e 48 00 55 56
 e0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 10 40
 f0     10 40 00 00 00 00 00 00  00 00 00 00 00 00 00 00
  status=3D0x0
REPORT-IOCTL: DeviceFD=3D3 Command=3DIDENTIFY DEVICE returned 0

=3D=3D=3D=3D=3D [IDENTIFY DEVICE] DATA START (BASE-16) =3D=3D=3D=3D=3D
000-015: 7a 42 ff 3f 37 c8 10 00 00 00 00 00 3f 00 00 00
016-031: 00 00 00 00 20 20 20 20 57 20 2d 44 43 57 52 41
032-047: 30 57 35 30 38 39 33 39 00 00 00 80 32 00 32 31
048-063: 30 2e 42 31 32 30 44 57 20 43 44 57 32 33 30 30
064-079: 41 41 53 4b 30 2d 56 30 41 59 20 30 20 20 20 20
080-095: 20 20 20 20 20 20 20 20 20 20 20 20 20 20 10 80
096-111: 00 00 00 2f 01 40 00 00 00 00 07 00 ff 3f 10 00
112-127: 3f 00 10 fc fb 00 00 01 ff ff ff 0f 00 00 07 00
128-143: 03 00 78 00 78 00 78 00 78 00 00 00 00 00 00 00
144-159: 00 00 00 00 00 00 1f 00 06 07 00 00 44 00 40 00
160-175: fe 01 00 00 6b 74 61 7f 23 41 68 74 41 bc 23 41
176-191: 7f 40 2c 00 2c 00 00 00 fe ff 00 00 fe 80 00 00
192-207: 00 00 00 00 00 00 00 00 b0 ea 42 25 00 00 00 00
208-223: 00 00 00 00 00 00 00 00 01 50 e1 4e 48 00 55 56
224-239: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10 40
240-255: 10 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
256-271: 21 00 00 00 00 00 00 00 00 00 90 16 00 00 00 00
272-287: 00 00 00 00 00 00 00 00 00 00 00 00 04 00 00 00
288-303: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
304-319: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320-335: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
336-351: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
352-367: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
368-383: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
384-399: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400-415: 00 00 00 00 00 00 00 00 00 00 00 00 3f 30 00 00
416-431: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
432-447: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
448-463: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
464-479: 00 00 00 00 01 00 00 10 00 00 00 00 00 00 00 00
480-495: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
496-511: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a5 50
=3D=3D=3D=3D=3D [IDENTIFY DEVICE] DATA END (512 Bytes) =3D=3D=3D=3D=3D

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     WDC WD3200AAKS-00VYA0
Serial Number:    WD-WCARW0059893
=46irmware Version: 12.01B02
User Capacity:    320,072,933,376 bytes
Device is:        Not in smartctl database [for details use: -P showall=
]
ATA Version is:   8
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Thu May 15 08:16:48 2008 BST
SMART support is: Available - device has SMART capability.
SMART support is: Disabled


REPORT-IOCTL: DeviceFD=3D3 Command=3DSMART STATUS
 [ata pass-through(16): 85 06 2c 00 da 00 00 00 00 00 4f 00 c2 00 b0 00=
 ]
  scsi_status=3D0x2, host_status=3D0x0, driver_status=3D0x8
  info=3D0x1  duration=3D0 milliseconds
  >>> Sense buffer, len=3D22:
 00     72 0b 00 00 00 00 00 0e  09 0c 00 04 00 01 00 b4
 10     00 4f 00 c2 00 51
  status=3D2: [desc] sense_key=3Db asc=3D0 ascq=3D0
Values from ATA status return descriptor are:
 00     09 0c 00 04 00 01 00 b4  00 4f 00 c2 00 51
REPORT-IOCTL: DeviceFD=3D3 Command=3DSMART STATUS returned 0

REPORT-IOCTL: DeviceFD=3D3 Command=3DSMART STATUS CHECK
 [ata pass-through(16): 85 06 2c 00 da 00 00 00 00 00 4f 00 c2 00 b0 00=
 ]
  scsi_status=3D0x2, host_status=3D0x0, driver_status=3D0x8
  info=3D0x1  duration=3D6648 milliseconds
  >>> Sense buffer, len=3D22:
 00     72 0b 00 00 00 00 00 0e  09 0c 00 00 00 01 00 b4
 10     00 4f 00 c2 00 40
  status=3D2: [desc] sense_key=3Db asc=3D0 ascq=3D0
Values from ATA status return descriptor are:
 00     09 0c 00 00 00 01 00 b4  00 4f 00 c2 00 40
REPORT-IOCTL: DeviceFD=3D3 Command=3DSMART STATUS CHECK returned 0

REPORT-IOCTL: DeviceFD=3D3 Command=3DSMART READ ATTRIBUTE VALUES
 [ata pass-through(16): 85 08 0e 00 d0 00 01 00 00 00 4f 00 c2 00 b0 00=
 ]
  scsi_status=3D0x2, host_status=3D0x0, driver_status=3D0x8
  info=3D0x1  duration=3D248 milliseconds
  Incoming data, len=3D512 [only first 256 bytes shown]:
 00     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 10     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 20     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 30     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 40     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 50     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 60     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 70     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 80     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 90     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 a0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 b0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 c0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 d0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 e0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 f0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
  >>> Sense buffer, len=3D22:
 00     72 0b 00 00 00 00 00 0e  09 0c 00 04 00 01 00 b4
 10     00 4f 00 c2 00 51
  status=3D2: [desc] sense_key=3Db asc=3D0 ascq=3D0
REPORT-IOCTL: DeviceFD=3D3 Command=3DSMART READ ATTRIBUTE VALUES return=
ed 0

=3D=3D=3D=3D=3D [SMART READ ATTRIBUTE VALUES] DATA START (BASE-16) =3D=3D=
=3D=3D=3D
000-015: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
016-031: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
032-047: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
048-063: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
064-079: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
080-095: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
096-111: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
112-127: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
128-143: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
144-159: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
160-175: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
176-191: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
192-207: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
208-223: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
224-239: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240-255: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
256-271: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
272-287: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
288-303: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
304-319: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320-335: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
336-351: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
352-367: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
368-383: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
384-399: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400-415: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
416-431: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
432-447: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
448-463: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
464-479: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
480-495: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
496-511: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D=3D=3D=3D=3D [SMART READ ATTRIBUTE VALUES] DATA END (512 Bytes) =3D=3D=
=3D=3D=3D


REPORT-IOCTL: DeviceFD=3D3 Command=3DSMART READ ATTRIBUTE THRESHOLDS
 [ata pass-through(16): 85 08 0e 00 d1 00 01 00 01 00 4f 00 c2 00 b0 00=
 ]
  scsi_status=3D0x2, host_status=3D0x0, driver_status=3D0x8
  info=3D0x1  duration=3D0 milliseconds
  Incoming data, len=3D512 [only first 256 bytes shown]:
 00     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 10     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 20     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 30     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 40     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 50     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 60     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 70     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 80     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 90     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 a0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 b0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 c0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 d0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 e0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 f0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
  >>> Sense buffer, len=3D22:
 00     72 0b 00 00 00 00 00 0e  09 0c 00 04 00 01 00 b4
 10     00 4f 00 c2 00 51
  status=3D2: [desc] sense_key=3Db asc=3D0 ascq=3D0
REPORT-IOCTL: DeviceFD=3D3 Command=3DSMART READ ATTRIBUTE THRESHOLDS re=
turned 0

=3D=3D=3D=3D=3D [SMART READ ATTRIBUTE THRESHOLDS] DATA START (BASE-16) =
=3D=3D=3D=3D=3D
000-015: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
016-031: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
032-047: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
048-063: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
064-079: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
080-095: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
096-111: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
112-127: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
128-143: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
144-159: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
160-175: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
176-191: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
192-207: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
208-223: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
224-239: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240-255: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
256-271: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
272-287: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
288-303: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
304-319: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320-335: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
336-351: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
352-367: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
368-383: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
384-399: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400-415: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
416-431: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
432-447: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
448-463: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
464-479: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
480-495: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
496-511: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D=3D=3D=3D=3D [SMART READ ATTRIBUTE THRESHOLDS] DATA END (512 Bytes) =
=3D=3D=3D=3D=3D

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activit=
y
                                        was never started.
                                        Auto Offline Data Collection: D=
isabled.
Total time to complete Offline
data collection:                 (   0) seconds.
Offline data collection
capabilities:                    (0x00)         Offline data collection=
 not supported.
SMART capabilities:            (0x0000) Automatic saving of SMART data =
                                 is not implemented.
Error logging capability:        (0x00) Error logging supported.
                                        General Purpose Logging support=
ed.


REPORT-IOCTL: DeviceFD=3D3 Command=3DSMART READ LOG InputParameter=3D1
 [ata pass-through(16): 85 08 0e 00 d5 00 01 00 01 00 4f 00 c2 00 b0 00=
 ]
  scsi_status=3D0x2, host_status=3D0x0, driver_status=3D0x8
  info=3D0x1  duration=3D4 milliseconds
  Incoming data, len=3D512 [only first 256 bytes shown]:
 00     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 10     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 20     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 30     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 40     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 50     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 60     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 70     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 80     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 90     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 a0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 b0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 c0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 d0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 e0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 f0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
  >>> Sense buffer, len=3D22:
 00     72 0b 00 00 00 00 00 0e  09 0c 00 04 00 01 00 b4
 10     00 4f 00 c2 00 51
  status=3D2: [desc] sense_key=3Db asc=3D0 ascq=3D0
REPORT-IOCTL: DeviceFD=3D3 Command=3DSMART READ LOG returned 0

=3D=3D=3D=3D=3D [SMART READ LOG] DATA START (BASE-16) =3D=3D=3D=3D=3D
000-015: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
016-031: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
032-047: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
048-063: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
064-079: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
080-095: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
096-111: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
112-127: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
128-143: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
144-159: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
160-175: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
176-191: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
192-207: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
208-223: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
224-239: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240-255: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
256-271: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
272-287: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
288-303: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
304-319: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320-335: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
336-351: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
352-367: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
368-383: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
384-399: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400-415: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
416-431: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
432-447: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
448-463: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
464-479: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
480-495: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
496-511: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D=3D=3D=3D=3D [SMART READ LOG] DATA END (512 Bytes) =3D=3D=3D=3D=3D

SMART Error Log Version: 0
No Errors Logged


REPORT-IOCTL: DeviceFD=3D3 Command=3DSMART READ LOG InputParameter=3D6
 [ata pass-through(16): 85 08 0e 00 d5 00 01 00 06 00 4f 00 c2 00 b0 00=
 ]
  scsi_status=3D0x2, host_status=3D0x0, driver_status=3D0x8
  info=3D0x1  duration=3D0 milliseconds
  Incoming data, len=3D512 [only first 256 bytes shown]:
 00     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 10     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 20     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 30     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 40     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 50     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 60     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 70     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 80     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 90     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 a0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 b0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 c0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 d0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 e0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 f0     00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
  >>> Sense buffer, len=3D22:
 00     72 0b 00 00 00 00 00 0e  09 0c 00 04 00 01 00 b4
 10     00 4f 00 c2 00 51
  status=3D2: [desc] sense_key=3Db asc=3D0 ascq=3D0
REPORT-IOCTL: DeviceFD=3D3 Command=3DSMART READ LOG returned 0

=3D=3D=3D=3D=3D [SMART READ LOG] DATA START (BASE-16) =3D=3D=3D=3D=3D
000-015: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
016-031: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
032-047: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
048-063: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
064-079: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
080-095: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
096-111: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
112-127: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
128-143: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
144-159: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
160-175: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
176-191: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
192-207: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
208-223: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
224-239: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240-255: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
256-271: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
272-287: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
288-303: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
304-319: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320-335: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
336-351: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
352-367: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
368-383: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
384-399: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400-415: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
416-431: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
432-447: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
448-463: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
464-479: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
480-495: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
496-511: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D=3D=3D=3D=3D [SMART READ LOG] DATA END (512 Bytes) =3D=3D=3D=3D=3D

SMART Self-test log structure revision number 0
Warning: ATA Specification requires self-test log structure revision nu=
mber =3D 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]


Device does not support Selective Self Tests/Logging
---</smartctl 1>-------------------------------------------------------=
-----------------------------

---<kernel 1>----------------------------------------------------------=
--------------------------
May 15 08:16:54 sol kernel: [  221.680528] ata2.00: exception Emask 0x0=
 SAct 0x0 SErr 0x0 action 0x2 frozen
May 15 08:16:54 sol kernel: [  221.680536] ata2.00: cmd b0/da:00:00:4f:=
c2/00:00:00:00:00/00 tag 0
May 15 08:16:54 sol kernel: [  221.680537]          res 40/00:01:b4:4f:=
c2/00:00:00:00:00/00 Emask 0x4 (timeout)
May 15 08:16:54 sol kernel: [  221.680539] ata2.00: status: { DRDY }
May 15 08:16:54 sol kernel: [  221.680545] ata2: hard resetting link
May 15 08:16:55 sol kernel: [  222.319062] ata2: SATA link up 1.5 Gbps =
(SStatus 113 SControl 310)
May 15 08:16:55 sol kernel: [  222.329415] ata2.00: configured for UDMA=
/133
May 15 08:16:55 sol kernel: [  222.329424] ata2: EH complete
May 15 08:16:55 sol kernel: [  222.329573] sd 1:0:0:0: [sda] 625142448 =
512-byte hardware sectors (320073 MB)
May 15 08:16:55 sol kernel: [  222.329703] sd 1:0:0:0: [sda] Write Prot=
ect is off
May 15 08:16:55 sol kernel: [  222.329706] sd 1:0:0:0: [sda] Mode Sense=
: 00 3a 00 00
May 15 08:16:55 sol kernel: [  222.329980] sd 1:0:0:0: [sda] Write cach=
e: enabled, read cache: enabled, doesn't support DPO or FUA
---</kernel 1>---------------------------------------------------------=
---------------------------


> On Thu, 15 May 2008, Tejun Heo wrote:
> > Jim Paris wrote:
> >> Tejun Heo wrote:
> >>> Tvrtko A. Ursulin wrote:
> >>>> On Wednesday 14 May 2008 08:58:56 Erik Inge Bols=F8 wrote:
> >>>>> The drive does say
> >>>>>
> >>>>>         Enabled Supported:
> >>>>>                 SMART feature set
> >>>>>                 Security Mode feature set
> >>>>>            *    Power Management feature set
> >>>>>            *    Write cache
> >>>>>            *    Look-ahead
> >>>>>
> >>>>> ... so doesn't look like SMART is enabled on the drive.
> >>>>>
> >>>>> Does the problem go away if you do a
> >>>>>
> >>>>> smartctl -s on /dev/sda
> >>>>>
> >>>>> first? :)
> >>>>
> >>>> Indeed it does, shame on me for overseeing that small detail. :)
> >>>
> >>> Oh... shame on me too.  :-)
> >>
> >> Why didn't smartctl notice that?  In my experience it usually does
> >> report when SMART is disabled.  Is the error not being properly
> >> reported back to userspace maybe?  Tvrtko's original problem repor=
t
> >> has lots of uninitialized (or leaked?) data, and a lot of it looks
> >> like ASCII (for example his bogus RAW_VALUEs contain pieces of the
> >> model number).
> >
> > Let's ask Bruce.  Bruce, SMART was disabled on WD3200AAKS but smart=
ctl -a
> > didn't detect it and issued SMART commands anyway triggering timeou=
ts.=20
> > Is this expected behavior?  Or is libata feeding wrong status to
> > smartctl?
> >
> > Thanks.


