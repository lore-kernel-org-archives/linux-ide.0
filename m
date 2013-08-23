From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v4 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Fri, 23 Aug 2013 16:27:42 +0400
Message-ID: <5217553E.4080200@cogentembedded.com>
References: <1377250847-24132-1-git-send-email-marc.ceeeee@gmail.com> <1377250847-24132-2-git-send-email-marc.ceeeee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:50483 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab3HWM1h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Aug 2013 08:27:37 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so419344lab.19
        for <linux-ide@vger.kernel.org>; Fri, 23 Aug 2013 05:27:36 -0700 (PDT)
In-Reply-To: <1377250847-24132-2-git-send-email-marc.ceeeee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc C <marc.ceeeee@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On 23-08-2013 13:40, Marc C wrote:

> From: Marc Carino <marc.ceeeee@gmail.com>

> SATA 3.1 added an "auxiliary" field to the host-to-device FIS.
> Populate the host-to-device FIS with the new field via the
> taskfile struct.

> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
> ---
>   drivers/ata/ahci.c        |  8 ++++++++
>   drivers/ata/libata-core.c | 10 ++++++----
>   include/linux/libata.h    |  5 +++++
>   3 files changed, 19 insertions(+), 4 deletions(-)

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 5064f3e..8d41c57 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1288,6 +1288,14 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		 */
>   		if (!(hpriv->flags & AHCI_HFLAG_NO_FPDMA_AA))
>   			pi.flags |= ATA_FLAG_FPDMA_AA;
> +
> +		/*
> +		 * All AHCI controllers should be forward-compatible
> +		 * with the new auxiliary field. This code should be
> +		 * conditionalized if any buggy AHCI controllers are
> +		 * encountered.
> +		 */
> +		pi.flags |= ATA_FLAG_FPDMA_AUX;
[...]
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 283d66b..6539c50 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -223,6 +223,7 @@ enum {
>   	ATA_FLAG_ACPI_SATA	= (1 << 17), /* need native SATA ACPI layout */
>   	ATA_FLAG_AN		= (1 << 18), /* controller supports AN */
>   	ATA_FLAG_PMP		= (1 << 19), /* controller supports PMP */
> +	ATA_FLAG_FPDMA_AUX	= (1 << 20), /* controller supports H2DFIS aux field */

    I think adding this flag is a matter of a separate patch.

WBR, Sergei

