From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH #upstream-fixes] libahci: fix result_tf handling after
 an ATA PIO data-in command
Date: Thu, 14 Oct 2010 17:38:02 -0400
Message-ID: <4CB7783A.2050604@teksavvy.com>
References: <4C9C3878.9010206@teksavvy.com>	<AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com>	<4C9C44D0.1030409@teksavvy.com>	<AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com>	<4C9CA385.5090709@teksavvy.com>	<4C9CA673.4090104@teksavvy.com>	<4C9D33C0.8050900@gmail.com>	<4CA99BCB.8080904@gmail.com>	<4CAA0885.8060906@teksavvy.com>	<4CAA0996.5080403@teksavvy.com>	<4CAA0F6C.6080609@teksavvy.com>	<4CAA21F4.5060000@teksavvy.com>	<4CAA2AA6.2010204@pobox.com>	<4CAA2C6F.2090603@teksavvy.com>	<4CAA2E16.4010905@pobox.com>	<4CAA3033.8030405@teksavvy.com>	<4CAACEBE.1000104@gmail.com>	<4CAB30FA.2010508@teksavvy.com>	<4CAB4CE9.9070709@gmail.com> <AANLkTin=QWXcuy6JOi1y26dWH8FG1ji3JewTXu0K=4ri@mail.gmail.com> <4CB6C50F.60609@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:63318 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932244Ab0JNViG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Oct 2010 17:38:06 -0400
In-Reply-To: <4CB6C50F.60609@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Robert Hancock <hancockrwd@gmail.com>, Seed <seedrubbish@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

On 10-10-14 04:53 AM, Tejun Heo wrote:
> ATA devices don't send D2H Reg FIS after an successful ATA PIO data-in
> command.  The host is supposed to take the E_Status of the preceding
> PIO Setup FIS.  Update ahci_qc_fill_rtf() such that it takes E_Status
> after a successful ATA PIO data-in command.
>
> Without this patch, result_tf for such a command is filled with the
> content of the previous D2H Reg FIS which belongs to a previous
> command, which can make the command incorrectly seen as failed.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Mark Lord<kernel@teksavvy.com>
> Cc: Robert Hancock<hancockrwd@gmail.com>
> Cc: stable@kernel.org
> ---
>   drivers/ata/ahci.h    |    1 +
>   drivers/ata/libahci.c |   17 ++++++++++++++---
>   2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index e5fdeeb..d1a0f5b 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -72,6 +72,7 @@ enum {
>   	AHCI_CMD_RESET		= (1<<  8),
>   	AHCI_CMD_CLR_BUSY	= (1<<  10),
>
> +	RX_FIS_PIO_SETUP	= 0x20,	/* offset of PIO Setup FIS data */
>   	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
>   	RX_FIS_SDB		= 0x58, /* offset of SDB FIS data */
>   	RX_FIS_UNK		= 0x60, /* offset of Unknown FIS data */
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 8eea309..0c482a0 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1830,12 +1830,23 @@ static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
>   static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
>   {
>   	struct ahci_port_priv *pp = qc->ap->private_data;
> -	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
> +	u8 *rx_fis = pp->rx_fis;
>
>   	if (pp->fbs_enabled)
> -		d2h_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
> +		rx_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
> +
> +	/*
> +	 * After a successful execution of an ATA PIO data-in command,
> +	 * the device doesn't send D2H Reg FIS to update the TF and
> +	 * the host should take Status from E_Status of the preceding
> +	 * PIO Setup FIS.
> +	 */
> +	if (qc->tf.protocol == ATA_PROT_PIO&&  qc->dma_dir == DMA_FROM_DEVICE&&
> +	    !(qc->flags&  ATA_QCFLAG_FAILED))
..

I'm not certain, but doesn't this problem also affect DMA_TO_DEVICE PIO commands?
Eg. SECURITY_ERASE_PREPARE and PIO_WRITE ?

Thanks.
