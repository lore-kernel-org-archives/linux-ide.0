From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide_dma_speed() fixes
Date: Mon, 15 May 2006 16:27:04 +0100
Message-ID: <1147706824.26686.66.camel@localhost.localdomain>
References: <4463F4C8.9080608@ru.mvista.com>
	 <20060514050548.5399e3f4.akpm@osdl.org> <446885BE.4090404@ru.mvista.com>
	 <20060515080053.296c4c55.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964975AbWEOPO3@vger.kernel.org>
In-Reply-To: <20060515080053.296c4c55.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Llu, 2006-05-15 at 08:00 -0700, Andrew Morton wrote:
>  
>  	/* Capable of UltraDMA modes? */
> -	if (id->field_valid & 4)
> -		ultra_mask = id->dma_ultra & hwif->ultra_mask;
> -	else
> +	ultra_mask = id->dma_ultra & hwif->ultra_mask;
> +
> +	if (!(id->field_valid & 4))
>  		mode = 0;	/* fallback to MW/SW DMA if no UltraDMA */
>  

Looks fine to me, id-> is always the full 512 bytes of data so its safe
to do that.
