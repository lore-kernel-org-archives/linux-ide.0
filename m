From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata: libahci: properly propagate return value of
 platform_get_irq()
Date: Wed, 17 May 2017 12:11:45 +0300
Message-ID: <a44ed587-6e2e-373f-8c2c-1d1d451762f9@cogentembedded.com>
References: <1494936372-27209-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35725 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753010AbdEQJLr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2017 05:11:47 -0400
Received: by mail-wm0-f49.google.com with SMTP id b84so157065684wmh.0
        for <linux-ide@vger.kernel.org>; Wed, 17 May 2017 02:11:47 -0700 (PDT)
In-Reply-To: <1494936372-27209-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>

Hello!

On 5/16/2017 3:06 PM, Thomas Petazzoni wrote:

> When platform_get_irq() fails, it returns an error code, which
> libahci_platform and replaces it by -EINVAL.

    Couldn't parse this sentence...

> This commit fixes that by
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
> ---
>  drivers/ata/libahci_platform.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index aaa761b..cd2eab6 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -514,8 +514,9 @@ int ahci_platform_init_host(struct platform_device *pdev,
>
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq <= 0) {
> -		dev_err(dev, "no irq\n");
> -		return -EINVAL;
> +		if (irq != -EPROBE_DEFER)
> +			dev_err(dev, "no irq\n");
> +		return irq;

    Iff 'irq' is 0, you'll return 0 here, indicating success.
    Actually, I've fixed platform_get_irq() not to return 0 on error.

[...]

MBR, Sergei

