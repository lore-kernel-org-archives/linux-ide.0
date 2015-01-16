From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 3/3] libata: use blk taging
Date: Fri, 16 Jan 2015 00:23:44 -0800
Message-ID: <20150116082344.GA4913@infradead.org>
References: <81b8ef84122544faa1f37a404cf2e7c71791d961.1421371412.git.shli@fb.com>
 <92a8da78d57926f61e9050168499872d52066f1c.1421371412.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50618 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbbAPIXp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2015 03:23:45 -0500
Content-Disposition: inline
In-Reply-To: <92a8da78d57926f61e9050168499872d52066f1c.1421371412.git.shli@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: linux-ide@vger.kernel.org, Kernel-team@fb.com, dan.j.williams@intel.com, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>

> +static bool ata_valid_internal_tag(struct ata_port *ap, struct ata_device *dev,
> +				   unsigned int tag)
> +{
> +	if (!ap->scsi_host)
> +		return !test_and_set_bit(tag, &ap->sas_tag_allocated);
> +	return !dev->sdev ||
> +	       !blk_queue_find_tag(dev->sdev->request_queue, tag);

How is this supposed to work with blk-mq?

> +}
> +
>  /**
>   *	ata_exec_internal_sg - execute libata internal command
>   *	@dev: Device to which the command is sent
> @@ -1585,8 +1594,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
>  	else
>  		tag = 0;
>  
> -	if (test_and_set_bit(tag, &ap->qc_allocated))
> -		BUG();
> +	BUG_ON(!ata_valid_internal_tag(ap, dev, tag));

But given that this is just a single assert we might as well just
remove that whole thing.

> +static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap, int blktag)
> +{
> +	struct ata_queued_cmd *qc;
> +
> +	/* no command while frozen */
> +	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
> +		return NULL;
> +
> +	/* SATA will directly use block tag. libsas need its own tag management */
> +	if (ap->scsi_host) {
> +		qc = __ata_qc_from_tag(ap, blktag);
> +		qc->tag = blktag;
> +		return qc;
> +	}
> +
> +	return sas_ata_qc_new(ap);

Why don't you merge tis into ata_qc_new_init?

> +static void sas_ata_qc_free(unsigned int tag, struct ata_port *ap)
> +{
> +	if (!ap->scsi_host)

Given the sas_ name I'd move the check into the caller.

That beeing said I wonder if you shouldn't do all this at a much
higher level.

__ata_scsi_queuecmd has a two callers, one for sata, and one for sas.
If you pass in the tag from that level the low lever code won't
need any branches for sas vs libata.  The only downside would be
that you now consume a tag for simulated command on SAS, but as that's
already done for SATA it can't be that bad.

> @@ -3666,6 +3666,8 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
>  		 */
>  		shost->max_host_blocked = 1;
>  
> +		scsi_init_shared_tag_map(shost, host->n_tags);
> +

You need to check the return value here.

