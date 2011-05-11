From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: 2.6.39-rc6: SATA hangs for a few seconds during boot
Date: Wed, 11 May 2011 21:33:08 +0200
Message-ID: <201105112133.09261.maciej.rutecki@gmail.com>
References: <20110509204801.GA2258@x61.home>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43139 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362Ab1EKTdO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 May 2011 15:33:14 -0400
In-Reply-To: <20110509204801.GA2258@x61.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tino Keitel <tino.keitel@tikei.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

I created a Bugzilla entry at=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D34952
for your bug report, please add your address to the CC list in there, t=
hanks!

On poniedzia=C5=82ek, 9 maja 2011 o 22:48:01 Tino Keitel wrote:
> Hi,
>=20
> I get a hanging SATA port for a few seconds during boot, with these
> kernel messages:
>=20
> ata1.00: exception Emask 0x0 SAct 0x3 SErr 0x40000 action 0x6 frozen
> ata1.00: cmd 60/20:00:55:e1:65/00:00:00:00:00/40 tag 0 ncq 16384 in
>          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1.00: cmd 60/02:08:c1:5c:03/00:00:00:00:00/40 tag 1 ncq 1024 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata1: hard resetting link
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: both IDENTIFYs aborted, assuming NODEV
> ata1.00: revalidation failed (errno=3D-2)
> ata1: hard resetting link
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (unknown) succeeded
> ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (unknown) filtered out
> ata1.00: ACPI cmd ef/5f:00:00:00:00:a0 (unknown) succeeded
> ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (unknown) filtered out
> ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (unknown) succeeded
> ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (unknown) filtered out
> ata1.00: ACPI cmd ef/5f:00:00:00:00:a0 (unknown) succeeded
> ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (unknown) filtered out
> ata1.00: configured for UDMA/133
> ata1.00: device reported invalid CHS sector 0
> ata1.00: device reported invalid CHS sector 0
> ata1: EH complete
>=20
> This happens with 2.6.39-rc6 with TuxOnIce patch included, but during=
 boot
> without any suspend actions. The hardware is a ThinkPad X61s:
>=20
> 00:1f.2 SATA controller: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-=
E)
> SATA AHCI Controller (rev 03)
>=20
> Complete dmesg is attached.
>=20
> Regards,
> Tino

--=20
Maciej Rutecki
http://www.maciek.unixy.pl
