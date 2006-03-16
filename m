From: Jens Axboe <axboe@suse.de>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Thu, 16 Mar 2006 11:08:38 +0100
Message-ID: <20060316100838.GF3595@suse.de>
References: <1142344212.4416ca14a26b4@webmail.aon.at> <44182CD7.9070401@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:14121 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1752016AbWCPKJW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Mar 2006 05:09:22 -0500
Content-Disposition: inline
In-Reply-To: <44182CD7.9070401@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: me_trash1@aon.at, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Wed, Mar 15 2006, Mark Lord wrote:
> me_trash1@aon.at wrote:
> >Hi!
> >
> >short:
> >system with 2.6.15.4 with Mark Lord's opcode info patches
> >sata_mv (Adaptec 1420SA Marvell 88SX6541)
> >e.g. postgres:insert&delete gives: ata3: translated op=0x2a cmd=0x35 ATA 
> >stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> >or sometimes (unknown cause):
> >ata4: translated op=0x28 cmd=0x25 ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 
> >0xb/47/00
> >ata4: status=0xd0 { Busy }
> >Assertion failed! ((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >> 
> >EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == pp->rsp_c
> >onsumer,drivers/scsi/sata_mv.c,mv_get_crpb_status,line=1112
> >
> >
> >long:
> >I wanted to post this to the the thread "LibPATA code issues / 2.6.15.4".
> >But right now my system is a bit down and so I sent this via webmail.
> ...
> 
> fyi:
> 
> ATA cmd=0x35 is ATA_CMD_WRITE_EXT, and 0x25 (lower down in the logs)
> is ATA_CMD_READ_EXT.
> 
> Those are the bog-standard (and slow!) PIO R/W commands,
> which generate one interrupt per 512-bytes transferred.

Eh no they are not, 0x35 is WRITEDMA_EXT and 0x25 is READMA_EXT.

-- 
Jens Axboe

