From: Mark Hatle <fray@gate.crashing.org>
Subject: Re: sata_nv failure on 2.4.18 (Fedora Core 6)
Date: Wed, 25 Oct 2006 00:03:48 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0610250001060.3814@gate.crashing.org>
References: <Pine.LNX.4.64.0610242257410.21847@gate.crashing.org>
 <20061025042811.GJ13677@htj.dyndns.org> <Pine.LNX.4.64.0610242329160.22827@gate.crashing.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:35493 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161338AbWJYFDw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Oct 2006 01:03:52 -0400
In-Reply-To: <Pine.LNX.4.64.0610242329160.22827@gate.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org

Just an FYI.  I rebooted the machine w/ "noapic" (same kernel).  During 
the RAID rebuild I got the following.. (but it did not stop processing)

ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x1950000 action 0x2 frozen
ata1.00: tag 0 cmd 0xea Emask 0x14 stat 0x40 err 0x0 (ATA bus error)
ata1: soft resetting port
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x21)
ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x2 frozen
ata4.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata4.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata4: soft resetting port
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/100
ata4: EH complete
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back

Since both ata1 (sata_nv) and ata4 (sata_sil24) got this, could it be an 
interrupt problem?  Yuck

--Mark

On Tue, 24 Oct 2006, Mark Hatle wrote:

> (response inline)
>
> On Wed, 25 Oct 2006, Tejun Heo wrote:
>
>> Hello,
>> 
>> On Tue, Oct 24, 2006 at 11:01:11PM -0500, Mark Hatle wrote:
>> [--snip--]
>>> When the sata_nv error occurs, raid takes the drive offline, and the
>>> system requires a hard power cycle to reactive the drive.
>>> 
>>> This has occured 5 times since Saturday.  The first time the system
>>> was up more then 12 hours.. second time about the same.. 3rd, 4th
>>> and 5th times occured within 2 hours of the system starting.
>>> 
>>> If there is any other information you need let me know!
>> 
>> Does the problem occur on 2.6.18 but not on earlier version?  If it
>> doesn't happen on 2.6.17, we can rule out h/w problem.
>
> This is a brand new machine.. I did a bunch of hammering on SATA before it 
> went into production, but of course it didn't start to fail until now. I'm 
> not sure if there is an easy way for me to switch to 2.6.17.
>
>> * If 2.6.17 doesn't show the same problem : My first suspicion is
>>  weird IRQ problem.  Play with the usual IRQ options - acpi, noacpi,
>>  etc... and see if anything changes.
