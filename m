From: Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH] Add support for SCT Write Same
Date: Thu, 9 Jun 2016 01:32:21 -0500
Message-ID: <CAJVOszDbtwOpd=OtitFOUpzHaSRTHZcrSJ9uU_r_+8eEgUXnzw@mail.gmail.com>
References: <1465235890-15703-1-git-send-email-shaun@tancheff.com>
 <1465235890-15703-2-git-send-email-shaun@tancheff.com> <yq1bn3bjait.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:4901 "EHLO
	mx0a-000cda01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1423278AbcFIGcm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jun 2016 02:32:42 -0400
Received: from pps.filterd (m0075029.ppops.net [127.0.0.1])
	by mx0b-00003501.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u596V1hx003291
	for <linux-ide@vger.kernel.org>; Thu, 9 Jun 2016 02:32:41 -0400
Received: from mail-yw0-f198.google.com (mail-yw0-f198.google.com [209.85.161.198])
	by mx0b-00003501.pphosted.com with ESMTP id 23f38rr02s-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Thu, 09 Jun 2016 02:32:41 -0400
Received: by mail-yw0-f198.google.com with SMTP id x189so71903555ywe.2
        for <linux-ide@vger.kernel.org>; Wed, 08 Jun 2016 23:32:40 -0700 (PDT)
In-Reply-To: <yq1bn3bjait.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

On Wed, Jun 8, 2016 at 10:39 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> >>>>> "Shaun" == Shaun Tancheff <shaun@tancheff.com> writes:
>
> Shaun,
>
> Shaun> SATA drives may support write same via SCT. This is useful for
> Shaun> setting the drive contents to a specific pattern (0's).
>
> index 428c03e..c5c8424 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -52,6 +52,7 @@
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pr.h>
> +#include <linux/ata.h>
>  #include <asm/uaccess.h>
>  #include <asm/unaligned.h>
>
> No ATA stuff in sd.c, please.
>
>
> @@ -2761,24 +2762,26 @@ static void sd_read_write_same(struct scsi_disk *sdkp, unsigned char *buffer)
>  {
>         struct scsi_device *sdev = sdkp->device;
>
> -       if (sdev->host->no_write_same) {
> -               sdev->no_write_same = 1;
> -
> -               return;
> -       }
> -
>         if (scsi_report_opcode(sdev, buffer, SD_BUF_SIZE, INQUIRY) < 0) {
> -               /* too large values might cause issues with arcmsr */
> -               int vpd_buf_len = 64;
> -
>                 sdev->no_report_opcodes = 1;
>
>                 /* Disable WRITE SAME if REPORT SUPPORTED OPERATION
>                  * CODES is unsupported and the device has an ATA
>                  * Information VPD page (SAT).
>                  */
>
> The above comment tells you how to enable WRITE SAME in libata's
> SCSI-ATA translation.
>
>
> -               if (!scsi_get_vpd_page(sdev, 0x89, buffer, vpd_buf_len))
> +               if (!scsi_get_vpd_page(sdev, 0x89, buffer, SD_BUF_SIZE))
>
> That vpd_buf_len is intentional.



Got it. Looking at it again all of hacking here is not required.
Posting a cleaner v2 without this.

Thanks!

>
>
> --
> Martin K. Petersen      Oracle Linux Engineering




-- 
Shaun Tancheff
