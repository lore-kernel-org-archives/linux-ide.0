From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide-tape: change IDE_AFLAG_IGNORE_DSC non-atomically
Date: Tue, 2 Jun 2009 12:18:33 +0200
Message-ID: <200906021218.33787.bzolnier@gmail.com>
References: <1243926308-32385-1-git-send-email-petkovbb@gmail.com> <1243926308-32385-2-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:40735 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbZFBKOD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jun 2009 06:14:03 -0400
In-Reply-To: <1243926308-32385-2-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Tuesday 02 June 2009 09:05:07 Borislav Petkov wrote:
> There are two sites where the flag is being changed: ide_retry_pc
> and idetape_do_request. Both codepaths are protected by hwif->busy
> (ide_lock_port) and therefore we shouldn't need the atomic accesses. The
> only problem would be the compiler reordering the accesses, therefore the
> optimization barrier.
> 
> Spotted-by: Jiri Slaby <jirislaby@gmail.com>
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

[...]

> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -656,15 +656,24 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
>  
>  	if ((drive->dev_flags & IDE_DFLAG_DSC_OVERLAP) == 0 &&
>  	    (rq->cmd[13] & REQ_IDETAPE_PC2) == 0)
> -		set_bit(IDE_AFLAG_IGNORE_DSC, &drive->atapi_flags);
> +		drive->atapi_flags |= IDE_AFLAG_IGNORE_DSC;
>  
>  	if (drive->dev_flags & IDE_DFLAG_POST_RESET) {
> -		set_bit(IDE_AFLAG_IGNORE_DSC, &drive->atapi_flags);
> +		drive->atapi_flags |= IDE_AFLAG_IGNORE_DSC;
>  		drive->dev_flags &= ~IDE_DFLAG_POST_RESET;
>  	}
>  
> -	if (!test_and_clear_bit(IDE_AFLAG_IGNORE_DSC, &drive->atapi_flags) &&
> -	    (stat & ATA_DSC) == 0) {
> +	/*
> +	 * This is a precaution for IDE_AFLAG_IGNORE_DSC being conditionally set
> +	 * above. We don't need a stronger enforcement of ordering because the
> +	 * read below cannot precede the earlier write out-of-order since it is
> +	 * to the same location. Also, since we have the ide port locked during
> +	 * the ->do_request(), we only have to be aware of gcc reordering stuff.
> +	 */
> +	barrier();

Are you seeing a real problem with gcc here?  No sane compiler should need
a barrier() here (we would probably need zillions of them in kernel if it
really does).
