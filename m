From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/5] sil24: add ATAPI support
Date: Wed, 16 Nov 2005 07:35:22 -0500
Message-ID: <437B278A.6050201@pobox.com>
References: <20051116080759.GD22807@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:33971 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030306AbVKPMfZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 07:35:25 -0500
In-Reply-To: <20051116080759.GD22807@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> +	case ATA_PROT_ATAPI:
> +	case ATA_PROT_ATAPI_DMA:
> +	case ATA_PROT_ATAPI_NODATA:
> +		prb = &cb->atapi.prb;
> +		sge = cb->atapi.sge;
> +		memset(cb->atapi.cdb, 0, 32);
> +		memcpy(cb->atapi.cdb, qc->cdb, ap->cdb_len);
> +
> +		if (unlikely((ap->cdb_len == 16) ^ pp->cdb16)) {
> +			pp->cdb16 = ap->cdb_len == 16;
> +			if (pp->cdb16)
> +				writel(PORT_CS_CDB16, port + PORT_CTRL_STAT);
> +			else
> +				writel(PORT_CS_CDB16, port + PORT_CTRL_CLR);
> +		}

NAK:
* you should set PORT_CS_CDB16 from ->dev_config(), not needlessly test 
inside the fast path
* thus, no need to cache cdb16 flag.  just tell the hardware once, and 
then everybody agrees on the correct value.


> @@ -772,6 +802,9 @@ static int sil24_port_start(struct ata_p
>  
>  	ap->private_data = pp;
>  
> +	/* default to 12byte CDB */
> +	writel(PORT_CS_CDB16, port + PORT_CTRL_CLR);
> +
>  	return 0;

If you set it in ->dev_config(), this should go away.

	Jeff


