From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFT][PATCH] ide-disk.c: more write cache fixes
Date: Fri, 14 May 2004 01:28:37 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A404A5.8070500@keyaccess.nl>
References: <200405132116.44201.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpq3.home.nl ([213.51.128.198]:48013 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S265237AbUEMXaS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 May 2004 19:30:18 -0400
In-Reply-To: <200405132116.44201.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>, "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>, Jens Axboe <axboe@suse.de>

Bartlomiej Zolnierkiewicz wrote:

> Comments, suggestions, complains?

Yes, this works to stop it from complaining (on 6Y120P0). It comes up 
with write cache enabled, and hdparm -W0/-W1 work to disable/enable 
write cache as evidenced by the tiobench results. Not as evidenced by 
/proc/ide/hda/settings (drive->wcache) which is always 1 and which will 
probably confuse more users than just me -- I believe I saw hdparm just 
pushes a drive command through an ioctl?

Question though:

> @@ -1678,8 +1683,12 @@ static void idedisk_setup (ide_drive_t *
>  #endif	/* CONFIG_IDEDISK_MULTI_MODE */
>  	}
>  	drive->no_io_32bit = id->dword_io ? 1 : 0;
> -	if (drive->id->cfs_enable_2 & 0x3000)
> -		write_cache(drive, (id->cfs_enable_2 & 0x3000));
> +
> +	/* write cache enabled? */
> +	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
> +		drive->wcache = 1;
> +
> +	write_cache(drive, 1);

write_cache() also sets drive->wcache (to the argument, 1 in this case) 
and you call that unconditionally, so the "if (foo) drive->wcache = 1" 
seems superfluous. If the idea indeed is to unconditionally enable write 
cache, it seems just

write_cache(drive, 1);

would be equivalent. Or if that wasn't the intention, maybe:

if (foo)
	write_cache(drive, 1);

or if it should in fact be disabled if (!foo):

write_cache(drive, (id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)));

or ...

Ignore me if I completely missed the point, just looks odd.

Rene.
