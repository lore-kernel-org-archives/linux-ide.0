From: Gwendal Grignou <gwendal@google.com>
Subject: Re: Recurring error with SATA driver.
Date: Wed, 4 Jan 2012 18:10:25 -0800
Message-ID: <CAMHSBOW+6cb1BHRsKkB3C=g6eFhVDfkeV5X69Ek4cU+0Srv7AQ@mail.gmail.com>
References: <alpine.LNX.2.00.1201031929290.1620@snarked.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:48665 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756496Ab2AECK0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jan 2012 21:10:26 -0500
Received: by obcwo16 with SMTP id wo16so68629obc.19
        for <linux-ide@vger.kernel.org>; Wed, 04 Jan 2012 18:10:25 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1201031929290.1620@snarked.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "D. Stussy" <replies+newsgroups@kd6lvw.ampr.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Can you give more details?

- output of
lspci -vv -s 0000:00:11.0

- output of
hdparm -I /dev/sda

- 40 lines below and above the error line you reported 'ata1: illegal
qc_active transition (3fffffff->fffffffe)' from /var/log/messages

Gwendal.

On Tue, Jan 3, 2012 at 11:33 AM, D. Stussy
<replies+newsgroups@kd6lvw.ampr.org> wrote:
>
> ata1: illegal qc_active transition (3fffffff->fffffffe)
>
> I'm getting this about once every 3 days. =A0When this happens, the a=
ffected partition is remounted read-only (per my file system error opti=
ons).
>
> I am not certain if this is telling me I have a hardware error, incom=
patibility, or if there's a design problem with the driver.
>
> Seen with kernels: 3.0.14, 3.1.4, 3.1.5, and =A03.1.6
>
> Motherboard: =A0Supermicro H8SCM-F
> Disk Drives: =A0Seagate 1.8TB drives
>
> Kernel log messages:
> pci 0000:00:11.0: set SATA to AHCI mode
> libata version 3.00 loaded.
> ahci 0000:00:11.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SA=
TA mode
> ata1: SATA max UDMA/133 abar m1024@0xfe9fa400 port 0xfe9fa500 irq 22
> ata2: SATA max UDMA/133 abar m1024@0xfe9fa400 port 0xfe9fa580 irq 22
> ata3: SATA max UDMA/133 abar m1024@0xfe9fa400 port 0xfe9fa600 irq 22
> ata4: SATA max UDMA/133 abar m1024@0xfe9fa400 port 0xfe9fa680 irq 22
> ata3: SATA link down (SStatus 0 SControl 300)
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ATA-8: ST32000644NS, SN11, max UDMA/133
> ata1.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32)
> ata2.00: ATA-8: ST32000644NS, SN11, max UDMA/133
> ata2.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/32)
> ata4.00: ATAPI: Optiarc DVD RW AD-7700S, 1.03, max UDMA/100
> ata1.00: configured for UDMA/133
> ata2.00: configured for UDMA/133
> scsi 0:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0ST32000644NS =A0 =A0=
 SN11 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.81 T=
iB)
> scsi 1:0:0:0: Direct-Access =A0 =A0 ATA =A0 =A0 =A0ST32000644NS =A0 =A0=
 SN11 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA
> sd 1:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.81 T=
iB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA
> ata4.00: configured for UDMA/100
> =A0sda: sda1
> sd 0:0:0:0: [sda] Attached SCSI disk
> =A0sdb: sdb1
> sd 1:0:0:0: [sdb] Attached SCSI disk
> scsi 3:0:0:0: CD-ROM =A0 =A0 =A0 =A0 =A0 =A0Optiarc =A0DVD RW AD-7700=
S =A01.03 PQ: 0 ANSI: 5
>
> Kernel options:
> CONFIG_SCSI_SAS_ATA=3Dy
> CONFIG_ATA=3Dy
> CONFIG_ATA_VERBOSE_ERROR=3Dy
> CONFIG_ATA_ACPI=3Dy
> CONFIG_SATA_PMP=3Dy
> CONFIG_SATA_AHCI=3Dy
> CONFIG_ATA_SFF=3Dy
> CONFIG_ATA_BMDMA=3Dy
> CONFIG_PATA_AMD=3Dy
> CONFIG_ATA_GENERIC=3Dy
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
