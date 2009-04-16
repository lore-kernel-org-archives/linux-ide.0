From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_sil: enable 32-bit PIO
Date: Thu, 16 Apr 2009 15:24:48 -0400
Message-ID: <49E78600.5090306@garzik.org>
References: <49E417B8.8070504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37915 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757889AbZDPTYv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Apr 2009 15:24:51 -0400
In-Reply-To: <49E417B8.8070504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: ide <linux-ide@vger.kernel.org>

Robert Hancock wrote:
> 32-bit PIO seems to work fine on sata_sil hardware (tested on SiI3114) and is
> listed as OK in the Silicon Image datasheets. Enable it.
> 
> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>
> 
> diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
> index e67ce8e..030ec07 100644
> --- a/drivers/ata/sata_sil.c
> +++ b/drivers/ata/sata_sil.c
> @@ -183,7 +183,7 @@ static struct scsi_host_template sil_sht = {
>  };
>  
>  static struct ata_port_operations sil_ops = {
> -	.inherits		= &ata_bmdma_port_ops,
> +	.inherits		= &ata_bmdma32_port_ops,
>  	.dev_config		= sil_dev_config,
>  	.set_mode		= sil_set_mode,
>  	.bmdma_setup            = sil_bmdma_setup,

applied


