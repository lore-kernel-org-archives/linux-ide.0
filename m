From: Tejun Heo <htejun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] libahci: Implement the capability to override the
 generic ahci interrupt handler.
Date: Sun, 31 Jan 2016 06:35:40 -0500
Message-ID: <20160131113540.GX32380@htj.duckdns.org>
References: <1453888197-11368-1-git-send-email-stripathi@apm.com>
 <1453888197-11368-3-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1453888197-11368-3-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Cc: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, svtripathi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Wed, Jan 27, 2016 at 03:19:56PM +0530, Suman Tripathi wrote:
> @@ -2466,13 +2467,19 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
>  {
>  	struct ahci_host_priv *hpriv = host->private_data;
>  	int irq = hpriv->irq;
> +	irqreturn_t (*ahci_irq_handler)(int irq, void *dev_instance);
>  	int rc;
> 
>  	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
>  		rc = ahci_host_activate_multi_irqs(host, sht);

You need to add { } to the if body too.  Please read CodingStyle.

> -	else
> -		rc = ata_host_activate(host, irq, ahci_single_level_irq_intr,
> +	else {
> +		ahci_irq_handler = hpriv->ahci_irq_intr ? hpriv->ahci_irq_intr :
> +				   ahci_single_level_irq_intr;
> +
> +		rc = ata_host_activate(host, irq, ahci_irq_handler,
>  				       IRQF_SHARED, sht);
> +	}

Can you please make this handled the same way as ->start_engine?
Also, maybe print out a warning message if a driver specifies both
AHCI_HFLAG_MULTI_MSI[X] and the irq handler override?

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
