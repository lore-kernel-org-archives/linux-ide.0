From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-scsi: do non-atomic pc->flags testing
Date: Tue, 12 Feb 2008 21:17:14 +0100
Message-ID: <200802122117.14156.bzolnier@gmail.com>
References: <1202718880-1793-1-git-send-email-petkovbb@gmail.com> <200802121328.48515.bzolnier@gmail.com> <20080212152550.GE4530@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:3168 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbYBLVZx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 16:25:53 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1507333nfb.21
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 13:25:51 -0800 (PST)
In-Reply-To: <20080212152550.GE4530@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 12 February 2008, Borislav Petkov wrote:
> commit 272976f0f5754707f9e41da315717a6eb8d9d536
> Author: Borislav Petkov <petkovbb@gmail.com>
> Date:   Tue Feb 12 16:22:44 2008 +0100
> 
>     ide-scsi: do non-atomic pc->flags testing
> 
>     Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> 
> diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
> index 5ec421c..eb84cdc 100644
> --- a/drivers/scsi/ide-scsi.c
> +++ b/drivers/scsi/ide-scsi.c
> @@ -319,8 +319,10 @@ static int idescsi_end_request (ide_drive_t *drive, int uptodate, int nrsecs)
>  		pc = opc;
>  		rq = pc->rq;
>  		pc->scsi_cmd->result = (CHECK_CONDITION << 1) |
> -					((test_bit(PC_TIMEDOUT, &pc->flags)?DID_TIME_OUT:DID_OK) << 16);
> -	} else if (test_bit(PC_TIMEDOUT, &pc->flags)) {
> +					(((pc->flags & PC_TIMEDOUT) ?
> +							  DID_TIME_OUT :
> +							  DID_OK) << 16);
> +	} else if (pc->flags & PC_TIMEDOUT) {

How's about renaming flag defines to PC_FLAG_* at the same time
(like it was done for other ATAPI drivers)?

Otherwise looks good.
