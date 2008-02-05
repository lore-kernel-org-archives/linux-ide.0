From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 02/22] ide-tape: remove struct idetape_read_position_result_t
Date: Tue, 5 Feb 2008 02:23:17 +0100
Message-ID: <200802050223.18087.bzolnier@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com> <1202132440-26648-3-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:51905 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757459AbYBEBPL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 20:15:11 -0500
Received: by nf-out-0910.google.com with SMTP id g13so440463nfb.21
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 17:15:10 -0800 (PST)
In-Reply-To: <1202132440-26648-3-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 04 February 2008, Borislav Petkov wrote:
> There should be no functional changes resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-tape.c |   49 +++++++++++++++++------------------------------
>  1 files changed, 18 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 442d71c..c8c57ab 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c

[...]

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

I removed needless "!!" while merging the patch.
