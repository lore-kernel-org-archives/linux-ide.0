From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: ata1: COMRESET failed
Date: Mon, 03 Dec 2012 12:16:44 +0100
Message-ID: <50BC8A1C.8070805@suse.cz>
References: <508A7A8A.7030908@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <508A7A8A.7030908@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

On 10/26/2012 01:56 PM, Jiri Slaby wrote:
> Hello,
> 
> at every boot I'm seeing:
> 
> At 5th second:
> ata1: link is slow to respond, please be patient (ready=0)
> 
> At 10th second:
> ata1: COMRESET failed (errno=-16)
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> ata1.00: ATA-7: INTEL SSDSA2M080G2GC, 2CV102HD, max UDMA/133
> ata1.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 31/32)
> ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> ata1.00: configured for UDMA/133
> scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSA2M080 2CV1 PQ: 0 ANSI: 5
> 
> 
> So that I have to wait 5 s for the disk to come up. I tried 3.4.15 and
> 3.6.3, both with the same result.
> 
> 00:1f.2 SATA controller [0106]: Intel Corporation 7 Series Chipset
> Family 6-port SATA Controller [AHCI mode] [8086:1e03] (rev 04)
> 
> Any ideas what is going on?

Anybody? I also tried 3.0, it's there too. And libahci.skip_host_reset=1
works around the issue.

> thanks,
-- 
js
suse labs
