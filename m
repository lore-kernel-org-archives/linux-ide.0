From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/9] libata: normalize port_info, port_operations and
 sht tables
Date: Fri, 01 Feb 2008 15:46:43 -0500
Message-ID: <47A38533.7020806@garzik.org>
References: <12016853433196-git-send-email-htejun@gmail.com> <12016853433225-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53797 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbYBAUqp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 15:46:45 -0500
In-Reply-To: <12016853433225-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com

Tejun Heo wrote:
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 07dcaf6..08301ca 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -351,6 +351,8 @@ static const struct ata_port_operations ahci_vt8251_ops = {
>  	.port_suspend		= ahci_port_suspend,
>  	.port_resume		= ahci_port_resume,
>  #endif
> +	.enable_pm		= ahci_enable_alpm,
> +	.disable_pm		= ahci_disable_alpm,
>  
>  	.port_start		= ahci_port_start,
>  	.port_stop		= ahci_port_stop,
> @@ -385,6 +387,8 @@ static const struct ata_port_operations ahci_p5wdh_ops = {
>  	.port_suspend		= ahci_port_suspend,
>  	.port_resume		= ahci_port_resume,
>  #endif
> +	.enable_pm		= ahci_enable_alpm,
> +	.disable_pm		= ahci_disable_alpm,
>  
>  	.port_start		= ahci_port_start,
>  	.port_stop		= ahci_port_stop,

The last one is probably OK, but I didn't think vt8521 could do this?

ACK everything else

