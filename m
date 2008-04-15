From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv & pmp support
Date: Tue, 15 Apr 2008 16:14:25 -0400
Message-ID: <48050CA1.5010800@rtr.ca>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org> <48023462.1050305@rtr.ca> <4803C429.6070201@rtr.ca> <4803C850.9010901@rtr.ca> <48040DC8.1050907@gmail.com> <48050904.1040808@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4590 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbYDOUO0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Apr 2008 16:14:26 -0400
In-Reply-To: <48050904.1040808@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
>
>>> [33893.473581] ata3.00: hard resetting link
>>> [33893.896674] ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
>>> [33893.896737] ata3.01: hard resetting link
>>> [33894.334126] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [33894.334126] ata3.02: hard resetting link
>>> [33894.753536] ata3.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [33894.753604] ata3.03: hard resetting link
>>> [33895.190559] ata3.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [33895.190623] ata3.04: hard resetting link
>>> [33895.627372] ata3.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>> [33895.627383] ata3.05: hard resetting link
>>> [33895.945716] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
>>> [33895.946640] ata3.00: ATA-7: ST3400832AS, 3.03, max UDMA/133
>>> [33895.946646] ata3.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 
>>> 31/32)
>>> [33895.947720] ata3.00: configured for UDMA/100
> ..
> 
> Okay, there's the problem, or at least the symptoms.
> With sata_mv, I see "soft resetting link" messages there (above),
> rather than the desired "hard resetting link".
> 
> I wonder why that is?
> 
> And another oddity:  on initial module load, sata_mv never finds the PM,
> until I rmmod and then insmod again.  Always on the second try.
> 
> It's almost as if the hard/soft reset functions were reversed (?).
..

Heh.  Okay, apparently it now needs a .pmp_hardreset function,
which was never there before.  So I've now added one that does this:

	mv_pmp_select(link->ap, sata_srst_pmp(link));
        return sata_std_hardreset(link, class, deadline);

And it seems to be working now with that function supplied, at least for port-0.
Anything else new that it should have?  I'll scan through libata-pmp.c and see.

Time to clean out the debug cruft and test a few things a bit more.

Cheers
