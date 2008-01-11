From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 04/21] ide-floppy: cleanup and unify debugging macro calls
Date: Sat, 12 Jan 2008 00:56:20 +0100
Message-ID: <200801120056.21033.bzolnier@gmail.com>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-4-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-5-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:51508 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759242AbYALO0d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 09:26:33 -0500
Received: by ug-out-1314.google.com with SMTP id z38so610571ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 06:26:32 -0800 (PST)
In-Reply-To: <1200052699-28420-5-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 11 January 2008, Borislav Petkov wrote:
> * some debug_log() calls were not using "ide-floppy: " prefix
>=20
> * a few used printk levels different than KERN_INFO (KERN_NOTICE
>   and KERN_ERR, which is the default one if no level is given)
>=20
> There should be no functional change resulting from this patch.

Hmm, but there are functional changes as noted above, I removed this li=
ne
from the patch description.

> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---

with IDEFLOPPY_DEBUG_LOG set to 1:

drivers/ide/ide-floppy.c: In function =E2=80=98idefloppy_pc_intr=E2=80=99=
:
drivers/ide/ide-floppy.c:704: warning: too many arguments for format
drivers/ide/ide-floppy.c: In function =E2=80=98idefloppy_do_request=E2=80=
=99:
drivers/ide/ide-floppy.c:1126: error: =E2=80=98struct request=E2=80=99 =
has no member named =E2=80=98flags=E2=80=99
make[1]: *** [drivers/ide/ide-floppy.o] Error 1
make: *** [drivers/ide/ide-floppy.o] Error 2

which translate to:

[...]

>  		if ((stat & ERR_STAT) || test_bit(PC_DMA_ERROR, &pc->flags)) {
>  			/* Error detected */
> -			debug_log(KERN_INFO "ide-floppy: %s: I/O error\n",
> -				drive->name);
> +			debug_log("I/O error\n", drive->name);

"%s: I/O error\n"

[...]

> -	debug_log(KERN_INFO "dev: %s, flags: %lx, errors: %d\n",
> +	debug_log("dev: %s, flags: %lx, errors: %d\n",
>  			rq->rq_disk ? rq->rq_disk->disk_name : "?",
>  			rq->flags, rq->errors);

This was broken before this patch by rq->flags -> rq->cmd_type change
(so your patch is not to blame for breaking IDEFLOPPY_DEBUG_LOG ;).

I fixed the above issues while merging the patch.
