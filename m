Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95D2C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 30 Dec 2021 05:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhL3FNg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Dec 2021 00:13:36 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:58487 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229886AbhL3FNf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Dec 2021 00:13:35 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JPbyl52zzz1RtVc
        for <linux-ide@vger.kernel.org>; Wed, 29 Dec 2021 21:13:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640841215; x=1643433216; bh=XXEsmPA72t9kXOrOsYJuSOwTNsvNENAtu9f
        kYST9X+Q=; b=oLnGXbAWUqekJnMA4wIFBZjNtG7g7fomw6/lVeskqA4eiSIQCzu
        15a0KpSXBtJumjp0Qm8oEd+clwDTDO3wtGOKA3A3/BlkhrfwqYj5Ej/MtU/2peUJ
        1RKHmxgEvOHLOq8RAbBYr/WKDSubHMUQbXxsz0ll2AdGYghdrD/2P1FVyxz8ZJj6
        E/agFdU85/ZlozLdmntKYqyxyyr4PS5m0L7cF8KqjO+fhe7qPj6FSibDq8oYqb5k
        03liqDEePhxJ55qC68PrW2sIh/KcQORXTbtX0FVoL90mOX6KKQfc/BtC5Njj5wBI
        CwvsOjUMdyvzIgHBUbgUgO3ma9pCnlhaEuQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dBsxEox4NJIi for <linux-ide@vger.kernel.org>;
        Wed, 29 Dec 2021 21:13:35 -0800 (PST)
Received: from [10.225.163.41] (unknown [10.225.163.41])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JPbyl0KM8z1RtVG;
        Wed, 29 Dec 2021 21:13:34 -0800 (PST)
Message-ID: <d5f0a836-b6b6-b7a2-bb8b-5e99e788913f@opensource.wdc.com>
Date:   Thu, 30 Dec 2021 14:13:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 65/68] libata-scsi: rework ata_dump_status to avoid using
 pr_cont()
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org
References: <20211221072131.46673-1-hare@suse.de>
 <20211221072131.46673-66-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211221072131.46673-66-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/21/21 16:21, Hannes Reinecke wrote:
> pr_cont() has the problem that individual calls will be disrupted
> under high load, causing each call to end up on a single line and
> thereby mangling the output.
> So rework ata_dump_status() to have just one call to ata_port_warn()
> and avoid this problem.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libata-scsi.c | 49 ++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 11fb046e3035..d72852ac9ca3 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -678,37 +678,32 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
>   *	LOCKING:
>   *	inherited from caller
>   */
> -static void ata_dump_status(unsigned id, struct ata_taskfile *tf)
> +static void ata_dump_status(struct ata_port *ap, struct ata_taskfile *tf)

You forgot to fix the kdoc comments, which caused a compile warning with
W=1. Fixed that.

>  {
>  	u8 stat = tf->command, err = tf->feature;
>  
> -	pr_warn("ata%u: status=0x%02x { ", id, stat);
>  	if (stat & ATA_BUSY) {
> -		pr_cont("Busy }\n");	/* Data is not valid in this case */
> +		ata_port_warn(ap, "status=0x%02x {Busy} ", stat);
>  	} else {
> -		if (stat & ATA_DRDY)	pr_cont("DriveReady ");
> -		if (stat & ATA_DF)	pr_cont("DeviceFault ");
> -		if (stat & ATA_DSC)	pr_cont("SeekComplete ");
> -		if (stat & ATA_DRQ)	pr_cont("DataRequest ");
> -		if (stat & ATA_CORR)	pr_cont("CorrectedError ");
> -		if (stat & ATA_SENSE)	pr_cont("Sense ");
> -		if (stat & ATA_ERR)	pr_cont("Error ");
> -		pr_cont("}\n");
> -
> -		if (err) {
> -			pr_warn("ata%u: error=0x%02x { ", id, err);
> -			if (err & ATA_ABORTED)	pr_cont("DriveStatusError ");
> -			if (err & ATA_ICRC) {
> -				if (err & ATA_ABORTED)
> -						pr_cont("BadCRC ");
> -				else		pr_cont("Sector ");
> -			}
> -			if (err & ATA_UNC)	pr_cont("UncorrectableError ");
> -			if (err & ATA_IDNF)	pr_cont("SectorIdNotFound ");
> -			if (err & ATA_TRK0NF)	pr_cont("TrackZeroNotFound ");
> -			if (err & ATA_AMNF)	pr_cont("AddrMarkNotFound ");
> -			pr_cont("}\n");
> -		}
> +		ata_port_warn(ap, "status=0x%02x { %s%s%s%s%s%s%s} ", stat,
> +			      stat & ATA_DRDY ? "DriveReady " : "",
> +			      stat & ATA_DF ? "DeviceFault " : "",
> +			      stat & ATA_DSC ? "SeekComplete " : "",
> +			      stat & ATA_DRQ ? "DataRequest " : "",
> +			      stat & ATA_CORR ? "CorrectedError " : "",
> +			      stat & ATA_SENSE ? "Sense " : "",
> +			      stat & ATA_ERR ? "Error " : "");
> +		if (err)
> +			ata_port_warn(ap, "error=0x%02x {%s%s%s%s%s%s", err,
> +				      err & ATA_ABORTED ?
> +				      "DriveStatusError " : "",
> +				      err & ATA_ICRC ?
> +				      (err & ATA_ABORTED ?
> +				       "BadCRC " : "Sector ") : "",
> +				      err & ATA_UNC ? "UncorrectableError " : "",
> +				      err & ATA_IDNF ? "SectorIdNotFound " : "",
> +				      err & ATA_TRK0NF ? "TrackZeroNotFound " : "",
> +				      err & ATA_AMNF ? "AddrMarkNotFound " : "");
>  	}
>  }
>  
> @@ -1662,7 +1657,7 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  		cmd->result = SAM_STAT_GOOD;
>  
>  	if (need_sense && !ap->ops->error_handler)
> -		ata_dump_status(ap->print_id, &qc->result_tf);
> +		ata_dump_status(ap, &qc->result_tf);
>  
>  	ata_qc_done(qc);
>  }


-- 
Damien Le Moal
Western Digital Research
