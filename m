From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc5] libata: fix ata_dev_disable()
Date: Wed, 27 Jun 2007 02:45:47 -0400
Message-ID: <4682079B.90005@garzik.org>
References: <467FD25A.2040606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38002 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760194AbXF0Gpt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jun 2007 02:45:49 -0400
In-Reply-To: <467FD25A.2040606@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Fix silly condition check bug in ata_dev_disable().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index adfae9d..09ade2a 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -600,8 +600,9 @@ static const char *sata_spd_string(unsigned int spd)
>  
>  void ata_dev_disable(struct ata_device *dev)
>  {
> -	if (ata_dev_enabled(dev) && ata_msg_drv(dev->ap)) {
> -		ata_dev_printk(dev, KERN_WARNING, "disabled\n");
> +	if (ata_dev_enabled(dev)) {
> +		if (ata_msg_drv(dev->ap))
> +			ata_dev_printk(dev, KERN_WARNING, "disabled\n");
>  		ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0 |
>  					     ATA_DNXFER_QUIET);

applied


