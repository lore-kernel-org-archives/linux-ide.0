From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/8] libata: factor out ata_eh_schedule_probe()
Date: Mon, 5 Nov 2007 11:36:57 +0100
Message-ID: <200711051136.57793.bzolnier@gmail.com>
References: <1194241515653-git-send-email-htejun@gmail.com> <11942415162701-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:38056 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbXKEKcI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Nov 2007 05:32:08 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1548307fkz
        for <linux-ide@vger.kernel.org>; Mon, 05 Nov 2007 02:32:06 -0800 (PST)
In-Reply-To: <11942415162701-git-send-email-htejun@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org


Hi,

On Monday 05 November 2007, Tejun Heo wrote:
> Factor out ata_eh_schedule_probe() from ata_eh_handle_dev_fail() and
> ata_eh_recover().  This is to improve maintainability and make future
> changes easier.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |   37 ++++++++++++++++++++-----------------
>  1 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index ed8813b..a37be1e 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2438,6 +2438,22 @@ static int ata_eh_skip_recovery(struct ata_link *link)
>  	return 1;
>  }
>  
> +static int ata_eh_schedule_probe(struct ata_device *dev)
> +{
> +	struct ata_eh_context *ehc = &dev->link->eh_context;
> +
> +	if (!(ehc->i.probe_mask & (1 << dev->devno)) ||
> +	    (ehc->did_probe_mask & (1 << dev->devno)))
> +		return 0;
> +
> +	ata_eh_detach_dev(dev);
> +	ata_dev_init(dev);
> +	ehc->did_probe_mask |= (1 << dev->devno);
> +	ehc->i.action |= ATA_EH_SOFTRESET;
> +
> +	return 1;
> +}
> +
>  static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
>  {
>  	struct ata_eh_context *ehc = &dev->link->eh_context;
> @@ -2469,16 +2485,9 @@ static int ata_eh_handle_dev_fail(struct ata_device *dev, int err)
>  		if (ata_link_offline(dev->link))
>  			ata_eh_detach_dev(dev);
>  
> -		/* probe if requested */
> -		if ((ehc->i.probe_mask & (1 << dev->devno)) &&
> -		    !(ehc->did_probe_mask & (1 << dev->devno))) {
> -			ata_eh_detach_dev(dev);
> -			ata_dev_init(dev);
> -
> +		/* schedule probe if necessary */
> +		if (ata_eh_schedule_probe(dev))
>  			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
> -			ehc->did_probe_mask |= (1 << dev->devno);
> -			ehc->i.action |= ATA_EH_SOFTRESET;
> -		}
>  
>  		return 1;
>  	} else {
> @@ -2555,14 +2564,8 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>  			if (dev->flags & ATA_DFLAG_DETACH)
>  				ata_eh_detach_dev(dev);
>  
> -			if (!ata_dev_enabled(dev) &&
> -			    ((ehc->i.probe_mask & (1 << dev->devno)) &&
> -			     !(ehc->did_probe_mask & (1 << dev->devno)))) {
> -				ata_eh_detach_dev(dev);
> -				ata_dev_init(dev);
> -				ehc->did_probe_mask |= (1 << dev->devno);
> -				ehc->i.action |= ATA_EH_SOFTRESET;
> -			}
> +			/* schedule probe if necessary */
> +			ata_eh_schedule_probe(dev);

!ata_dev_enabled() got lost, is this intended?
