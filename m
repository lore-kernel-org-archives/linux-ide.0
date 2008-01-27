From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/32] ide-tape: remove struct idetape_request_sense_result_t
Date: Sun, 27 Jan 2008 16:19:05 +0100
Message-ID: <200801271619.06013.bzolnier@gmail.com>
References: <1201423312-2460-1-git-send-email-bbpetkov@yahoo.de> <1201423312-2460-4-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:32581 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbYA0TcM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:12 -0500
Received: by fk-out-0910.google.com with SMTP id z23so893143fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:11 -0800 (PST)
In-Reply-To: <1201423312-2460-4-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 27 January 2008, Borislav Petkov wrote:
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-tape.c |   83 +++++++++++++++--------------------------------
>  1 files changed, 27 insertions(+), 56 deletions(-)

applied with minor changes

> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 3bedeb8..173ac0d 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c

[...]

>  	/*
> -	 * If error was the result of a zero-length read or write command,
> -	 * with sense key=5, asc=0x22, ascq=0, let it slide.  Some drives
> -	 * (i.e. Seagate STT3401A Travan) don't support 0-length read/writes.
> +	 * If error was the result of a zero-length read or write command, with
> +	 * sense key=5, asc=0x22, ascq=0, let it slide.  Some drives (i.e.
> +	 * Seagate STT3401A Travan) don't support 0-length read/writes.
>  	 */

This chunk is unnecessary, I dropped it.

>  	if ((pc->c[0] == IDETAPE_READ_CMD || pc->c[0] == IDETAPE_WRITE_CMD)
> -	    && pc->c[4] == 0 && pc->c[3] == 0 && pc->c[2] == 0) { /* length==0 */
> -		if (result->sense_key == 5) {
> +		/* length==0 */
> +		&& pc->c[4] == 0 && pc->c[3] == 0 && pc->c[2] == 0) {
> +		if (tape->sense_key == 5) {
>  			/* don't report an error, everything's ok */
>  			pc->error = 0;
>  			/* don't retry read/write */
>  			set_bit(PC_ABORT, &pc->flags);
>  		}
>  	}
> -	if (pc->c[0] == IDETAPE_READ_CMD && result->filemark) {
> +	if (pc->c[0] == IDETAPE_READ_CMD && !!(sense[2] & 0x80)) {

needless "!!" removed

>  		pc->error = IDETAPE_ERROR_FILEMARK;
>  		set_bit(PC_ABORT, &pc->flags);
>  	}
>  	if (pc->c[0] == IDETAPE_WRITE_CMD) {
> -		if (result->eom ||
> -		    (result->sense_key == 0xd && result->asc == 0x0 &&
> -		     result->ascq == 0x2)) {
> +		if (!!(sense[2] & 0x40) ||

ditto
