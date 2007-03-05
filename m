From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_nv: "abnormal status 0x7F on port 0xE407"
Date: Mon, 05 Mar 2007 14:04:28 +0900
Message-ID: <45EBA4DC.3030201@gmail.com>
References: <kjmob4-j82.ln1@tux.abusar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:53300 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbXCEFEb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Mar 2007 00:04:31 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1648358nze
        for <linux-ide@vger.kernel.org>; Sun, 04 Mar 2007 21:04:31 -0800 (PST)
In-Reply-To: <kjmob4-j82.ln1@tux.abusar.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>
Cc: linux-ide@vger.kernel.org

D=E2niel Fraga wrote:
> Linux 2.6.20
> x86_64
> nforce 410 chipset
> ST3160811AS (Seagate 160GB SATA 2)
>=20
> sata_nv 0000:00:0e.0: version 3.2
> ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
> ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LSA0] -> GSI 23 (level, =
low) -> IRQ 23
> PCI: Setting latency timer of device 0000:00:0e.0 to 64
> ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE482 bmdma 0xE000 irq 23
> ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE082 bmdma 0xE008 irq 23
> scsi0 : sata_nv
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: ATA-7, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 0/3=
2)
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/133
> scsi1 : sata_nv
> ata2: SATA link down (SStatus 0 SControl 300)
> ATA: abnormal status 0x7F on port 0xE407
>=20
> 	I bought this HD today and it is working perfectly, but it's
> strange the last message. Should I worry about it?
>=20
> 	I saw many similar logs on Google, so I think it's harmless,
> right? Thanks!

Yeap, it's harmless and the message is being removed in the devel tree.
 Thanks.

--=20
tejun
