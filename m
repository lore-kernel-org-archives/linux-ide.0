From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 17/23] libata-sff: prd is BMDMA specific
Date: Mon, 17 May 2010 23:06:46 -0400
Message-ID: <4BF20446.9030606@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-18-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60459 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab0ERDGs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2010 23:06:48 -0400
Received: by gyg13 with SMTP id 13so2573821gyg.19
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2010 20:06:47 -0700 (PDT)
In-Reply-To: <1273520507-32459-18-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/10/2010 03:41 PM, Tejun Heo wrote:
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 61ff9a1..b220451 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -716,14 +716,13 @@ struct ata_port {
>   	unsigned int		print_id; /* user visible unique port ID */
>   	unsigned int		port_no; /* 0 based port no. inside the host */
>
> -	struct ata_prd		*prd;	 /* our SG list */
> -	dma_addr_t		prd_dma; /* and its DMA mapping */
> -
>   #ifdef CONFIG_ATA_SFF
>   	struct ata_ioports	ioaddr;	/* ATA cmd/ctl/dma register blocks */
>   	u8			ctl;	/* cache of ATA control register */
>   	u8			last_ctl;	/* Cache last written value */
>   	struct delayed_work	sff_pio_task;
> +	struct ata_bmdma_prd	*bmdma_prd;	/* BMDMA SG list */
> +	dma_addr_t		bmdma_prd_dma;	/* and its DMA mapping */
>   #endif /* CONFIG_ATA_SFF */
>
>   	unsigned int		pio_mask;

"bmdma_prd_dma" is a bit too redundant for my tastes.

I would prefer "bmdma_prd_addr" or similar.

ack, with that change

