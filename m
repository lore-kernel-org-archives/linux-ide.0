From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] IDE: claim extra DMA ports regardless of channel
Date: Tue, 28 Mar 2006 12:41:46 -0800
Message-ID: <20060328124146.52dbe446.akpm@osdl.org>
References: <44298947.5090600@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:6549 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932168AbWC1UmD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Mar 2006 15:42:03 -0500
In-Reply-To: <44298947.5090600@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:
>
>  static int ide_iomio_dma(ide_hwif_t *hwif, unsigned long base, unsigned int ports)
>   {
>   	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
>  -		hwif->name, base, base + ports - 1);
>  +	       hwif->name, base, base + ports - 1);
>  +
>   	if (!request_region(base, ports, hwif->name)) {
>   		printk(" -- Error, ports in use.\n");
>   		return 1;
>   	}
>  +
>   	hwif->dma_base = base;
>  -	if ((hwif->cds->extra) && (hwif->channel == 0)) {
>  -		request_region(base+16, hwif->cds->extra, hwif->cds->name);
>  -		hwif->dma_extra = hwif->cds->extra;
>  -	}
>  -	
>  +
>  +	if (hwif->cds->extra) {
>  +		hwif->extra_base = base + (hwif->channel ? 8 : 16);
>  +
>  +		if (!hwif->mate || !hwif->mate->extra_ports) {
>  +			if (!request_region(hwif->extra_base,
>  +					    hwif->cds->extra, hwif->cds->name)) {
>  +				printk(" -- Error, extra ports in use.\n");
>  +				release_region(base, ports);
>  +				return 1;
>  +			}
>  +			hwif->extra_ports = hwif->cds->extra;
>  +		}
>  +	}

The printks in this function are odd.  Note how it will print a
non-newline-terminated string and then will print a newline-terminated
string only if there was an error.

Does it all come out right both when errors occur and when they do not?
