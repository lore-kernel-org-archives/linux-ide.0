From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/4] libata: add R-Car SATA driver
Date: Sat, 25 May 2013 03:12:22 +0400
Message-ID: <519FF3D6.2090202@cogentembedded.com>
References: <201302202310.30443.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:37166 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab3EXXMQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 May 2013 19:12:16 -0400
Received: by mail-la0-f54.google.com with SMTP id eg20so5025047lab.13
        for <linux-ide@vger.kernel.org>; Fri, 24 May 2013 16:12:14 -0700 (PDT)
In-Reply-To: <201302202310.30443.sergei.shtylyov@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: vladimir.barinov@cogentembedded.com

Hello.

On 02/20/2013 11:10 PM, Sergei Shtylyov wrote:

     Tejun, a question for you... see below.

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>
> Add Renesas R-Car on-chip 3Gbps SATA controller driver.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: few bugs fixed, significant cleanup]

     Not all bugs turned out to be fixed... :-/

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]
> Index: renesas/drivers/ata/sata_rcar.c
> ===================================================================
> --- /dev/null
> +++ renesas/drivers/ata/sata_rcar.c
> @@ -0,0 +1,910 @@
[...]
> +static void sata_rcar_bmdma_fill_sg(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct ata_bmdma_prd *prd = ap->bmdma_prd;
> +	struct scatterlist *sg;
> +	unsigned int si, pi;
> +
> +	pi = 0;
> +	for_each_sg(qc->sg, sg, qc->n_elem, si) {
> +		u32 addr, sg_len, len;
> +
> +		/*
> +		 * Note: h/w doesn't support 64-bit, so we unconditionally
> +		 * truncate dma_addr_t to u32.
> +		 */
> +		addr = (u32)sg_dma_address(sg);
> +		sg_len = sg_dma_len(sg);
> +
> +		/* H/w transfer count is only 29 bits long, let's be careful */
> +		while (sg_len) {
> +			len = sg_len;
> +			if (len > 0x1ffffffe)

    This value should have been put into the 'dma_boundary' field of the
'struct scsi_host_template', IIUC. Tejun, if I do it, do I need this 
check at all?

> +				len = 0x1ffffffe;
> +
> +			prd[pi].addr = cpu_to_le32(addr);
> +			prd[pi].flags_len = cpu_to_le32(len);
> +			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
> +
> +			pi++;
> +			sg_len -= len;
> +			addr += len;
> +		}
> +	}
> +
> +	/* end-of-table flag */
> +	prd[pi - 1].addr |= cpu_to_le32(SATA_RCAR_DTEND);
> +}
[...]
> +static struct scsi_host_template sata_rcar_sht = {
> +	ATA_BMDMA_SHT(DRV_NAME),
> +};

     This should have been ATA_BASE_SHT() and the proepr values 
specified for
the 'sg_tablesize' and 'dma_boundary' fields. R-Car SATA descriptors are not
the same as SFF-8038i, they allow up to 512 megs of data to be specified in
one descriptor and don't care about 64KiB boundaries.

WBR, Sergei

