From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/5] sata_dwc: Add support ATAPI transfer
Date: Thu, 10 May 2012 13:50:09 +0400
Message-ID: <4FAB8F51.3010004@mvista.com>
References: <1336623449-7697-1-git-send-email-tqnguyen@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51926 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757941Ab2EJJue (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 May 2012 05:50:34 -0400
Received: by lahd3 with SMTP id d3so926251lah.19
        for <linux-ide@vger.kernel.org>; Thu, 10 May 2012 02:50:33 -0700 (PDT)
In-Reply-To: <1336623449-7697-1-git-send-email-tqnguyen@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Thang Q. Nguyen" <tqnguyen@apm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello.

On 10-05-2012 8:17, Thang Q. Nguyen wrote:

> Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
> ---
>   drivers/ata/sata_dwc_460ex.c |   64 ++++++++++++++++++++++++++++++++++++++++--
>   1 files changed, 61 insertions(+), 3 deletions(-)

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 937aeb3..6175e01 100755
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
[...]
> @@ -1385,6 +1389,58 @@ static void sata_dwc_port_stop(struct ata_port *ap)
>   	ap->private_data = NULL;
>   }
>
> +/**
> + * sata_dwc_check_atapi_dma - Filter ATAPI cmds which are unsuitable for DMA.
> + * @qc: queued command to check for chipset/DMA compatibility.
> + *
> + * The bmdma engines cannot handle speculative data sizes (bytecount
> + * under/over flow). So only allow DMA for data transfer commands with
> + * known data sizes.
> + */
> +static int sata_dwc_check_atapi_dma(struct ata_queued_cmd *qc)
> +{
[...]
> +
> +		/* -45150 (FFFF4FA2) to -1 (FFFFFFFF) shall use PIO mode */

    Sector numbers are unsigned entities.

> +		if (scmd->cmnd[0] == WRITE_10) {
> +			lba = (scmd->cmnd[2] << 24) |
> +				  (scmd->cmnd[3] << 16) |
> +				  (scmd->cmnd[4] << 8) |
> +				   scmd->cmnd[5];
> +			if (lba>= 0xFFFF4FA2)
> +				pio = 1;
> +		}
> +		/*
> +		* WORK AROUND: Fix DMA issue when blank CD/DVD disc in the drive
> +		* and user use the 'fdisk -l' command. No DMA data returned so
> +		* we can not complete the QC.

    The user shouldn't use 'fdisk' command on  CD/DVD disks. On the other 
hand, he could use something like 'hdparm -t' od 'dd' with offset in which 
case I'm not sure this heuristics will work.

> +		*/
> +		else if (scmd->cmnd[0] == READ_10) {
> +			lba = (scmd->cmnd[2] << 24) |
> +				  (scmd->cmnd[3] << 16) |
> +				  (scmd->cmnd[4] << 8) |
> +				   scmd->cmnd[5];
> +			if (lba < 0x20)
> +				pio = 1;
> +		}
> +	}
> +	return pio;
> +}
> +
>   /*
>    * Function : sata_dwc_exec_command_by_tag
>    * arguments : ata_port *ap, ata_taskfile *tf, u8 tag, u32 cmd_issued

WBR, Sergei
