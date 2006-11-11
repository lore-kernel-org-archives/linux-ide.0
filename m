From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH][TRIVIAL] drivers/ide: stray bracket
Date: Sat, 11 Nov 2006 16:16:12 +0300
Message-ID: <20061111131612.GA4974@martell.zuzino.mipt.ru>
References: <20061111014756.3467d7ee@lucky.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1947224AbWKKNQU@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061111014756.3467d7ee@lucky.kitzblitz>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Kaiser <nikai@nikai.net>
Cc: linux-ide@vger.kernel.org, trivial@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sat, Nov 11, 2006 at 01:47:56AM +0100, Nicolas Kaiser wrote:
> Stray bracket in debug code.

> --- a/drivers/ide/legacy/hd.c	2006-09-20 05:42:06.000000000 +0200
> +++ b/drivers/ide/legacy/hd.c	2006-11-10 21:52:20.000000000 +0100
> @@ -459,7 +459,7 @@ ok_to_read:
>  #ifdef DEBUG
>  	printk("%s: read: sector %ld, remaining = %ld, buffer=%p\n",
>  		req->rq_disk->disk_name, req->sector, req->nr_sectors,
> -		req->buffer+512));
> +		req->buffer+512);
>  #endif

Just remove whole printk. It was broken for a looong time.
