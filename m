From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] HPA Detect From Resume
Date: Sun, 3 Jun 2007 00:24:24 +0200
Message-ID: <200706030024.24485.bzolnier@gmail.com>
References: <46456120.6070401@cs.drexel.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:26782 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762054AbXFBWPY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Jun 2007 18:15:24 -0400
Received: by ug-out-1314.google.com with SMTP id j3so469727ugf
        for <linux-ide@vger.kernel.org>; Sat, 02 Jun 2007 15:15:22 -0700 (PDT)
In-Reply-To: <46456120.6070401@cs.drexel.edu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lee Trager <lt73@cs.drexel.edu>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>


Hi,

On Saturday 12 May 2007, Lee Trager wrote:
> Currently when system which have HPA require HPA to be detected and
> disabled upon resume from RAM or disk. The current IDE drivers do not do
> this nor does libata(obviously it since it doesn't support HPA yet). I
> have implemented this into the current IDE drivers and it has been
> tested by many others since 7/15/2006 in bug number
> 6840(http://bugzilla.kernel.org/show_bug.cgi?id=6840) and it has been
> confirmed to work fine with no problems.

Big thanks for working on this bug.

The patch looks good, applied.

> --- linux-2.6.21.1-old/include/linux/ide.h	2007-05-01 02:54:12.000000000 -0400
> +++ linux-2.6.21.1/include/linux/ide.h	2007-04-28 01:06:20.000000000 -0400
> @@ -1005,6 +1005,7 @@
>  	int		(*probe)(ide_drive_t *);
>  	void		(*remove)(ide_drive_t *);
>  	void		(*shutdown)(ide_drive_t *);
> +	void		(*resume)(ide_drive_t *);
>  } ide_driver_t;

ide_driver_t changed a bit in 2.6.22 due to /proc/ide/ rework so this
chunk (and one chunk in ide-disk.c) rejected to apply.  Fixed them by hand.

> @@ -1279,7 +1281,12 @@
>  	rqpm.pm_step = ide_pm_state_start_resume;
>  	rqpm.pm_state = PM_EVENT_ON;
>  
> -	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
> +	err = ide_do_drive_cmd(drive, &rq, ide_head_wait);
> +
> +	if (err == 0 && drv->resume)
> +		drv->resume(drive);
> +

Added extra drv != NULL check (there may be no IDE device driver et all).
