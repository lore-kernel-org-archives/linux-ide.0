From: Mark Lord <lkml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Wed, 15 Mar 2006 10:03:51 -0500
Message-ID: <44182CD7.9070401@rtr.ca>
References: <1142344212.4416ca14a26b4@webmail.aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:56236 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750980AbWCOPDz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Mar 2006 10:03:55 -0500
In-Reply-To: <1142344212.4416ca14a26b4@webmail.aon.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: me_trash1@aon.at
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

me_trash1@aon.at wrote:
> Hi!
> 
> short:
> system with 2.6.15.4 with Mark Lord's opcode info patches
> sata_mv (Adaptec 1420SA Marvell 88SX6541)
> e.g. postgres:insert&delete gives: ata3: translated op=0x2a cmd=0x35 ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> or sometimes (unknown cause):
> ata4: translated op=0x28 cmd=0x25 ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata4: status=0xd0 { Busy }
> Assertion failed! ((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == pp->rsp_c
> onsumer,drivers/scsi/sata_mv.c,mv_get_crpb_status,line=1112
> 
> 
> long:
> I wanted to post this to the the thread "LibPATA code issues / 2.6.15.4".
> But right now my system is a bit down and so I sent this via webmail.
...

fyi:

ATA cmd=0x35 is ATA_CMD_WRITE_EXT, and 0x25 (lower down in the logs)
is ATA_CMD_READ_EXT.

Those are the bog-standard (and slow!) PIO R/W commands,
which generate one interrupt per 512-bytes transferred.

Cheers
