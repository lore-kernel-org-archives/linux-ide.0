From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/3] libahci: Implement the capability to override the
 generic ahci interrupt handler.
Date: Fri, 5 Feb 2016 17:12:40 +0300
Message-ID: <56B4ADD8.1020008@cogentembedded.com>
References: <1454620826-22554-1-git-send-email-stripathi@apm.com>
 <1454620826-22554-2-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34225 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbcBEOMp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Feb 2016 09:12:45 -0500
Received: by mail-lb0-f170.google.com with SMTP id cw1so50182558lbb.1
        for <linux-ide@vger.kernel.org>; Fri, 05 Feb 2016 06:12:43 -0800 (PST)
In-Reply-To: <1454620826-22554-2-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: suman Tripathi <stripathi@apm.com>, olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com

Hello.

On 02/05/2016 12:20 AM, suman Tripathi wrote:

> From: Suman Tripathi <stripathi@apm.com>
>
> This patch implements the capability to override the generic
> ahci interrupt handler so that the LDD drivers can implement

    AHCI.

> there own custom interrupt handler routines.

    s/there/their/.

> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>   drivers/ata/ahci.h    |    2 ++
>   drivers/ata/libahci.c |   32 +++++++++++++++++++++++---------
>   2 files changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index a4faa43..3d883ee 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -360,6 +360,7 @@ struct ahci_host_priv {
>   	 * be overridden anytime before the host is activated.
>   	 */
>   	void			(*start_engine)(struct ata_port *ap);
> +	irqreturn_t 		(*ahci_irq_intr)(int irq, void *dev_instance);

    The 'ahci_irq_intr' name is somewhat tautological.


[...]
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index eda3cf2..5d3035a 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
[...]
> @@ -2504,15 +2505,28 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
>   	struct ahci_host_priv *hpriv = host->private_data;
>   	int irq = hpriv->irq;
>   	int rc;
> +	irqreturn_t (*ahci_irq_handler)(int irq, void *dev_instance);
>
> -	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
> -		rc = ahci_host_activate_multi_irqs(host, sht);
> -	else if (hpriv->flags & AHCI_HFLAG_EDGE_IRQ)
> -		rc = ata_host_activate(host, irq, ahci_single_edge_irq_intr,
> -				       IRQF_SHARED, sht);
> -	else
> -		rc = ata_host_activate(host, irq, ahci_single_level_irq_intr,
> -				       IRQF_SHARED, sht);
> +	ahci_irq_handler = hpriv->ahci_irq_intr;
> +
> +	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX)) {
> +		if (!ahci_irq_handler)
> +			rc = ahci_host_activate_multi_irqs(host, sht);
> +		else
> +			dev_warn(host->dev, "both AHCI_HFLAG_MULTI_MSI flag set \
> +				 and custom irq handler implemented\n");
> +
> +	} else {
> +		if (!ahci_irq_handler) {

    Why not *else* *if* on a single line?

[...]

MBR, Sergei

