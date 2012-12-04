From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v2 2/4] pata_octeon_cf: perform host detach, removal on
 exit
Date: Mon, 03 Dec 2012 16:26:25 -0800
Message-ID: <50BD4331.6010904@gmail.com>
References: <1354559682-30965-1-git-send-email-computersforpeace@gmail.com> <1354559682-30965-2-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46644 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab2LDA02 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 19:26:28 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2398980pbc.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 16:26:28 -0800 (PST)
In-Reply-To: <1354559682-30965-2-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, David Daney <david.daney@cavium.com>

On 12/03/2012 10:34 AM, Brian Norris wrote:
> This driver does not detach and remove its ata_host properly on device
> removal. Add the common .remove helper.
>
> Note: I do not know this driver well enough to ensure this is the right
> thing to do. Merge this patch with caution.
>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Cc: David Daney <david.daney@cavium.com>
> ---
> v2: no change (rebased along with previous patch)
>
>   drivers/ata/pata_octeon_cf.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index 1d61d5d..d8df93b 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -921,6 +921,7 @@ free_cf_port:
>
>   static struct platform_driver octeon_cf_driver = {
>   	.probe		= octeon_cf_probe,
> +	.remove		= ata_platform_remove_one,

Can you point me at the definition of ata_platform_remove_one()?

I can seem to find it.  Without knowing what that does, I would be 
inclined to NACK the whole thing.

How did you test the patch?

This patch is likely to be incomplete as the driver is also missing the 
module_exit() things.

It might be simpler to just make the driver "bool" instead of "tristate" 
in the Kconfig.

>   	.driver		= {
>   		.name	= DRV_NAME,
>   		.owner	= THIS_MODULE,
>

