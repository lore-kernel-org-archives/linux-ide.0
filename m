From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_nv failure on 2.4.18 (Fedora Core 6)
Date: Wed, 25 Oct 2006 14:46:08 +0900
Message-ID: <453EFA20.9050208@gmail.com>
References: <Pine.LNX.4.64.0610242257410.21847@gate.crashing.org>	 <20061025042811.GJ13677@htj.dyndns.org>	 <Pine.LNX.4.64.0610242329160.22827@gate.crashing.org>	 <Pine.LNX.4.64.0610250001060.3814@gate.crashing.org> <1161754028.22582.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:18584 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423013AbWJYFqS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Oct 2006 01:46:18 -0400
Received: by nf-out-0910.google.com with SMTP id c2so476508nfe
        for <linux-ide@vger.kernel.org>; Tue, 24 Oct 2006 22:46:16 -0700 (PDT)
In-Reply-To: <1161754028.22582.47.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mark Hatle <fray@gate.crashing.org>, linux-ide@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Wed, 2006-10-25 at 00:03 -0500, Mark Hatle wrote:
>> Just an FYI.  I rebooted the machine w/ "noapic" (same kernel).  During 
>> the RAID rebuild I got the following.. (but it did not stop processing)
>>
>> ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x1950000 action 0x2 frozen
>> ata1.00: tag 0 cmd 0xea Emask 0x14 stat 0x40 err 0x0 (ATA bus error)
>> ata1: soft resetting port
>> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> ata1.00: configured for UDMA/133
>> ata1: EH complete
>> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
>> sda: Write Protect is off
>> sda: Mode Sense: 00 3a 00 00
>> SCSI device sda: drive cache: write back
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>> ata1.00: (BMDMA stat 0x21)
>> ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
>> ata4.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x2 frozen
>> ata4.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
>> ata4.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
>> ata1: soft resetting port
>> ata4: soft resetting port
>> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata4.00: configured for UDMA/100
>> ata4: EH complete
>> SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
>> sdb: Write Protect is off
>> sdb: Mode Sense: 00 3a 00 00
>> SCSI device sdb: drive cache: write back
>> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> ata1.00: configured for UDMA/133
>> ata1: EH complete
>> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
>> sda: Write Protect is off
>> sda: Mode Sense: 00 3a 00 00
>> SCSI device sda: drive cache: write back
>>
>> Since both ata1 (sata_nv) and ata4 (sata_sil24) got this, could it be an 
>> interrupt problem?  Yuck

I dunno.  The weird IRQ problem theory was primarily based on the 
assumption the problem occurs only on 2.6.18, so it's a bit flimsy at 
this point.  Can you verify that the system behaves differently when 
apci is turned on and off?  You probably need to test several times to 
find out the pattern.

It's very weird that both controllers time out at the same moment.  Also 
in the above log, sata_nv is reporting DMA engine is still running when 
it timed out suggesting transmission error.  So, it might be that you 
have some problem in your system which causes transient transmission 
errors and sata_nv chokes up on such events.  sata_sil24 should be able 
to handle all those pretty well tho.

In the past, we had several similar cases and some of them turned out to 
be power problem - insufficient and/or faulty PSU, and some others 
faulty drive.  I think performing regular hw debugging stuff would be 
useful.

* Swap drives / cables / connected ports.  See if error follows 
controllers or drives or cables.

* If available, use separate PSU to power harddrives.  Just put another 
machine close, take SATA power cables and connect them to drives.  SATA 
signals don't need common ground, so there's nothing to worry about.

> If that is the case, then we should probably move the discussion to
> lkml...

I think diagnosing a bit more here can be helpful.

Thanks.

-- 
tejun
