From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ata: Fix the command description of FSL SATA controller
Date: Fri, 08 May 2009 15:41:42 +0400
Message-ID: <4A041A76.9090707@ru.mvista.com>
References: <1241704397-24043-1-git-send-email-daveliu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:29956 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751831AbZEHLlP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 May 2009 07:41:15 -0400
In-Reply-To: <1241704397-24043-1-git-send-email-daveliu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Liu <daveliu@freescale.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Dave Liu wrote:
> The bit 11 of command description is reserved bit in Freescale
> SATA controller, we should be set '1'.

    s/we/it/

> Signed-off-by: Dave Liu <daveliu@freescale.com>

[...]

> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index c2e90e1..f158bd7 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -205,6 +205,7 @@ struct cmdhdr_tbl_entry {
>   * Description information bitdefs
>   */
>  enum {
> +	CMD_DESC_RES = (1 << 11),
>  	VENDOR_SPECIFIC_BIST = (1 << 10),
>  	CMD_DESC_SNOOP_ENABLE = (1 << 9),
>  	FPDMA_QUEUED_CMD = (1 << 8),
> @@ -387,7 +388,7 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
>  	void __iomem *hcr_base = host_priv->hcr_base;
>  	unsigned int tag = sata_fsl_tag(qc->tag, hcr_base);
>  	struct command_desc *cd;
> -	u32 desc_info = CMD_DESC_SNOOP_ENABLE;
> +	u32 desc_info = CMD_DESC_RES | CMD_DESC_SNOOP_ENABLE;
>  	u32 num_prde = 0;
>  	u32 ttl_dwords = 0;
>  	dma_addr_t cd_paddr;
> @@ -840,7 +841,7 @@ issue_srst:
>  
>  	/* device reset/SRST is a control register update FIS, uses tag0 */
>  	sata_fsl_setup_cmd_hdr_entry(pp, 0,
> -				     SRST_CMD | CMD_DESC_SNOOP_ENABLE, 0, 0, 5);
> +		SRST_CMD | CMD_DESC_RES | CMD_DESC_SNOOP_ENABLE, 0, 0, 5);

    Why spoil nicely formatted multiline statement and not do this instead:

	sata_fsl_setup_cmd_hdr_entry(pp, 0, SRST_CMD | CMD_DESC_RES |
				     CMD_DESC_SNOOP_ENABLE, 0, 0, 5);


> @@ -886,7 +887,8 @@ issue_srst:
>  	 * using ATA signature D2H register FIS to the host controller.
>  	 */
>  
> -	sata_fsl_setup_cmd_hdr_entry(pp, 0, CMD_DESC_SNOOP_ENABLE, 0, 0, 5);
> +	sata_fsl_setup_cmd_hdr_entry(pp, 0, CMD_DESC_RES | CMD_DESC_SNOOP_ENABLE,
> +				      0, 0, 5);

    Unnedded space.

MBR, Sergei
