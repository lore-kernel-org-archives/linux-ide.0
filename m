From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: SATL compliance for Inquiry Product Revision
Date: Thu, 1 May 2014 11:15:10 -0400
Message-ID: <20140501151510.GF31611@htj.dyndns.org>
References: <1398799524-5625-1-git-send-email-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:65271 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbaEAPPO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 May 2014 11:15:14 -0400
Received: by mail-qc0-f179.google.com with SMTP id x3so165985qcv.24
        for <linux-ide@vger.kernel.org>; Thu, 01 May 2014 08:15:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398799524-5625-1-git-send-email-keith.busch@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: linux-ide@vger.kernel.org

On Tue, Apr 29, 2014 at 01:25:24PM -0600, Keith Busch wrote:
> The SCSI/ATA Translation standard says to use data words 25 and 26 unless
> they are spaces. These words are generally more useful anway for devices
> that are not padding the firmware field with spaces.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Reviewed-by: Matthew Wilcox <matthew.r.wilcox@intel.com>
> ---
>  drivers/ata/libata-scsi.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index ef8567d..8034a38 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1993,7 +1993,10 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
>  	memcpy(rbuf, hdr, sizeof(hdr));
>  	memcpy(&rbuf[8], "ATA     ", 8);
>  	ata_id_string(args->id, &rbuf[16], ATA_ID_PROD, 16);
> -	ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
> +	if (args->id[25] == 0x2020 && args->id[26] == 0x2020)

Maybe strncmp(" ") is more readable?  And can you please add some
comment explaining what's going on?

> +		ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
> +	else
> +		ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV + 2, 4);

So, this would change the behavior for devices which were reporting
stuff in ATA_ID_FW_REV.  Prolly no biggiee.

Thanks.

-- 
tejun
