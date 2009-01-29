From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE: palm_bk3710: use ioremap instead of arch-specific
 IO_ADDRESS()
Date: Fri, 30 Jan 2009 02:51:07 +0300
Message-ID: <498240EB.3090907@ru.mvista.com>
References: <1233270357-604-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:52716 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756578AbZA2XvR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Jan 2009 18:51:17 -0500
In-Reply-To: <1233270357-604-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-ide@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

Hello.

Kevin Hilman wrote:

> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>   

   Sorry, NAK.

> diff --git a/drivers/ide/palm_bk3710.c b/drivers/ide/palm_bk3710.c
> index f38aac7..be9c904 100644
> --- a/drivers/ide/palm_bk3710.c
> +++ b/drivers/ide/palm_bk3710.c
> @@ -380,7 +380,11 @@ static int __init palm_bk3710_probe(struct platform_device *pdev)
>  		return -EBUSY;
>  	}
>  
> -	base = IO_ADDRESS(mem->start);
> +	base = ioremap(mem->start, mem->end);
> +	if (!base) {
> +		printk(KERN_ERR "failed to map IO memory\n");
> +		return -ENOMEM;
>   

   Leaks requested memory region.

MBR, Sergei


