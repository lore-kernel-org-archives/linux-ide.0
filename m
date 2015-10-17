From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] libata: add support for NCQ commands for SG interface
Date: Sat, 17 Oct 2015 15:00:44 +0300
Message-ID: <5622386C.2000905@cogentembedded.com>
References: <1445082519-8160-1-git-send-email-vinayak.kale@seagate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33382 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbJQMAr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Oct 2015 08:00:47 -0400
Received: by lbbpp2 with SMTP id pp2so87472413lbb.0
        for <linux-ide@vger.kernel.org>; Sat, 17 Oct 2015 05:00:45 -0700 (PDT)
In-Reply-To: <1445082519-8160-1-git-send-email-vinayak.kale@seagate.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: vinayak.kale@gmail.com, tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>

Hello.

On 10/17/2015 2:48 PM, vinayak.kale@gmail.com wrote:

> From: Vinayak Kale <vinayak.kale@seagate.com>
>
> This patch is needed to make NCQ commands with FPDMA protocol value
> (eg READ/WRITE FPDMA) work over SCSI Generic (SG) interface.
>
> Signed-off-by: Vinayak Kale <vinayak.kale@seagate.com>
> ---
>   drivers/ata/libata-scsi.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 0d7f0da..5b0a5ab 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
[...]
> @@ -2963,7 +2965,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>   			tf->hob_lbal = cdb[7];
>   			tf->hob_lbam = cdb[9];
>   			tf->hob_lbah = cdb[11];
> -			tf->flags |= ATA_TFLAG_LBA48;
> +			tf->flags |= (ATA_TFLAG_LBA48 | ATA_TFLAG_LBA);

    Parens not needed here.

[...]

MBR, Sergei

