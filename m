From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 28/32] ide-tape: shorten some function names
Date: Sun, 3 Feb 2008 01:12:59 +0100
Message-ID: <200802030112.59217.bzolnier@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com> <1201427300-3954-23-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:58001 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935324AbYBCAAP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 19:00:15 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1482832fga.17
        for <linux-ide@vger.kernel.org>; Sat, 02 Feb 2008 16:00:13 -0800 (PST)
In-Reply-To: <1201427300-3954-23-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Sunday 27 January 2008, Borislav Petkov wrote:
> From: Borislav Petkov <bbpetkov@yahoo.de>
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-tape.c |   29 +++++++++++++++--------------
>  1 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index f8a4b27..d4c4255 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c

[...]

> @@ -2290,10 +2290,10 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks, struct
>  }
>  
>  /*
> - *	idetape_insert_pipeline_into_queue is used to start servicing the
> + *	idetape_ins_ppl_into_queue is used to start servicing the
>   *	pipeline stages, starting from tape->next_stage.
>   */
> -static void idetape_insert_pipeline_into_queue (ide_drive_t *drive)
> +static void idetape_ins_ppl_into_queue(ide_drive_t *drive)

idetape_plug_pipeline?

Otherwise looks fine so please move it at the beginning of the series
and resubmit so I can apply it.

Thanks,
Bart
