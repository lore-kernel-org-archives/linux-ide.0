From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] sata_sil24: Identify which card suffered IRQ status error
Date: Tue, 22 Jul 2014 18:10:50 +0400
Message-ID: <53CE70EA.7030600@cogentembedded.com>
References: <20140722132800.952BA60250@zebedee.buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:42115 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbaGVOKw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2014 10:10:52 -0400
Received: by mail-lb0-f180.google.com with SMTP id v6so5634814lbi.25
        for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2014 07:10:51 -0700 (PDT)
In-Reply-To: <20140722132800.952BA60250@zebedee.buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>, linux-ide@vger.kernel.org
Cc: tj@kernel.org

Hello.

On 07/22/2014 05:28 PM, Tim Small wrote:

> In machines with multiple Silicon Image 3124 and/or 3132 cards, there is no
> way to tell which card is the culprit when the sata_sil24 interrupt handler
> gets a bad status.

> Tested-by: tim@seoss.co.uk
> Signed-off-by: tim@seoss.co.uk

    Full name is required before email, and email should be enclosed in <>. 
Also, I guess you want the same email as the commit author and in the signoff? 
Use the From: line at the start of mail to override the one in the header. See 
Documentation/SubmittingPatches for more details...

[...]

> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 0534890..d81b20d 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -1154,8 +1154,8 @@ static irqreturn_t sil24_interrupt(int irq, void *dev_instance)
>   	status = readl(host_base + HOST_IRQ_STAT);
>
>   	if (status == 0xffffffff) {
> -		printk(KERN_ERR DRV_NAME ": IRQ status == 0xffffffff, "
> -		       "PCI fault or device removal?\n");
> +		dev_err(host->dev, "IRQ status == 0xffffffff, "
> +			"PCI fault or device removal?\n");

    Don't break the string anymore please. I guess you haven't run the patch 
thru scripts/checkpatch.pl?

>   		goto out;
>   	}

WBR, Sergei

