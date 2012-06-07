From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/7] drivers/ide/ide-cs.c: adjust suspicious bit
 operation
Date: Thu, 07 Jun 2012 14:46:16 -0700 (PDT)
Message-ID: <20120607.144616.2224976714259476349.davem@davemloft.net>
References: <1339018901-28439-1-git-send-email-Julia.Lawall@lip6.fr>
	<1339018901-28439-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339018901-28439-2-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia.Lawall@lip6.fr
Cc: kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com, julia@diku.dk
List-Id: linux-ide@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Wed,  6 Jun 2012 23:41:35 +0200

> -	if (!(pdev->resource[0]->flags & IO_DATA_PATH_WIDTH_8)) {
> +	if ((p1dev->resource[0]->flags & IO_DATA_PATH_WIDTH)

I'm really surprised someone as thorough as yourself did not
compile test this.

This is just more proof that it's absolutely pointless to make any
changes at all to the old IDE layer.  Nobody really cares, and the
risk %99.999 of the time is purely to introduce regressions rather
than make forward progress.
