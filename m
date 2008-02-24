From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Sun, 24 Feb 2008 18:21:14 +0100
Message-ID: <200802241821.15052.bzolnier@gmail.com>
References: <20080224053508.GA17530@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:50487 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbYBXRHm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Feb 2008 12:07:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so467459ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 09:07:40 -0800 (PST)
In-Reply-To: <20080224053508.GA17530@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Sunday 24 February 2008, Jeff Garzik wrote:

[...]

> Alan Cox (1):
>       pata_atiixp: Use 255 sector limit

AHCI needs sorting too but this deals with the old interface

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>

[...]

>> diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
> index 9623f52..408bdc1 100644
> --- a/drivers/ata/pata_atiixp.c
> +++ b/drivers/ata/pata_atiixp.c
> @@ -227,7 +227,7 @@ static struct scsi_host_template atiixp_sht = {
>  	.queuecommand		= ata_scsi_queuecmd,
>  	.can_queue		= ATA_DEF_QUEUE,
>  	.this_id		= ATA_SHT_THIS_ID,
> -	.sg_tablesize		= LIBATA_MAX_PRD,
> +	.sg_tablesize		= LIBATA_DUMB_MAX_PRD,
>  	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
>  	.emulated		= ATA_SHT_EMULATED,
>  	.use_clustering		= ATA_SHT_USE_CLUSTERING,
> @@ -259,7 +259,7 @@ static struct ata_port_operations atiixp_port_ops = {
>  	.bmdma_stop	= atiixp_bmdma_stop,
>  	.bmdma_status 	= ata_bmdma_status,
>  
> -	.qc_prep 	= ata_qc_prep,
> +	.qc_prep 	= ata_dumb_qc_prep,
>  	.qc_issue	= ata_qc_issue_prot,
>  
>  	.data_xfer	= ata_data_xfer,

This patch doesn't enforce "255 sector limit" but instead:

- limits max PRD table size from 128 entries to 64

- enables quirk needed for some chipsets to split 64K PRD table entry
  on two 32K ones (these chipsets choke on size == 0x0000)

>From the patch description it can't be told whether the patch itself is
correct and only the patch description is bogus...

Alan/Jeff: please elaborate on what the patch is trying to achieve.

Thanks,
Bart
