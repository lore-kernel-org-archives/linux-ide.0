From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libahci: ahci interrupt check for disabled port since
 private_data may be NULL
Date: Tue, 15 Apr 2014 14:20:01 -0400
Message-ID: <20140415182001.GF30990@htj.dyndns.org>
References: <1397512038-8419-1-git-send-email-dmilburn@redhat.com>
 <20140415163309.GB30990@htj.dyndns.org>
 <20140415181812.GA11614@dhcp-10-15-1-70.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:38074 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbaDOSUF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2014 14:20:05 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so10870880qcx.13
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2014 11:20:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140415181812.GA11614@dhcp-10-15-1-70.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, agordeev@redhat.com

On Tue, Apr 15, 2014 at 01:18:12PM -0500, David Milburn wrote:
> This patch also solves the problem, would this better?

Yes, this is a lot better.  Alexander, does this look good to you?
Also, shouldn't this cc stable?

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 5a0bf8e..831b1b4 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1236,14 +1236,14 @@ int ahci_host_activate(struct ata_host *host, int irq, unsigned int n_msis)
>  		struct ahci_port_priv *pp = host->ports[i]->private_data;
>  
>  		/* pp is NULL for dummy ports */
> -		if (pp)
> +		if (pp) {
>  			desc = pp->irq_desc;
> -		else
> -			desc = dev_driver_string(host->dev);
>  
> -		rc = devm_request_threaded_irq(host->dev,
> -			irq + i, ahci_hw_interrupt, ahci_thread_fn, IRQF_SHARED,
> -			desc, host->ports[i]);
> +			rc = devm_request_threaded_irq(host->dev,
> +						       irq + i, ahci_hw_interrupt, ahci_thread_fn, IRQF_SHARED,
> +						       desc, host->ports[i]);
> +		}
> +
>  		if (rc)
>  			goto out_free_irqs;
>  	}

-- 
tejun
