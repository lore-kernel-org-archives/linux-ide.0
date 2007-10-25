From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.24-rc1, sata_nv: MCP51 is boned with SWNCQ too
Date: Thu, 25 Oct 2007 08:35:56 -0400
Message-ID: <47208DAC.1000207@garzik.org>
References: <34545.86.7.220.119.1193306052.squirrel@wmbeta.mxes.net> <35163.86.7.220.119.1193312862.squirrel@wmbeta.mxes.net> <200710251406.05804.bzolnier@gmail.com> <200710251411.42546.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41178 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbXJYMf7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 08:35:59 -0400
In-Reply-To: <200710251411.42546.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew <andrew@nelless.net>, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

Bartlomiej Zolnierkiewicz wrote:
> @@ -2379,9 +2379,13 @@ static int nv_init_one (struct pci_dev *
>  	if (type == CK804 && adma_enabled) {
>  		dev_printk(KERN_NOTICE, &pdev->dev, "Using ADMA mode\n");
>  		type = ADMA;
> +	} else if (type == GENERIC && swncq_enabled) {
> +		dev_printk(KERN_NOTICE, &pdev->dev, "Using SWNCQ mode\n");
> +		type = SWNCQ;
>  	}
>  


If we want to start putting PCI_ANY_ID entries in the pci_device_id 
table (as other NVIDIA patches have proposed), I don't think it's safe 
to assume that all devices marked GENERIC can do SWNCQ, while it should 
be safe to fall back from SWNCQ to GENERIC.  GENERIC is the selection 
being considered for use as being compatible with future chips.

But overall both patches look straightforward...

	Jeff


