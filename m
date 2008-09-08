From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sil680: remove duplicate pcim_enable_device
Date: Mon, 08 Sep 2008 12:16:12 -0400
Message-ID: <48C54FCC.3030401@garzik.org>
References: <20080829153628.GA20130@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37746 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754411AbYIHQQQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 12:16:16 -0400
In-Reply-To: <20080829153628.GA20130@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

David Milburn wrote:
> Remove duplicate call to pcim_enable_device in sil680_init_one.
> 
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> ---
>  drivers/ata/pata_sil680.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> index 720b864..e970b22 100644
> --- a/drivers/ata/pata_sil680.c
> +++ b/drivers/ata/pata_sil680.c
> @@ -322,9 +322,6 @@ static int __devinit sil680_init_one(struct pci_dev *pdev,
>  	/* Try to acquire MMIO resources and fallback to PIO if
>  	 * that fails
>  	 */
> -	rc = pcim_enable_device(pdev);
> -	if (rc)
> -		return rc;
>  	rc = pcim_iomap_regions(pdev, 1 << SIL680_MMIO_BAR, DRV_NAME);
>  	if (rc)
>  		goto use_ioports;

applied


