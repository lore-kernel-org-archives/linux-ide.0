From: Shaohua Li <shli@fb.com>
Subject: Re: [PATCH v3 3/3] libata: use blk taging
Date: Thu, 22 Jan 2015 13:12:20 -0800
Message-ID: <20150122211220.GA2123210@devbig257.prn2.facebook.com>
References: <81b8ef84122544faa1f37a404cf2e7c71791d961.1421371412.git.shli@fb.com>
 <92a8da78d57926f61e9050168499872d52066f1c.1421371412.git.shli@fb.com>
 <20150116082344.GA4913@infradead.org>
 <20150116221600.GA1099317@devbig257.prn2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27714 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754263AbbAVVNA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2015 16:13:00 -0500
Content-Disposition: inline
In-Reply-To: <20150116221600.GA1099317@devbig257.prn2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ide@vger.kernel.org, Kernel-team@fb.com, dan.j.williams@intel.com, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>

Hi Tejun,
are you ok to pick up these patches?

Thanks,
Shaohua

On Fri, Jan 16, 2015 at 02:16:00PM -0800, Shaohua Li wrote:
> On Fri, Jan 16, 2015 at 12:23:44AM -0800, Christoph Hellwig wrote:
> > > +static bool ata_valid_internal_tag(struct ata_port *ap, struct ata_device *dev,
> > > +				   unsigned int tag)
> > > +{
> > > +	if (!ap->scsi_host)
> > > +		return !test_and_set_bit(tag, &ap->sas_tag_allocated);
> > > +	return !dev->sdev ||
> > > +	       !blk_queue_find_tag(dev->sdev->request_queue, tag);
> > 
> > How is this supposed to work with blk-mq?
> > 
> > > +}
> > > +
> > >  /**
> > >   *	ata_exec_internal_sg - execute libata internal command
> > >   *	@dev: Device to which the command is sent
> > > @@ -1585,8 +1594,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
> > >  	else
> > >  		tag = 0;
> > >  
> > > -	if (test_and_set_bit(tag, &ap->qc_allocated))
> > > -		BUG();
> > > +	BUG_ON(!ata_valid_internal_tag(ap, dev, tag));
> > 
> > But given that this is just a single assert we might as well just
> > remove that whole thing.
> 
> Ok, I delete it
>  
> > > +static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap, int blktag)
> > > +{
> > > +	struct ata_queued_cmd *qc;
> > > +
> > > +	/* no command while frozen */
> > > +	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
> > > +		return NULL;
> > > +
> > > +	/* SATA will directly use block tag. libsas need its own tag management */
> > > +	if (ap->scsi_host) {
> > > +		qc = __ata_qc_from_tag(ap, blktag);
> > > +		qc->tag = blktag;
> > > +		return qc;
> > > +	}
> > > +
> > > +	return sas_ata_qc_new(ap);
> > 
> > Why don't you merge tis into ata_qc_new_init?
> > 
> > > +static void sas_ata_qc_free(unsigned int tag, struct ata_port *ap)
> > > +{
> > > +	if (!ap->scsi_host)
> > 
> > Given the sas_ name I'd move the check into the caller.
> > 
> > That beeing said I wonder if you shouldn't do all this at a much
> > higher level.
> > 
> > __ata_scsi_queuecmd has a two callers, one for sata, and one for sas.
> > If you pass in the tag from that level the low lever code won't
> > need any branches for sas vs libata.  The only downside would be
> > that you now consume a tag for simulated command on SAS, but as that's
> > already done for SATA it can't be that bad.
> 
> I can do this in __ata_scsi_queuecmd, but don't see a good place to free
> the tag, which really should be done at scsi_done. The whole thing
> should be done at a higher level. I moved the ata tag allocation code to
> libata-scsi.c to make it clearer.
> 
> 
> From 125d41a001b8555fac42ea5b35dae45049655ab0 Mon Sep 17 00:00:00 2001
> Message-Id: <125d41a001b8555fac42ea5b35dae45049655ab0.1421446044.git.shli@fb.com>
> In-Reply-To: <81b8ef84122544faa1f37a404cf2e7c71791d961.1421446044.git.shli@fb.com>
> References: <81b8ef84122544faa1f37a404cf2e7c71791d961.1421446044.git.shli@fb.com>
> From: Shaohua Li <shli@fb.com>
> Date: Thu, 18 Dec 2014 09:04:25 -0800
> Subject: [PATCH 3/3] libata: use blk taging
> 
> libata uses its own tag management which is duplication and the
> implementation is poor. And if we switch to blk-mq, tag is build-in.
> It's time to switch to generic taging.
> 
> The SAS driver has its own tag management, and looks we can't directly
> map the host controler tag to SATA tag. So I just bypassed the SAS case.
> 
> I changed the code/variable name for the tag management of libata to
> make it self contained. Only sas will use it. Later if libsas implements
> its tag management, the tag management code in libata can be deleted
> easily.
> 
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  drivers/ata/libata-core.c | 67 +++++++++++++----------------------------------
>  drivers/ata/libata-scsi.c | 30 ++++++++++++++++++++-
>  drivers/ata/libata.h      |  4 ++-
>  include/linux/libata.h    |  5 ++--
>  4 files changed, 53 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 5c84fb5..d626605 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1585,8 +1585,6 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
>  	else
>  		tag = 0;
>  
> -	if (test_and_set_bit(tag, &ap->qc_allocated))
> -		BUG();
>  	qc = __ata_qc_from_tag(ap, tag);
>  
>  	qc->tag = tag;
> @@ -4726,66 +4724,36 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
>  }
>  
>  /**
> - *	ata_qc_new - Request an available ATA command, for queueing
> - *	@ap: target port
> - *
> - *	Some ATA host controllers may implement a queue depth which is less
> - *	than ATA_MAX_QUEUE. So we shouldn't allocate a tag which is beyond
> - *	the hardware limitation.
> + *	ata_qc_new_init - Request an available ATA command, and initialize it
> + *	@dev: Device from whom we request an available command structure
>   *
>   *	LOCKING:
>   *	None.
>   */
>  
> -static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
> +struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
>  {
> -	struct ata_queued_cmd *qc = NULL;
> -	unsigned int max_queue = ap->host->n_tags;
> -	unsigned int i, tag;
> +	struct ata_port *ap = dev->link->ap;
> +	struct ata_queued_cmd *qc;
>  
>  	/* no command while frozen */
>  	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
>  		return NULL;
>  
> -	for (i = 0, tag = ap->last_tag + 1; i < max_queue; i++, tag++) {
> -		tag = tag < max_queue ? tag : 0;
> -
> -		/* the last tag is reserved for internal command. */
> -		if (tag == ATA_TAG_INTERNAL)
> -			continue;
> -
> -		if (!test_and_set_bit(tag, &ap->qc_allocated)) {
> -			qc = __ata_qc_from_tag(ap, tag);
> -			qc->tag = tag;
> -			ap->last_tag = tag;
> -			break;
> -		}
> +	/* libsas case */
> +	if (!ap->scsi_host) {
> +		tag = ata_sas_allocate_tag(ap);
> +		if (tag < 0)
> +			return NULL;
>  	}
>  
> -	return qc;
> -}
> -
> -/**
> - *	ata_qc_new_init - Request an available ATA command, and initialize it
> - *	@dev: Device from whom we request an available command structure
> - *
> - *	LOCKING:
> - *	None.
> - */
> -
> -struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev)
> -{
> -	struct ata_port *ap = dev->link->ap;
> -	struct ata_queued_cmd *qc;
> -
> -	qc = ata_qc_new(ap);
> -	if (qc) {
> -		qc->scsicmd = NULL;
> -		qc->ap = ap;
> -		qc->dev = dev;
> +	qc = __ata_qc_from_tag(ap, tag);
> +	qc->tag = tag;
> +	qc->scsicmd = NULL;
> +	qc->ap = ap;
> +	qc->dev = dev;
>  
> -		ata_qc_reinit(qc);
> -	}
> +	ata_qc_reinit(qc);
>  
>  	return qc;
>  }
> @@ -4812,7 +4780,8 @@ void ata_qc_free(struct ata_queued_cmd *qc)
>  	tag = qc->tag;
>  	if (likely(ata_tag_valid(tag))) {
>  		qc->tag = ATA_TAG_POISON;
> -		clear_bit(tag, &ap->qc_allocated);
> +		if (!ap->scsi_host)
> +			ata_sas_free_tag(tag, ap);
>  	}
>  }
>  
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index e364e86..59c9d72 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -756,7 +756,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
>  {
>  	struct ata_queued_cmd *qc;
>  
> -	qc = ata_qc_new_init(dev);
> +	qc = ata_qc_new_init(dev, cmd->request->tag);
>  	if (qc) {
>  		qc->scsicmd = cmd;
>  		qc->scsidone = cmd->scsi_done;
> @@ -3666,6 +3666,9 @@ int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
>  		 */
>  		shost->max_host_blocked = 1;
>  
> +		if (scsi_init_shared_tag_map(shost, host->n_tags))
> +			goto err_add;
> +
>  		rc = scsi_add_host_with_dma(ap->scsi_host,
>  						&ap->tdev, ap->host->dev);
>  		if (rc)
> @@ -4228,3 +4231,28 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
> +
> +int ata_sas_allocate_tag(struct ata_port *ap)
> +{
> +	unsigned int max_queue = ap->host->n_tags;
> +	unsigned int i, tag;
> +
> +	for (i = 0, tag = ap->sas_last_tag + 1; i < max_queue; i++, tag++) {
> +		tag = tag < max_queue ? tag : 0;
> +
> +		/* the last tag is reserved for internal command. */
> +		if (tag == ATA_TAG_INTERNAL)
> +			continue;
> +
> +		if (!test_and_set_bit(tag, &ap->sas_tag_allocated)) {
> +			ap->sas_last_tag = tag;
> +			return tag;
> +		}
> +	}
> +	return -1;
> +}
> +
> +void ata_sas_free_tag(unsigned int tag, struct ata_port *ap)
> +{
> +	clear_bit(tag, &ap->sas_tag_allocated);
> +}
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 5f4e0cc..8c491cd 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -63,7 +63,7 @@ extern struct ata_link *ata_dev_phys_link(struct ata_device *dev);
>  extern void ata_force_cbl(struct ata_port *ap);
>  extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
>  extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
> -extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
> +extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag);
>  extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
>  			   u64 block, u32 n_block, unsigned int tf_flags,
>  			   unsigned int tag);
> @@ -145,6 +145,8 @@ extern void ata_scsi_dev_rescan(struct work_struct *work);
>  extern int ata_bus_probe(struct ata_port *ap);
>  extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
>  			      unsigned int id, u64 lun);
> +int ata_sas_allocate_tag(struct ata_port *ap);
> +void ata_sas_free_tag(unsigned int tag, struct ata_port *ap);
>  
>  
>  /* libata-eh.c */
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 2d18241..f234547 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -821,10 +821,10 @@ struct ata_port {
>  	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
>  
>  	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
> -	unsigned long		qc_allocated;
> +	unsigned long		sas_tag_allocated; /* for sas tag allocation only */
>  	unsigned int		qc_active;
>  	int			nr_active_links; /* #links with active qcs */
> -	unsigned int		last_tag;	/* track next tag hw expects */
> +	unsigned int		sas_last_tag;	/* track next tag hw expects */
>  
>  	struct ata_link		link;		/* host default link */
>  	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
> @@ -1344,6 +1344,7 @@ extern struct device_attribute *ata_common_sdev_attrs[];
>  	.ioctl			= ata_scsi_ioctl,		\
>  	.queuecommand		= ata_scsi_queuecmd,		\
>  	.can_queue		= ATA_DEF_QUEUE,		\
> +	.tag_alloc_policy	= BLK_TAG_ALLOC_RR,		\
>  	.this_id		= ATA_SHT_THIS_ID,		\
>  	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,		\
>  	.emulated		= ATA_SHT_EMULATED,		\
> -- 
> 1.8.1
> 
