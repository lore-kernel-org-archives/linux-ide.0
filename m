Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A50C433EF
	for <linux-ide@archiver.kernel.org>; Mon, 27 Sep 2021 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A477560F24
	for <linux-ide@archiver.kernel.org>; Mon, 27 Sep 2021 08:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhI0I6P (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Sep 2021 04:58:15 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:49215 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233574AbhI0I6O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 27 Sep 2021 04:58:14 -0400
Received: from [192.168.0.3] (ip5f5aef58.dynamic.kabel-deutschland.de [95.90.239.88])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9E6C261E5FE00;
        Mon, 27 Sep 2021 10:56:34 +0200 (CEST)
Subject: Re: [PATCH] libata: fix checking of DMA state
To:     =?UTF-8?Q?Reimar_D=c3=b6ffinger?= <Reimar.Doeffinger@gmx.de>
References: <DM6PR04MB7081AB7034F116CDFBA43890E7FF9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210819081340.4362-1-Reimar.Doeffinger@gmx.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <3850840f-ea01-a297-9347-55e8b5bac221@molgen.mpg.de>
Date:   Mon, 27 Sep 2021 10:56:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210819081340.4362-1-Reimar.Doeffinger@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear Reimar,


Thank you for the patch.


Am 19.08.21 um 10:13 schrieb Reimar Döffinger:

Maybe start with a problem statement:

With some SSDs Linux logs the error below:

     failed to set xfermode (err_mask=0x40)

> Checking if DMA is enabled should be done via the
> ata_dma_enabled helper function, since the init state
> 0xff indicates disabled.
> Only the libata-core logic is tested on actual devices,
> the other changes are based on code review only.

Your Signed-off-by line is missing, and you might want to add the Linux 
kernel bug tracker entry:

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=195895

> ---
> Changes to previous version:
> - removed initialization change for SATA. I got confused by the
>    ping-pong between libata-eh and libata-core and thought SATA did not
>    set up xfermode
> - reviewed other cases that used dma_mode in boolean context and those
>    seemed to need changing as well, so added them to patch.
>    I did not see any places that would set dma_mode to 0 ever, so I
>    do think they were all indeed wrong.
> 
>   drivers/ata/libata-core.c  | 2 +-
>   drivers/ata/libata-scsi.c  | 4 ++--
>   drivers/ata/pata_ali.c     | 2 +-
>   drivers/ata/pata_optidma.c | 4 ++--
>   drivers/ata/pata_radisys.c | 2 +-
>   5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 9934f6c465f4..52469b39d424 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2004,7 +2004,7 @@ unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>   
>   retry:
>   	ata_tf_init(dev, &tf);
> -	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&
> +	if (ata_dma_enabled(dev) && ata_id_has_read_log_dma_ext(dev->id) &&
>   	    !(dev->horkage & ATA_HORKAGE_NO_DMA_LOG)) {
>   		tf.command = ATA_CMD_READ_LOG_DMA_EXT;
>   		tf.protocol = ATA_PROT_DMA;
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index b9588c52815d..9e51251161e9 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3023,7 +3023,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>   	ata_qc_set_pc_nbytes(qc);
>   
>   	/* We may not issue DMA commands if no DMA mode is set */
> -	if (tf->protocol == ATA_PROT_DMA && dev->dma_mode == 0) {
> +	if (tf->protocol == ATA_PROT_DMA && !ata_dma_enabled(dev)) {
>   		fp = 1;
>   		goto invalid_fld;
>   	}
> @@ -3173,7 +3173,7 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
>   	u8 unmap = cdb[1] & 0x8;
>   
>   	/* we may not issue DMA commands if no DMA mode is set */
> -	if (unlikely(!dev->dma_mode))
> +	if (unlikely(!ata_dma_enabled(dev)))
>   		goto invalid_opcode;
>   
>   	/*
> diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
> index 557ecf466102..28b56811306f 100644
> --- a/drivers/ata/pata_ali.c
> +++ b/drivers/ata/pata_ali.c
> @@ -215,7 +215,7 @@ static void ali_set_piomode(struct ata_port *ap, struct ata_device *adev)
>   		struct ata_timing p;
>   		ata_timing_compute(pair, pair->pio_mode, &p, T, 1);
>   		ata_timing_merge(&p, &t, &t, ATA_TIMING_SETUP|ATA_TIMING_8BIT);
> -		if (pair->dma_mode) {
> +		if (ata_dma_enabled(pair)) {
>   			ata_timing_compute(pair, pair->dma_mode, &p, T, 1);
>   			ata_timing_merge(&p, &t, &t, ATA_TIMING_SETUP|ATA_TIMING_8BIT);
>   		}
> diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
> index f6278d9de348..ad1090b90e52 100644
> --- a/drivers/ata/pata_optidma.c
> +++ b/drivers/ata/pata_optidma.c
> @@ -153,7 +153,7 @@ static void optidma_mode_setup(struct ata_port *ap, struct ata_device *adev, u8
>   	if (pair) {
>   		u8 pair_addr;
>   		/* Hardware constraint */
> -		if (pair->dma_mode)
> +		if (ata_dma_enabled(pair))
>   			pair_addr = 0;
>   		else
>   			pair_addr = addr_timing[pci_clock][pair->pio_mode - XFER_PIO_0];
> @@ -301,7 +301,7 @@ static u8 optidma_make_bits43(struct ata_device *adev)
>   	};
>   	if (!ata_dev_enabled(adev))
>   		return 0;
> -	if (adev->dma_mode)
> +	if (ata_dma_enabled(adev))
>   		return adev->dma_mode - XFER_MW_DMA_0;
>   	return bits43[adev->pio_mode - XFER_PIO_0];
>   }
> diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
> index 8fde4a86401b..626b14f0f2ea 100644
> --- a/drivers/ata/pata_radisys.c
> +++ b/drivers/ata/pata_radisys.c
> @@ -173,7 +173,7 @@ static unsigned int radisys_qc_issue(struct ata_queued_cmd *qc)
>   	if (adev != ap->private_data) {
>   		/* UDMA timing is not shared */
>   		if (adev->dma_mode < XFER_UDMA_0) {
> -			if (adev->dma_mode)
> +			if (ata_dma_enabled(adev))
>   				radisys_set_dmamode(ap, adev);
>   			else if (adev->pio_mode)
>   				radisys_set_piomode(ap, adev);
> 

I am sorry, it took me so long to test this.

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>

(MSI B350M MORTAR with a M.2 Crucial MX500 SSD (SATA/AHCI, 
CT1000MX500SSD4, M3CR020))


Kind regards,

Paul
