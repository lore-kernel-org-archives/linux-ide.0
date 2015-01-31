From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ata: libahci: Use of_platform_device_create only if supported
Date: Sat, 31 Jan 2015 17:34:43 +0100
Message-ID: <54CD0423.7010402@redhat.com>
References: <1422721938-1542-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44987 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbbAaQew (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 31 Jan 2015 11:34:52 -0500
In-Reply-To: <1422721938-1542-1-git-send-email-linux@roeck-us.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>

Hi,

On 01/31/2015 05:32 PM, Guenter Roeck wrote:
> of_platform_device_create does not exist if OF_ADDRESS is not configured,
> so limit its use accordingly.
> 
> Without this fix, the sparc64:allmodconfig build fails with
> 
> ERROR: "of_platform_device_create" [drivers/ata/libahci_platform.ko] undefined!
> 
> Fixes: c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators")
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Looks good, Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
> Applies to -next.
> 
>  drivers/ata/libahci_platform.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 077c7a2..de9a5dc 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -434,7 +434,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
>  			}
>  			mask_port_map |= BIT(port);
>  
> -			of_platform_device_create(child, NULL, NULL);
> +			if (IS_ENABLED(CONFIG_OF_ADDRESS))
> +				of_platform_device_create(child, NULL, NULL);
>  
>  			port_dev = of_find_device_by_node(child);
>  
> 
