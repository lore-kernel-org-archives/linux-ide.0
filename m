From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil] kernel 2.6.17(-mm2) test - timeout issue
Date: Sun, 25 Jun 2006 12:06:44 +0900
Message-ID: <449DFDC4.5050207@gmail.com>
References: <1151182247.5566.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:33162 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751357AbWFYDGr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 23:06:47 -0400
Received: by py-out-1112.google.com with SMTP id m51so1005417pye
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 20:06:46 -0700 (PDT)
In-Reply-To: <1151182247.5566.18.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TWFydGluIEFtbWVybcO8bGxlcg==?= <tenco@gmx.de>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Martin Ammerm=C3=BCller wrote:
> Hello list!
>=20
> I stress-tested the SATA-hdd of my notebook[0] again with current ker=
nel
> versions.
>=20
> With the 2.6.17 kernel i got a freeze after a timeout message (printe=
d
> on the screen repeatedly). Running a 2.6.17-mm2 kernel, libata/sata_s=
il
> recovered from the timeout, resetting after a 30 second limit.
>=20
> See the attached error-messages and dmesg outputs for details, please=
=2E
>=20
> Regards,
> Martin Ammerm=C3=BCller
> P.S.: Does the reset/error handling procedure which happened when
> testing the 2.6.17-mm2 kernel include loss of data or is this a "clea=
n"
> reset?

=46ailed commands are retried several times, so no data was lost in you=
r=20
case.  If data gets lost, you'll see more error messages from higher=20
layers (SCSI, FS).

> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: (BMDMA stat 0x21)
> ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata1: port is slow to respond, please be patient
> ata1: port failed to respond (30 secs)
> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/100
> ata1: EH complete
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back

It took more than a minute to recover from it.  I think we can use some=
=20
improvement here.  Anyways, if your harddisk is doing this regularly,=20
your hardware is faulty.  Maybe the connection between the controller=20
and the disk is the problem or the disk itself.

--=20
tejun
