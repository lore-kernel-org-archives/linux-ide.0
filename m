From: "Alex Gonzalez" <langabe@gmail.com>
Subject: Re: [libata/sata_sil] Error on startup
Date: Mon, 15 Sep 2008 16:53:53 +0100
Message-ID: <c58a7a270809150853mb9e0752x29cdba7e92097f90@mail.gmail.com>
References: <c58a7a270809120334r16164e3ej9f8ab769a09742ed@mail.gmail.com>
	 <c58a7a270809120427p2af9885eo9cbc2d4455372882@mail.gmail.com>
	 <48CBB831.9030403@ru.mvista.com>
	 <c58a7a270809131023g6c5dad8em8cee2ace3b678209@mail.gmail.com>
	 <48CE2389.9080205@kernel.org>
	 <c58a7a270809150249qa0bb8e5ifdbfeb7fb5ef0565@mail.gmail.com>
	 <48CE3497.4000604@kernel.org>
	 <c58a7a270809150320qd275503lbd5101eb870511c4@mail.gmail.com>
	 <48CE37F6.40301@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:60534 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbYIOPx4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Sep 2008 11:53:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1407483fgg.17
        for <linux-ide@vger.kernel.org>; Mon, 15 Sep 2008 08:53:54 -0700 (PDT)
In-Reply-To: <48CE37F6.40301@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Hi all,

I got some more information regarding this issue.

After reading "PCI Compatibility and PCI-Native Mode Bus Master
Adapters" as pointed by Sergei, I printed the Bus Master ATA status
register (offset 0x2), the PCI status/command (offset 0x4) register
and the SATA ATA status (offset 0x104), control (offset 0x100) and
error (offset 0x108) registers looking for clues.

:***sil_freeze()***
0:***ata_bmdma_status=00000002
0:PCI status=02b00016
0:SATA status 00000113 ctl 00000310 err 00000000

Everything looks fine to me, except maybe bits 1 and 4 of the PCI
status. The Silicon Image Sil3512 datasheet specifies that bit 4
should be hardcoded to zero, and bit 0 (the IO space enable)  is
strangely zero, maybe it's set dynamically when needed?

Following on Tejun's advise, I found out that just the delay of a
printk in ata_bmdma_stop(), right after the iowrite8,  gets rid of the
cache error and it's replaced by this:

[4294671.719000] 0:<7>sata_sil 0000:00:01.0: version 2.1
[4294671.720000] 0:<6>sata_sil 0000:00:01.0: Applying R_ERR on DMA
activate FIS errata fix
[4294671.722000] 0:<6>ata1: SATA max UDMA/100 cmd 0xc0000080 ctl
0xc000008a bmdma 0xc0000000 irq 24
[4294671.724000] 0:<6>ata2: SATA max UDMA/100 cmd 0xc00000c0 ctl
0xc00000ca bmdma 0xc0000008 irq 24
[4294671.725000] 0:<6>scsi0 : sata_sil
[4294672.182000] 2:<6>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[4294672.205000] 2:drivers/ata/libata-sff.c:368: Delay
[4294672.219000] 2:<6>ata1.00: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
[4294672.238000] 2:<6>ata1.00: 312581808 sectors, multi 0: LBA48 NCQ
(depth 0/32)
[4294672.259000] 2:drivers/ata/libata-sff.c:368: Delay
[4294672.277000] 2:drivers/ata/libata-sff.c:368: Delay
[4294672.291000] 2:<6>ata1.00: configured for UDMA/100
[4294672.306000] 0:<6>scsi1 : sata_sil
[4294672.610000] 2:<6>ata2: SATA link down (SStatus 0 SControl 310)
[4294672.628000] 0:<5>scsi 0:0:0:0: Direct-Access     ATA
ST3160815AS      4.AA PQ: 0 ANSI: 5
[4294672.630000] 0:<5>SCSI device sda: 312581808 512-byte hdwr sectors
(160042 MB)
[4294672.631000] 0:<5>sda: Write Protect is off
[4294672.632000] 0:<7>sda: Mode Sense: 00 3a 00 00
[4294672.633000] 0:<5>SCSI device sda: write cache: enabled, read
cache: enabled, doesn't support DPO or FUA
[4294672.634000] 0:<5>SCSI device sda: 312581808 512-byte hdwr sectors
(160042 MB)
[4294672.635000] 0:<5>sda: Write Protect is off
[4294672.636000] 0:<7>sda: Mode Sense: 00 3a 00 00
[4294672.637000] 0:<5>SCSI device sda: write cache: enabled, read
cache: enabled, doesn't support DPO or FUA
[4294672.638000] 0:<6> sda:0:drivers/ata/libata-sff.c:368: Delay
[4294702.640000] 0:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[4294702.641000] 0:<3>ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0
tag 0 cdb 0x0 data 4096 in
[4294702.641000]          res 40/00:00:00:00:00/00:00:00:00:00/00
Emask 0x20 (host bus error)
[4294702.646000] 0:<4>ATA: abnormal status 0x58 on port 0xc0000087
[4294702.651000] 0:<4>ATA: abnormal status 0x58 on port 0xc0000087
[4294702.652000] 0:<4>ATA: abnormal status 0x58 on port 0xc0000087
[4294702.652000] 0:<4>ATA: abnormal status 0x58 on port 0xc0000087
[4294702.652000] 0:<4>ATA: abnormal status 0x58 on port 0xc0000087
[4294702.652000] 0:<4>ATA: abnormal status 0x58 on port 0xc0000087

and never comes back.

I'll try to decode the ATA error see where it takes me next.

Thanks for your continued help and patience,
Alex



On Mon, Sep 15, 2008 at 11:24 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> Alex Gonzalez wrote:
>> I haven't placed the drive under stress test, but it does work OK
>> under normal conditions without errors or timeouts in the log.
>
> Hmm... Okay.
>
>>>From the cache error, I know that the physical region iomapped in
>> 0xf0000000 - 0xf0000200 is the PCI memory space, so the exception is
>> being caused by trying to access this area.
>>
>> I haven't yet looked deeply into it, I was assuming the action of
>> stopping the bmdma engine might have triggered the exception. If not,
>> why not receive an immediate exception without the 10secs timeout?
>
> Yeah, it's caused by EH trying to stop the BMDMA engine but it
> shouldn't.  It works well on other platforms.  Can you try to diagnose
> the bus failure?  Working EH will be able to tell us more about the
> problem.
>
> --
> tejun
>
