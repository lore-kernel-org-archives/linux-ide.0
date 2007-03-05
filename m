From: Tejun Heo <htejun@gmail.com>
Subject: Re: Regression between 2.6.20 and 2.6.21-rc1: NCQ problem with ahci
 and Hitachi drive
Date: Mon, 05 Mar 2007 11:00:33 +0900
Message-ID: <45EB79C1.3070107@gmail.com>
References: <45EB6980.90600@crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:7143 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbXCECAg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Mar 2007 21:00:36 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1612391nze
        for <linux-ide@vger.kernel.org>; Sun, 04 Mar 2007 18:00:34 -0800 (PST)
In-Reply-To: <45EB6980.90600@crans.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Mathieu_B=E9rard?= <Mathieu.Berard@crans.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Adrian Bunk <bunk@stusta.de>

Hello, Mathieu.

Mathieu B=E9rard wrote:
> Hello,
> I have and laptop with an ICH6M SATA Controller and an Hitachi hard d=
rive.
> While it worked well using the ahci module and with NCQ enabled using
> Linux 2.6.20, it does not work anymore (hang at boot) with 2.6.21-rc*
>=20
> My drive is among those that were recently blacklisted (see lkml post
> "[PATCH] libata:
> add NCQ blacklist entries from Silicon Image Windowsdriver)
> (Model Number: HTS541010G9SA00 and Firmware Revision: MBZOC60D)
> This blacklisting patch is in -mm now.
> So there is probably a drive related issue here, I'm just wondering w=
hy
> it just work
> flawlessly with a 2.6.20...
>=20
> Relevant part of kernel log:
> [   16.044663] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   16.089475] ata1.00: ATA-7: HTS541010G9SA00, MBZOC60D, max UDMA/10=
0
> [   16.089525] ata1.00: 195371568 sectors, multi 0: LBA48 NCQ (depth =
31/32)

No, your drive isn't blacklisted yet.  NCQ is still being enabled.

> [   16.091804] ata1.00: configured for UDMA/100
> [   18.151756] SCSI device sda: write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
[--snip--]
> [   18.151856] SCSI device sda: 195371568 512-byte hdwr sectors (1000=
30 MB)
> [   18.151911] sda: Write Protect is off
> [   18.151977] SCSI device sda: write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [....]
> [   48.143940] ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action =
0x2
> frozen
> [   48.143999] ata1.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0
> cdb 0x0 data 4096 in
> [   48.144000]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> 0x4 (timeout)

It looks like IRQ isn't getting through.  Does giving "acpi=3Doff" kern=
el
parameter make any difference?

--=20
tejun
