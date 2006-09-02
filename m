From: Derek Taubert <taubert@geeks.org>
Subject: Re: Bad write performance with libata-tj-stable-2.6.17.4-20060710, pcmcia based sata_sil24, PMP, and NCQ drive
Date: Fri, 1 Sep 2006 22:34:59 -0700
Message-ID: <20060902053459.GA4467@geeks.org>
References: <20060828230132.GB20189@geeks.org> <44F3A8FD.6090108@gmail.com> <20060829045816.GA21746@geeks.org> <44F440BE.80000@gmail.com> <20060829164424.GA1603@geeks.org> <44F8365C.2020609@gmail.com> <20060901172435.GA26975@geeks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jacobs.geeks.org ([204.153.247.1]:62188 "EHLO mail.geeks.org")
	by vger.kernel.org with ESMTP id S1750711AbWIBFfC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Sep 2006 01:35:02 -0400
Content-Disposition: inline
In-Reply-To: <20060901172435.GA26975@geeks.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Derek Taubert <taubert@geeks.org>, linux-ide@vger.kernel.org

On Fri, Sep 01, 2006 at 10:24:35AM -0700, Derek Taubert wrote:
> I'm going to try narrowing the scope of the test next.  Will purchase
> an eSATA<->SATA cable today and try bypassing the port multiplier.
> 
> If that works, I'll try using one drive at a time on the PMP.

Well, that didn't change the performance one bit:

ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 1465149168 sectors: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/100
ata2: EH complete
  Vendor: ATA       Model: ST3750640AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 1465149168 512-byte hdwr sectors (750156 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 1465149168 512-byte hdwr sectors (750156 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1
sd 1:0:0:0: Attached scsi disk sda
sd 1:0:0:0: Attached scsi generic sg0 type 0

root@linux-srv:~ # dd if=/dev/zero of=/dev/sda1 bs=1M count=100
100+0 records in
100+0 records out
104857600 bytes (105 MB) copied, 54.1042 seconds, 1.9 MB/s

root@linux-srv:~ # dd of=/dev/zero if=/dev/sda1 bs=1M count=1000
1000+0 records in
1000+0 records out
1048576000 bytes (1.0 GB) copied, 20.079 seconds, 52.2 MB/s

I'm now suspecting that the performance problems are due to bus issues
on the PCMCIA/PCI side.  Will poke around there and maybe try this with
a different laptop...

Thanks,
Derek

-- 
VGER BF report: H 5.11438e-07
