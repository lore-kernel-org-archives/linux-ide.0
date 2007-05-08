From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Cleanup libata HPA support
Date: Tue, 08 May 2007 09:44:52 -0400
Message-ID: <46407ED4.9090301@rtr.ca>
References: <1178621978.6962.75.camel@cunning>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S967606AbXEHNo4@vger.kernel.org>
In-Reply-To: <1178621978.6962.75.camel@cunning>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Collins <ben.collins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Kyle McMartin <kyle@ubuntu.com>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Ben Collins wrote:
..
>  static u64 ata_tf_to_lba48(struct ata_taskfile *tf)
>  {
> -	u64 sectors = 0;
> +	u64 sectors;
> +	u32 high, low;
>  
> -	sectors |= ((u64)(tf->hob_lbah & 0xff)) << 40;
> -	sectors |= ((u64)(tf->hob_lbam & 0xff)) << 32;
> -	sectors |= (tf->hob_lbal & 0xff) << 24;
> -	sectors |= (tf->lbah & 0xff) << 16;
> -	sectors |= (tf->lbam & 0xff) << 8;
> -	sectors |= (tf->lbal & 0xff);
> +	high = (tf->hob_lbah << 16) |
> +	       (tf->hob_lbam <<  8) |
> +		tf->hob_lbal;
> +	low  = (tf->lbah << 16) |
> +	       (tf->lbam <<  8) |
> +		tf->lbal;
>  
> -	return ++sectors;
> +	sectors = ((u64)high << 24) | low;
> +
> +	return sectors + 1;
>  }

Ben, I very much prefer the fixed version of this function
as implemented by the patch above.

But.. is the original code actually broken, or just messy?

Cheers
