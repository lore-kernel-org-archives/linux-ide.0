From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ata: libahci: properly propagate return value of
 platform_get_irq()
Date: Tue, 16 May 2017 14:59:35 +0200
Message-ID: <5e7eb353-b017-46b2-a9a1-f68465a028cc@redhat.com>
References: <1494936372-27209-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752596AbdEPM7n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 16 May 2017 08:59:43 -0400
In-Reply-To: <1494936372-27209-1-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>

Hi,

On 16-05-17 14:06, Thomas Petazzoni wrote:
> When platform_get_irq() fails, it returns an error code, which
> libahci_platform and replaces it by -EINVAL. This commit fixes that by
> propagating the error code. It fixes the situation where
> platform_get_irq() returns -EPROBE_DEFER because the interrupt
> controller is not available yet, and generally looks like the right
> thing to do.
> 
> We pay attention to not show the "no irq" message when we are in an
> EPROBE_DEFER situation, because the driver probing will be retried
> later on, once the interrupt controller becomes available to provide
> the interrupt.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/ata/libahci_platform.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index aaa761b..cd2eab6 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -514,8 +514,9 @@ int ahci_platform_init_host(struct platform_device *pdev,
>   
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq <= 0) {
> -		dev_err(dev, "no irq\n");
> -		return -EINVAL;
> +		if (irq != -EPROBE_DEFER)
> +			dev_err(dev, "no irq\n");
> +		return irq;
>   	}
>   
>   	hpriv->irq = irq;
> 
