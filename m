From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_inic162x: kill double region requests
Date: Mon, 19 Mar 2007 12:04:21 -0400
Message-ID: <45FEB485.7050909@garzik.org>
References: <20070310205636.GA14704@movealong.org> <45F4F483.9080302@gmail.com> <20070312220656.GA5457@movealong.org> <20070315165942.GC15600@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53777 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030307AbXCSQEZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 12:04:25 -0400
In-Reply-To: <20070315165942.GC15600@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Nate Riffe <inkblot@movealong.org>, linux-ide@vger.kernel.org, kernel@vger.kernel.org

Tejun Heo wrote:
> Regions are requested twice during initialization causing the second
> one to fail.  This is regression introduced during iomap conversion.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Nate, this should fix it.  But LBA48 support is broken on the
> controller.
> 
> diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
> index dcf5fe5..11c3079 100644
> --- a/drivers/ata/sata_inic162x.c
> +++ b/drivers/ata/sata_inic162x.c
> @@ -674,10 +674,6 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (rc)
>  		return rc;
>  
> -	rc = pci_request_regions(pdev, DRV_NAME);
> -	if (rc)
> -		return rc;
> -
>  	rc = pcim_iomap_regions(pdev, 0x3f, DRV_NAME);
>  	if (rc)
>  		return rc;

applied


