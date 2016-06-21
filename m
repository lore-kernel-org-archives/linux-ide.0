From: Damien Le Moal <Damien.LeMoal@hgst.com>
Subject: Re: [PATCH 6/6] ata: Handle ATA NCQ NO-DATA commands correctly
Date: Tue, 21 Jun 2016 01:14:16 +0000
Message-ID: <BL2PR04MB19695E8BEB29F30450498FE79F2B0@BL2PR04MB1969.namprd04.prod.outlook.com>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
 <1466422756-126637-7-git-send-email-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:57641 "EHLO
	esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbcFUGNm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jun 2016 02:13:42 -0400
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Hannes Reinecke <hare@suse.com>


Hannes,

On 6/20/16 20:41, Hannes Reinecke wrote:
> Add a new taskfile protocol ATA_PROT_NCQ_NODATA to handle
> ATA NCQ NO-DATA commands correctly.
> And fixup ata_scsi_zbc_out_xlat() to use it.
>
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/libata-eh.c       | 3 ++-
>  drivers/ata/libata-scsi.c     | 5 ++++-
>  drivers/ata/sata_dwc_460ex.c  | 2 ++
>  include/linux/ata.h           | 1 +
>  include/linux/libata.h        | 2 ++
>  include/trace/events/libata.h | 1 +
>  6 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 5688b86..d551378 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2611,7 +2611,8 @@ static void ata_eh_link_report(struct ata_link *link)
>  				[ATA_PROT_NODATA]	= "nodata",
>  				[ATA_PROT_PIO]		= "pio",
>  				[ATA_PROT_DMA]		= "dma",
> -				[ATA_PROT_NCQ]		= "ncq",
> +				[ATA_PROT_NCQ]		= "ncq dma",
> +				[ATA_PROT_NCQ_NODATA]	= "ncq nodata",
>  				[ATAPI_PROT_NODATA]	= "nodata",
>  				[ATAPI_PROT_PIO]	= "pio",
>  				[ATAPI_PROT_DMA]	= "dma",
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 94bcd76..d80840c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3077,6 +3077,9 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>  		goto invalid_fld;
>  	}
>
> +	if (ata_is_ncq(tf->protocol) && (cdb[2] & 0x3) == 0)
> +		tf->protocol = ATA_PROT_NCQ_NODATA;
> +
>  	/* enable LBA */
>  	tf->flags |= ATA_TFLAG_LBA;
>
> @@ -3537,7 +3540,7 @@ static unsigned int ata_scsi_zbc_out_xlat(struct ata_queued_cmd *qc)
>
>  	if (ata_ncq_enabled(qc->dev) &&
>  	    ata_fpdma_zac_mgmt_out_supported(qc->dev)) {
> -		tf->protocol = ATA_PROT_NCQ;
> +		tf->protocol = ATA_PROT_NCQ_NODATA;
>  		tf->command = ATA_CMD_NCQ_NON_DATA;
>  		tf->hob_nsect = ATA_SUBCMD_NCQ_NON_DATA_ZAC_MGMT_OUT;
>  		tf->nsect = qc->tag << 3;

While you are at it, ATA_SUBCMD_NCQ_NON_DATA_ZAC_MGMT_OUT should go into 
tf->feature, not tf->hob_nsect. And you can also remove the "&0x1" mask 
of reset_all in the non-NCQ version of the command below that code (see 
the patch I sent a while ago togetner with the report of the NCQ NON 
DATA command problem.

Thanks !

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Group, HGST Research,
HGST, a Western Digital company
Damien.LeMoal@hgst.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.

