From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 10/32] ide-tape: remove struct idetape_read_position_result_t
Date: Sun, 27 Jan 2008 20:43:12 +0100
Message-ID: <200801272043.12270.bzolnier@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com> <1201427300-3954-5-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:9274 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756497AbYA0Tc2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:28 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1431368fga.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:27 -0800 (PST)
In-Reply-To: <1201427300-3954-5-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Sunday 27 January 2008, Borislav Petkov wrote:
> From: Borislav Petkov <bbpetkov@yahoo.de>
> 
> There should be no functional changes resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-tape.c |   49 +++++++++++++++++------------------------------
>  1 files changed, 18 insertions(+), 31 deletions(-)

[...]
  
> -static ide_startstop_t idetape_read_position_callback (ide_drive_t *drive)
> +static ide_startstop_t idetape_read_position_callback(ide_drive_t *drive)
>  {
>  	idetape_tape_t *tape = drive->driver_data;
> -	idetape_read_position_result_t *result;
> +	u8 *readpos = tape->pc->buffer;
>  
>  	debug_log(DBG_PROCS, "Enter %s\n", __func__);
>  
>  	if (!tape->pc->error) {
> -		result = (idetape_read_position_result_t *) tape->pc->buffer;
> -		debug_log(DBG_SENSE, "BOP - %s\n", result->bop ? "Yes" : "No");
> -		debug_log(DBG_SENSE, "EOP - %s\n", result->eop ? "Yes" : "No");
> +		debug_log(DBG_SENSE, "BOP - %s\n",
> +				!!(readpos[0] & 0x80) ? "Yes" : "No");
> +		debug_log(DBG_SENSE, "EOP - %s\n",
> +				!!(readpos[0] & 0x40) ? "Yes" : "No");
> +
> +		if (!!(readpos[0] & 0x4)) {
> +			printk(KERN_INFO "ide-tape: Block location is unknown"
> +					"to the tape\n");

all "!!" above are unnecessary

Otherwise is fine but depends on patch #7 so I couldn't merge it
(please move this patch near the beginning of the series).

Thanks,
Bart
