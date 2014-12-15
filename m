From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] libata: use generic taging
Date: Mon, 15 Dec 2014 00:13:18 -0800
Message-ID: <20141215081318.GB3982@infradead.org>
References: <e0ea802ef0d4170ad409e5dbf814c28581c091ac.1418613253.git.shli@fb.com>
 <fe6c323e2127bb4a89c4a4f85e5d131bba355a05.1418613253.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:39252 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbaLOINS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Dec 2014 03:13:18 -0500
Content-Disposition: inline
In-Reply-To: <fe6c323e2127bb4a89c4a4f85e5d131bba355a05.1418613253.git.shli@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: linux-ide@vger.kernel.org, Kernel-team@fb.com, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>

> +struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
>  {
>  	struct ata_port *ap = dev->link->ap;
>  	struct ata_queued_cmd *qc;
>  
> +	/* no command while frozen */
> +	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
> +		return NULL;
>  
> +	qc = __ata_qc_from_tag(ap, tag);

It would be more useful to allocate the ata_queued_cmd as part of
the request/scsi_cmnd, and dip into the reserved pool for internal
commands.

Also note that tags are per-host which probably breaks the indexing 
scheme to look up the commands from ap->qcmd.

> @@ -3711,6 +3711,8 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
>  						 NULL);
>  			if (!IS_ERR(sdev)) {
>  				dev->sdev = sdev;
> +				blk_queue_resize_tags(sdev->request_queue,
> +					ap->host->n_tags);

Never call blk_queue_resize_tags directly from a SCSI LLDD, and use
the scsi_change_queue_depth API instead.  Also remember that for
blk-mq you can't grow the tag map after allocation.

