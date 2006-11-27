From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] sata_nv: fix ATAPI in ADMA mode
Date: Mon, 27 Nov 2006 15:15:41 -0800
Message-ID: <20061127151541.16a93d49.akpm@osdl.org>
References: <4569F703.8010209@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:40675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758594AbWK0XQn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Nov 2006 18:16:43 -0500
In-Reply-To: <4569F703.8010209@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Nicolas.Mailhot@LaPoste.net

On Sun, 26 Nov 2006 14:20:19 -0600
Robert Hancock <hancockr@shaw.ca> wrote:

>  static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
>  {
>  	struct ata_host *host = dev_instance;
>  	int i, handled = 0;
> +	u32 notifier_clears[2];
>  
>  	spin_lock(&host->lock);
>  
>  	for (i = 0; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
> +		notifier_clears[i] = 0;

Promise us that n_ports will never exceed 2?
