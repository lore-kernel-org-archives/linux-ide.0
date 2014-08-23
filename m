From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v8 2/3] ahci_xgene: Skip the PHY and clock initialization
 if already configured by the firmware.
Date: Sat, 23 Aug 2014 22:43:57 +0400
Message-ID: <53F8E0ED.6030802@cogentembedded.com>
References: <1408819047-17224-1-git-send-email-stripathi@apm.com> <1408819047-17224-3-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:38098 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbaHWSoB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2014 14:44:01 -0400
Received: by mail-la0-f48.google.com with SMTP id gl10so10958502lab.7
        for <linux-ide@vger.kernel.org>; Sat, 23 Aug 2014 11:44:00 -0700 (PDT)
In-Reply-To: <1408819047-17224-3-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>, olof@lixom.net, tj@kernel.org, arnd@arndb.de
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, patches@apm.com, Loc Ho <lho@apm.com>

Hello.

On 08/23/2014 10:37 PM, Suman Tripathi wrote:

> This patch implements the feature to skip the PHY and clock
> initialization if it is already configured by the firmware.

> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>   drivers/ata/ahci_xgene.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index f416495..fd9c137 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -145,6 +145,15 @@ static unsigned int xgene_ahci_qc_issue(struct ata_queued_cmd *qc)
>   	return rc;
>   }
>
> +static bool xgene_ahci_is_memram_inited(struct xgene_ahci_context *ctx)
> +{
> +	void __iomem *diagcsr = ctx->csr_diag;
> +
> +	return (readl(diagcsr + CFG_MEM_RAM_SHUTDOWN) == 0 &&
> +	        readl(diagcsr + BLOCK_MEM_RDY) == 0xFFFFFFFF) ?
> +		true : false;

    Just return the result of &&, that should be enough.

WBR, Sergei

