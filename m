From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE: palm_bk3710: convert clock usage after clkdev conversion
Date: Mon, 13 Jul 2009 22:21:29 +0400
Message-ID: <4A5B7B29.7070400@ru.mvista.com>
References: <1246919176-28683-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:47107 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756898AbZGMSVO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Jul 2009 14:21:14 -0400
In-Reply-To: <1246919176-28683-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-ide@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

Hello.

Kevin Hilman wrote:

> DaVinci core code has converted to the new clkdev API so
> clock name strings are not needed.  Instead, just the a
> 'struct device' pointer is needed.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> Fix needed for 2.6.31
> 
>  drivers/ide/palm_bk3710.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
> index 3c1dc01..f8eddf0 100644
> --- a/drivers/ide/palm_bk3710.c
> +++ b/drivers/ide/palm_bk3710.c
> @@ -318,7 +318,7 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
>  	int i, rc;
>  	struct ide_hw hw, *hws[] = { &hw };
>  
> -	clk = clk_get(&pdev->dev, "IDECLK");
> +	clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(clk))
>  		return -ENODEV;
>  

    It doesn't seem strictly necessary for 2.6.31 -- only in the sense that 
"IDECLK" isn't named so anymore, however, clk_get() should still work.

MBR, Sergei
