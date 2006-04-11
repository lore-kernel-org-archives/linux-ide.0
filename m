From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 06/13] sata_sil24: implement loss of completion interrupt
 on PCI-X errta fix
Date: Tue, 11 Apr 2006 13:27:21 -0400
Message-ID: <443BE6F9.8020403@pobox.com>
References: <1144762339715-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34693 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751046AbWDKR1c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 13:27:32 -0400
In-Reply-To: <1144762339715-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> @@ -738,6 +740,10 @@ static inline void sil24_host_intr(struc
>  	slot_stat = readl(port + PORT_SLOT_STAT);
>  	if (!(slot_stat & HOST_SSTAT_ATTN)) {
>  		struct sil24_port_priv *pp = ap->private_data;
> +
> +		if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
> +			writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
> +


This looks racy.  Since the interrupt is usually level-triggered, 
doesn't this introduce the possibility of losing interrupt events?

	Jeff


