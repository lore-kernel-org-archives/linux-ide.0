From: Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH 2/2] sata_mv: remove iounmap in mv_platform_remove
Date: Wed, 13 Feb 2008 14:31:50 -0500
Message-ID: <47B345A6.9000605@pobox.com>
References: <12029369502995-git-send-email-saeed@marvell.com>
 <12029369532977-git-send-email-saeed@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbYBMTcX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 14:32:23 -0500
In-Reply-To: <12029369532977-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Saeed Bishara <saeed@marvell.com>
Cc: jeff@garzik.org, htejun@gmail.com, linux-ide@vger.kernel.org, saeed.bishara@gmail.com, nico@cam.org, byron.bbradley@gmail.com

Saeed Bishara wrote:
> this will fix crash bug when doing rmmod to the driver, this is because the
> port_stop function get called later and it could access the device's registers.
> 
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  drivers/ata/sata_mv.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 9c9a5b0..c61e666 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2983,11 +2983,8 @@ static int __devexit mv_platform_remove(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct ata_host *host = dev_get_drvdata(dev);
> -	struct mv_host_priv *hpriv = host->private_data;
> -	void __iomem *base = hpriv->base;
>  
>  	ata_host_detach(host);
> -	iounmap(base);
>  	return 0;
>  }
..

Where does the iounmap() now get done instead of that place?


-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
