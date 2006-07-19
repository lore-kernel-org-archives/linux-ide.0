From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 03/17] libata-link: introduce ata_link
Date: Wed, 19 Jul 2006 16:26:57 -0400
Message-ID: <44BE9591.5050201@pobox.com>
References: <11523375354124-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50571 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030277AbWGSU1C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jul 2006 16:27:02 -0400
In-Reply-To: <11523375354124-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> @@ -496,6 +496,23 @@ struct ata_eh_context {
>  	unsigned int		did_probe_mask;
>  };
>  
> +struct ata_link {
> +	struct ata_port		*ap;
> +
> +	unsigned int		active_tag;	/* active tag on this link */
> +	u32			sactive;	/* active NCQ commands */
> +
> +	unsigned int		hw_sata_spd_limit;
> +	unsigned int		sata_spd_limit;
> +
> +	/* record runtime error info, protected by host_set lock */
> +	struct ata_eh_info	eh_info;
> +	/* EH context */
> +	struct ata_eh_context	eh_context;
> +
> +	struct ata_device	device[1];
> +};
> +
>  struct ata_port {
>  	struct Scsi_Host	*host;	/* our co-allocated scsi host */
>  	const struct ata_port_operations *ops;
> @@ -520,22 +537,13 @@ struct ata_port {
>  	unsigned int		mwdma_mask;
>  	unsigned int		udma_mask;
>  	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
> -	unsigned int		hw_sata_spd_limit;
> -	unsigned int		sata_spd_limit;	/* SATA PHY speed limit */
> -
> -	/* record runtime error info, protected by host_set lock */
> -	struct ata_eh_info	eh_info;
> -	/* EH context owned by EH */
> -	struct ata_eh_context	eh_context;
> -
> -	struct ata_device	device[ATA_MAX_DEVICES];
>  
>  	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
>  	unsigned long		qc_allocated;
>  	unsigned int		qc_active;
>  
> -	unsigned int		active_tag;
> -	u32			sactive;
> +	struct ata_link		link;	/* host default link */
> +	struct ata_device	__dev1;	/* storage for link.device[1] */

This storage mess for link.device[] is NAK'd.

This patch overall looks good, but it should really be entirely an 
equivalent-transformation patch, one that is easy to review and prove 
correct.

As such, this patch should move 'struct ata_device 
device[ATA_MAX_DEVICES]' into struct ata_link, rather than the strange 
arrangement you have above.  If you want to do something unusual like 
this, it's better to do it in a separate patch.

	Jeff


