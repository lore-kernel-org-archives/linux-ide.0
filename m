From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: sata_nv failure on 2.4.18 (Fedora Core 6)
Date: Wed, 25 Oct 2006 15:27:08 +1000
Message-ID: <1161754028.22582.47.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0610242257410.21847@gate.crashing.org>
	 <20061025042811.GJ13677@htj.dyndns.org>
	 <Pine.LNX.4.64.0610242329160.22827@gate.crashing.org>
	 <Pine.LNX.4.64.0610250001060.3814@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:24295 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1423006AbWJYF1O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Oct 2006 01:27:14 -0400
In-Reply-To: <Pine.LNX.4.64.0610250001060.3814@gate.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Hatle <fray@gate.crashing.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Wed, 2006-10-25 at 00:03 -0500, Mark Hatle wrote:
> Just an FYI.  I rebooted the machine w/ "noapic" (same kernel).  During 
> the RAID rebuild I got the following.. (but it did not stop processing)
> 
> ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x1950000 action 0x2 frozen
> ata1.00: tag 0 cmd 0xea Emask 0x14 stat 0x40 err 0x0 (ATA bus error)
> ata1: soft resetting port
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: (BMDMA stat 0x21)
> ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata4.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x2 frozen
> ata4.00: tag 0 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata4.00: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
> ata1: soft resetting port
> ata4: soft resetting port
> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata4.00: configured for UDMA/100
> ata4: EH complete
> SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 00 3a 00 00
> SCSI device sdb: drive cache: write back
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> 
> Since both ata1 (sata_nv) and ata4 (sata_sil24) got this, could it be an 
> interrupt problem?  Yuck

If that is the case, then we should probably move the discussion to
lkml...

Ben.


