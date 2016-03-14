From: Carolin Latze <carolin.latze@gmail.com>
Subject: Re: kernel crash with lite-on sata controller Dell XPS 13 9343
Date: Mon, 14 Mar 2016 17:02:46 +0100
Message-ID: <56E6E0A6.1060808@gmail.com>
References: <56CF75E6.5070803@gmail.com>
 <20160225215130.GK6092@mtj.duckdns.org> <56CF77CE.2040204@gmail.com>
 <CAOS58YNe5Jw-OiDHs6t-uUN8n0c-8LkJYFbVLQ4TjGtMtsTJgw@mail.gmail.com>
 <56D6A86C.9070007@gmail.com> <20160302152559.GA4282@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34197 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933130AbcCNQCw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2016 12:02:52 -0400
Received: by mail-wm0-f49.google.com with SMTP id p65so108360073wmp.1
        for <linux-ide@vger.kernel.org>; Mon, 14 Mar 2016 09:02:51 -0700 (PDT)
In-Reply-To: <20160302152559.GA4282@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans De Goede <hdegoede@redhat.com>, linux-ide <linux-ide@vger.kernel.org>

Hi Tejun

just a quick update from my side: I did patch the rc5 kernel yesterday 
(I am aware that there is a newer one but when you sent the patch, rc5 
was recent so I wanted to be on the safe side). There is a little typo 
on the "dma_boundary" line, the trailing comma is missing. But other 
than that, the patching went smoothly. Since then I reboot whenever I 
can. So far 15-20 times and no issue up until now. I will keep rebooting 
very often for the next days and keep you posted.

best regards
Carolin

On 02.03.2016 16:25, Tejun Heo wrote:
> Hello, Carolin.
>
> On Wed, Mar 02, 2016 at 09:46:36AM +0100, Carolin Latze wrote:
>> please see attached screen capture. If there is any better way to capture
>> those logs than taking pictures, please let me know
> Heh, so there have been quite a few cases where device locks up after
> a lot of NCQ commands are issued and/or data transfer is taking place
> at high rate but device locking up on plain WRITE_DMA_EXT is pretty
> new.  Hmmm.... Does the following patch make any difference?
>
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 45586c1..95c4d5c 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -366,8 +366,8 @@ extern struct device_attribute *ahci_sdev_attrs[];
>   #define AHCI_SHT(drv_name)						\
>   	ATA_NCQ_SHT(drv_name),						\
>   	.can_queue		= AHCI_MAX_CMDS - 1,			\
> -	.sg_tablesize		= AHCI_MAX_SG,				\
> -	.dma_boundary		= AHCI_DMA_BOUNDARY,			\
> +	.sg_tablesize		= LIBATA_MAX_PRD,			\
> +	.dma_boundary		= ATA_DMA_BOUNDARY			\
>   	.shost_attrs		= ahci_shost_attrs,			\
>   	.sdev_attrs		= ahci_sdev_attrs
>   

