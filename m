From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] AHCI: Make distinct names for ports in /proc/interrupts
Date: Mon, 29 Apr 2013 15:32:08 +0400
Message-ID: <517E5A38.7050609@cogentembedded.com>
References: <20130429101237.GA27738@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:37601 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab3D2Ld2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Apr 2013 07:33:28 -0400
Received: by mail-la0-f48.google.com with SMTP id eo20so5281281lab.21
        for <linux-ide@vger.kernel.org>; Mon, 29 Apr 2013 04:33:26 -0700 (PDT)
In-Reply-To: <20130429101237.GA27738@dhcp-26-207.brq.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jan Beulich <JBeulich@suse.com>

Hello.

On 29-04-2013 14:12, Alexander Gordeev wrote:

> Currently all interrupts assigned to AHCI ports show up in
> '/proc/interrupts' as 'ahci'. This fix adds port numbers as
> suffixes and hence makes the descriptions distinct.

> Reported-by: Jan Beulich <JBeulich@suse.com>
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>   drivers/ata/ahci.c |    6 ++++--
>   drivers/ata/ahci.h |    1 +
>   2 files changed, 5 insertions(+), 2 deletions(-)

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 3b9a7b1..dc5c1aa 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1146,10 +1146,12 @@ int ahci_host_activate(struct ata_host *host, int irq, unsigned int n_msis,
>   			return -EINVAL;
>
>   		for (i = 0; i < n_irqs; i++) {
> +			struct ahci_port_priv *pp = host->ports[i]->private_data;

    Empty line wouldn't hurt here, after declaration.

> +			snprintf(pp->irq_desc, sizeof(pp->irq_desc),
> +				 "%s%d", dev_driver_string(host->dev), i);
>   			rc = devm_request_threaded_irq(host->dev, irq + i,
>   				ahci_multi_irqs_intr, ahci_port_thread_fn,
> -				IRQF_SHARED, dev_driver_string(host->dev),
> -				host->ports[i]);
> +				IRQF_SHARED, pp->irq_desc, host->ports[i]);
>   			if (rc)
>   				goto out_free_irqs;
>   		}

WBR, Sergei

