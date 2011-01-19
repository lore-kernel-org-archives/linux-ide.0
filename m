From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2 v3] pata_hpt{366|37x}: use pr_warning(...) instead
 of printk(KERN_WARNING ...)
Date: Tue, 18 Jan 2011 19:56:10 -0500
Message-ID: <4D3636AA.2000402@pobox.com>
References: <201101102134.28111.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59085 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab1ASA4O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2011 19:56:14 -0500
Received: by vws16 with SMTP id 16so128508vws.19
        for <linux-ide@vger.kernel.org>; Tue, 18 Jan 2011 16:56:13 -0800 (PST)
In-Reply-To: <201101102134.28111.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 01/10/2011 01:34 PM, Sergei Shtylyov wrote:
> ... in hpt_dma_blacklisted().
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree plus the patches queued by
> Jeff Garzik in his 'upstream-linus' branch.
>
> Changes from the previous version:
> - added the similar change for the 'pata_hpt37x' driver...
>
>   drivers/ata/pata_hpt366.c |    6 +++---
>   drivers/ata/pata_hpt37x.c |    6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> Index: linux-2.6/drivers/ata/pata_hpt366.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/pata_hpt366.c
> +++ linux-2.6/drivers/ata/pata_hpt366.c
> @@ -25,7 +25,7 @@
>   #include<linux/libata.h>
>
>   #define DRV_NAME	"pata_hpt366"
> -#define DRV_VERSION	"0.6.9"
> +#define DRV_VERSION	"0.6.10"
>
>   struct hpt_clock {
>   	u8	xfer_mode;
> @@ -160,8 +160,8 @@ static int hpt_dma_blacklisted(const str
>
>   	while (list[i] != NULL) {
>   		if (!strcmp(list[i], model_num)) {
> -			printk(KERN_WARNING DRV_NAME ": %s is not supported for %s.\n",
> -				modestr, list[i]);
> +			pr_warning(DRV_NAME ": %s is not supported for %s.\n",
> +				   modestr, list[i]);
>   			return 1;
>   		}
>   		i++;
> Index: linux-2.6/drivers/ata/pata_hpt37x.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/pata_hpt37x.c
> +++ linux-2.6/drivers/ata/pata_hpt37x.c
> @@ -24,7 +24,7 @@
>   #include<linux/libata.h>
>
>   #define DRV_NAME	"pata_hpt37x"
> -#define DRV_VERSION	"0.6.18"
> +#define DRV_VERSION	"0.6.19"
>
>   struct hpt_clock {
>   	u8	xfer_speed;
> @@ -229,8 +229,8 @@ static int hpt_dma_blacklisted(const str
>
>   	while (list[i] != NULL) {
>   		if (!strcmp(list[i], model_num)) {
> -			printk(KERN_WARNING DRV_NAME ": %s is not supported for %s.\n",
> -				modestr, list[i]);
> +			pr_warning(DRV_NAME ": %s is not supported for %s.\n",
> +				   modestr, list[i]);

Even though I am applying these patches -- forward progress -- I would 
encourage you to consider ata_dev_printk() here, since we have the 
ata_device pointer available.


