From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] ata: ahci: add support for non-standard port
 offset/length
Date: Fri, 22 Apr 2016 13:59:36 -0400
Message-ID: <20160422175936.GU7822@mtj.duckdns.org>
References: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1461335561-18363-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461335561-18363-2-git-send-email-thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hanna Hawa <hannah-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hello,

On Fri, Apr 22, 2016 at 04:32:37PM +0200, Thomas Petazzoni wrote:
> @@ -1714,10 +1714,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	for (i = 0; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
> +		unsigned int offset =
> +			hpriv->port_offset + ap->port_no * hpriv->port_length;
>  
>  		ata_port_pbar_desc(ap, ahci_pci_bar, -1, "abar");
> -		ata_port_pbar_desc(ap, ahci_pci_bar,
> -				   0x100 + ap->port_no * 0x80, "port");
> +		ata_port_pbar_desc(ap, ahci_pci_bar, offset, "port");

Doesn't this just affect ahci_platform?  Why is ahci_init_one() being
updated?  Also, who's setting port_offet and port_length for
non-platform ahci drivers?

> @@ -556,10 +559,12 @@ int ahci_platform_init_host(struct platform_device *pdev,
>  
>  	for (i = 0; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
> +		unsigned int offset =
> +			hpriv->port_offset + ap->port_no * hpriv->port_length;
>  
>  		ata_port_desc(ap, "mmio %pR",
>  			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
> -		ata_port_desc(ap, "port 0x%x", 0x100 + ap->port_no * 0x80);
> +		ata_port_desc(ap, "port 0x%x", offset);

If this needs to be configurable, wouldn't it be better to just let it
be specified per port?

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
