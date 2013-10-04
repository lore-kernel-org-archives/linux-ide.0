From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] ahci: use dev_info() instead of printk()
Date: Fri, 04 Oct 2013 22:18:25 +0200
Message-ID: <524F2291.2060501@cogentembedded.com>
References: <000601cec0c1$58186d20$08494760$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:37801 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136Ab3JDTSZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Oct 2013 15:18:25 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so1985757eek.38
        for <linux-ide@vger.kernel.org>; Fri, 04 Oct 2013 12:18:24 -0700 (PDT)
In-Reply-To: <000601cec0c1$58186d20$08494760$%han@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Tejun Heo' <tj@kernel.org>, linux-ide@vger.kernel.org

Hello.

On 04-10-2013 7:19, Jingoo Han wrote:

> Use the printk(KERN_INFO,...) call to to dev_info() instead,
> to tie into the dynamic debugging infrastructure.

    I can't even parse this sentence, not to mention dev_info() has no 
relation to dynamic debugging.

> Also change "raw" printk() call to dev_info() to provide a better
> error message to userspace so it can properly identify the device
> and not just have to guess.

    I'm only seeing the second change in your patch.

> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
[...]

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 9d715ae..8e28f92 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1343,7 +1343,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
>   		host->flags |= ATA_HOST_PARALLEL_SCAN;
>   	else
> -		printk(KERN_INFO "ahci: SSS flag set, parallel bus scan disabled\n");
> +		dev_info(&pdev->dev, "SSS flag set, parallel bus scan disabled\n");

WBR, Sergei


