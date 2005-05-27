From: Jens Axboe <axboe@suse.de>
Subject: Re: Playing with SATA NCQ
Date: Fri, 27 May 2005 08:39:22 +0200
Message-ID: <20050527063921.GI1435@suse.de>
References: <20050526140058.GR1419@suse.de> <4296A517.3020502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:29642 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261824AbVE0GiY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 May 2005 02:38:24 -0400
Content-Disposition: inline
In-Reply-To: <4296A517.3020502@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 27 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >@@ -189,7 +194,7 @@
> > 	.ioctl			= ata_scsi_ioctl,
> > 	.queuecommand		= ata_scsi_queuecmd,
> > 	.eh_strategy_handler	= ata_scsi_error,
> >-	.can_queue		= ATA_DEF_QUEUE,
> >+	.can_queue		= ATA_MAX_QUEUE,
> > 	.this_id		= ATA_SHT_THIS_ID,
> > 	.sg_tablesize		= AHCI_MAX_SG,
> > 	.max_sectors		= ATA_MAX_SECTORS,
> >@@ -200,7 +205,7 @@
> > 	.dma_boundary		= AHCI_DMA_BOUNDARY,
> > 	.slave_configure	= ata_scsi_slave_config,
> > 	.bios_param		= ata_std_bios_param,
> >-	.ordered_flush		= 1,
> >+	.ordered_flush		= 0, /* conflicts with NCQ for now */
> > };
> > 
> > static struct ata_port_operations ahci_ops = {
> 
> Also, you'll probably want to implement ata_scsi_change_queue_depth, and 
> reference it in ahci.c (and other NCQ-capable drivers).

Done!

-- 
Jens Axboe

