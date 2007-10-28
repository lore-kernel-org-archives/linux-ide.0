From: Jens =?iso-8859-1?q?Pr=FCfer?= <jens.pruefer@gmx.de>
Subject: Re: AW: Possible NCQ problem with Seagate ST3250620NS/nForce 4
Date: Sun, 28 Oct 2007 19:17:46 +0100
Message-ID: <200710281917.46955.jens.pruefer@gmx.de>
References: <773425.40044.qm@web26007.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42083 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751097AbXJ1SRt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Oct 2007 14:17:49 -0400
In-Reply-To: <773425.40044.qm@web26007.mail.ukl.yahoo.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kuckuck Kuckuck <gentoopower@yahoo.de>
Cc: linux-ide@vger.kernel.org

Hi Kuckuck,

sorry for the late reply, but I have been on the road the last few days=
=2E

> Someone from the list mentioned that a bad/weak PSU may be responsibl=
e
> for the trouble. It was hard for me to believe that this was the case=
,
> since my system only uses 130W at full load and my former 350W PSU ha=
d
> 170W output power.=20

I am also using very high quality compontents. ASUS A8N-SLI Premium=20
mainboards in both cases (see blelow), SeaSonic PSU 450 W, passively co=
oled=20
low-end GPU (NVidia 8500GT), no frills, nothing to bring down either po=
wer=20
line (5 V or 12 V) of the PSU.=20

However, I am running into the same problems on a different machine wit=
h a
SAMSUNG SP2504C SATA drive.

--- snip ---
[ =A0 =A00.000000] Linux version 2.6.22-14-generic (buildd@palmer) (gcc=
 version=20
4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Sun Oct 14=
=20
23:05:12 GMT 2007 (Ubuntu 2.6.22-14.46-generic)
=2E..
[ =A0 =A04.936000] sata_nv 0000:00:08.0: version 3.4
[ =A0 =A04.936000] sata_nv 0000:00:08.0: Using ADMA mode
=2E..

[ =A0800.196000] ata1: timeout waiting for ADMA IDLE, stat=3D0x400
[ =A0800.196000] ata1: timeout waiting for ADMA LEGACY, stat=3D0x400
[ =A0800.196000] ata1.00: exception Emask 0x0 SAct 0x7ffff SErr 0x20000=
0=20
action 0x2 frozen
[ =A0800.196000] ata1.00: cmd 61/00:00:1c:03:3c/04:00:1b:00:00/40 tag 0=
 cdb=20
0x0 data 524288 out
[ =A0800.196000] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00:0=
0/00 Emask 0x4=20
(timeout)
[ =A0800.196000] ata1.00: cmd 61/00:08:1c:ff:3b/02:00:1b:00:00/40 tag 1=
 cdb=20
0x0 data 262144 out
[ =A0800.196000] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00:0=
0/00 Emask 0x4=20
(timeout)
[ =A0800.196000] ata1.00: cmd 61/00:10:1c:01:3c/02:00:1b:00:00/40 tag 2=
 cdb=20
0x0 data 262144 out
=2E..
[ =A0918.972000] ata1: timeout waiting for ADMA IDLE, stat=3D0x400
[ =A0918.972000] ata1: timeout waiting for ADMA LEGACY, stat=3D0x400
[ =A0918.972000] ata1.00: NCQ disabled due to excessive errors
[ =A0918.972000] ata1.00: exception Emask 0x0 SAct 0x1fffff SErr 0x0 ac=
tion=20
0x2 frozen
[ =A0918.972000] ata1.00: cmd 60/08:00:f4:75:14/00:00:1b:00:00/40 tag 0=
 cdb=20
0x0 data 4096 in
[ =A0918.972000] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00:0=
0/00 Emask 0x4=20
(timeout)
[ =A0918.972000] ata1.00: cmd 61/08:08:bc:1e:fe/00:00:1a:00:00/40 tag 1=
 cdb=20
0x0 data 4096 out
[ =A0918.972000] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00:0=
0/00 Emask 0x4=20
(timeout)
[ =A0918.972000] ata1.00: cmd 61/40:10:ac:1d:4a/00:00:1a:00:00/40 tag 2=
 cdb=20
0x0 data 32768 out
[ =A0918.972000] =A0 =A0 =A0 =A0 =A0res 40/00:00:00:00:00/00:00:00:00:0=
0/00 Emask 0x4=20
(timeout)
=2E..
[ =A0919.284000] ata1: soft resetting port
[ =A0919.440000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ =A0919.960000] ata1.00: configured for UDMA/133
[ =A0919.960000] ata1: EH complete
[ =A0920.056000] sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors =
(250059=20
MB)
[ =A0920.056000] sd 0:0:0:0: [sda] Write Protect is off
[ =A0920.056000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[ =A0920.056000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: en=
abled,=20
doesn't support DPO or FUA

=2E.. and the drive is working again.

The common denominator here is: both machines use the NForce4 chipset, =
both=20
use the sata_nv driver and both are trying to use LVM over dm-crypt.

The very same hardware without LVM over dm-crypt runs like a charm.=20

I am of course not sure, but is it possible that there might be a bug w=
hen
combining sata_nv, NCQ and LVM mapped devices? Can someone else look in=
to=20
this issue?

Thanks!

Jens
