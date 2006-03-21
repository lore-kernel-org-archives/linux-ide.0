From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Some sata_mv error messages
Date: Mon, 20 Mar 2006 20:02:06 -0500
Message-ID: <441F508E.1030008@pobox.com>
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54500 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751377AbWCUBCL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Mar 2006 20:02:11 -0500
In-Reply-To: <20060320133318.GB32762@favonius>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sander@humilis.net
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, lkml@rtr.ca

Sander wrote:
> Hi all,
> 
> While sata_mv in 2.6.16-rc6-mm2 seems stable (yah!) compared to
> 2.6.16-rc6 (no crashes, no data corruption), I still get these messages:
> 
> [ 3962.139906] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 3962.139959] ata5: status=0xd0 { Busy }
> 
> [ 6105.948045] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 6105.948097] ata6: status=0xd0 { Busy }
> 
> [ 7981.164936] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 7981.164991] ata5: status=0xd0 { Busy }
> 
> [ 8273.951019] ata7: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 8273.951072] ata7: status=0xd0 { Busy }
> 
> [ 9903.032350] ata8: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 9903.032402] ata8: status=0xd0 { Busy }
> 
> 
> I'm not entirely sure this is only happens on sata_mv (Marvell
> MV88SX6081) as out of eight disks only one is connected to the onboard
> sata_nv (nVidia) and the error doesn't happen very often. But I'll keep
> an eye on it.
> 
> Are these messages somehow dangerous or otherwise indicating a
> potentional serious problem? A google search came up with a few links,
> but none of them helped me understand the messages.

Without answering your specific question, just remember that sata_mv is 
considerly "highly experimental" right now, and still needs some 
workarounds for hardware errata.

For now, the goal is a system that doesn't crash and doesn't corrupt 
data.  If its occasionally slow or spits out a few errors, but otherwise 
still works, that's pretty darned good :)

	Jeff


