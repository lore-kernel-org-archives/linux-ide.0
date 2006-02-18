From: Mark Lord <lkml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Sat, 18 Feb 2006 16:42:48 -0500
Message-ID: <43F794D8.7000406@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F1EE4A.3050107@rtr.ca> <43F58D29.3040608@pobox.com> <200602170959.40286.lkml@rtr.ca> <20060218204340.GA2984@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:17628 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932206AbWBRVmx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Feb 2006 16:42:53 -0500
In-Reply-To: <20060218204340.GA2984@favonius>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sander@humilis.net
Cc: Jeff Garzik <jgarzik@pobox.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Sander wrote:
> Mark Lord wrote (ao):
>> On Friday 17 February 2006 03:45, Jeff Garzik wrote:
>>> Submit a patch... 
>> You mean, something like this one?
...
> [  633.449961] md: md1: sync done.
> [  633.456070] RAID5 conf printout:
> [  633.456117]  --- rd:9 wd:9 fd:0
...
> [ 1872.338185] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 1872.338239] ata6: status=0xd0 { Busy }
> [ 5749.285084] ata8: translated op=0x2a ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 5749.285138] ata8: status=0xd0 { Busy }
> [ 5906.008461] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 5906.008515] ata6: status=0xd0 { Busy }
...
> This is with 2.6.16-rc3, your patch, and running nine Maxtors disks
> over onboard nForce4 and MV88SX6081 8-port SATA II PCI-X Controller (rev 09).
> 
> for i in `seq 10`
> do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000
> done
> md5sum bigfile.*
> 
> The errors mostly seem to happen during the md5sum (not during the dd).

SCSI opcode 0x2a is WRITE_10, so the errors are being reported
in response to the writes to bigfile.$i.  But these are different
from the previously reported error status values -- I wonder why
it's getting "Busy" back as a status here ??

