From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: fix ata_dma_enabled
Date: Mon, 3 Dec 2012 01:46:42 +0000
Message-ID: <20121203014642.580e0b31@pyramind.ukuu.org.uk>
References: <50BBFA94.2070105@intel.com>
	<20121203012225.00e0c121@pyramind.ukuu.org.uk>
	<20121203013548.GA1396@mint-spring.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49753 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab2LCBlo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Dec 2012 20:41:44 -0500
In-Reply-To: <20121203013548.GA1396@mint-spring.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Borislav Petkov <bp@alien8.de>, Dutra Julio <dutra.julio@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, Tejun Heo <tj@kernel.org>, Szymon Janc <szymon@janc.net.pl>, Bernd Buschinski <b.buschinski@googlemail.com>, linux-ide@vger.kernel.org

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 9426423..d772d66 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2657,6 +2657,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  		 * bus as we may be talking too fast.
>  		 */
>  		dev->pio_mode = XFER_PIO_0;
> +		dev->dma_mode = 0xff;
>  
>  		/* If the controller has a pio mode setup function
>  		 * then use it to set the chipset to rights. Don't
> 
> 
> So do you prefer this?

Yes - definitely. That is the intended behaviour.
