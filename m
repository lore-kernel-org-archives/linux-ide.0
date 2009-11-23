From: David Miller <davem@davemloft.net>
Subject: Re: drivers/ide/au1xxx-ide.c: use resource_size()
Date: Mon, 23 Nov 2009 10:28:17 -0800 (PST)
Message-ID: <20091123.102817.157628485.davem@davemloft.net>
References: <BD79186B4FD85F4B8E60E381CAEE190901EE5BFD@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755022AbZKWS2A@vger.kernel.org>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901EE5BFD@mi8nycmail19.Mi8.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hartleys@visionengravers.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Date: Mon, 23 Nov 2009 13:15:32 -0500

> Use resource_size() for {request/release}_mem_region and ioremap.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Applied to ide-next-2.6, thanks.

>  
> -	ahwif->regbase = (u32)ioremap(res->start, res->end - res->start + 1);
> +	ahwif->regbase = (u32)ioremap(res->start, resource_size(res));
>  	if (ahwif->regbase == 0) {
>  		ret = -ENOMEM;
>  		goto out;

That needs some fixing.  ioremap()'s return value is an
"__iomem" pointer, not an integer.  ->regbase's type should be
changed to something like "void __iomem *" etc.
