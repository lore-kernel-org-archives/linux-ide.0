From: Lee Trager <lt73@cs.drexel.edu>
Subject: Re: [PATCH] HPA Detect From Resume
Date: Tue, 05 Jun 2007 04:55:43 -0400
Message-ID: <4665250F.9080000@cs.drexel.edu>
References: <46456120.6070401@cs.drexel.edu> <200706030024.24485.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pm2.irt.drexel.edu ([144.118.29.82]:34750 "EHLO
	smtp.mail.drexel.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762694AbXFEI5n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jun 2007 04:57:43 -0400
In-Reply-To: <200706030024.24485.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Bartlomiej Zolnierkiewicz wrote:
> Hi,
>
> On Saturday 12 May 2007, Lee Trager wrote:
>   
>> Currently when system which have HPA require HPA to be detected and
>> disabled upon resume from RAM or disk. The current IDE drivers do not do
>> this nor does libata(obviously it since it doesn't support HPA yet). I
>> have implemented this into the current IDE drivers and it has been
>> tested by many others since 7/15/2006 in bug number
>> 6840(http://bugzilla.kernel.org/show_bug.cgi?id=6840) and it has been
>> confirmed to work fine with no problems.
>>     
>
> Big thanks for working on this bug.
>
> The patch looks good, applied.
>
>   
>> --- linux-2.6.21.1-old/include/linux/ide.h	2007-05-01 02:54:12.000000000 -0400
>> +++ linux-2.6.21.1/include/linux/ide.h	2007-04-28 01:06:20.000000000 -0400
>> @@ -1005,6 +1005,7 @@
>>  	int		(*probe)(ide_drive_t *);
>>  	void		(*remove)(ide_drive_t *);
>>  	void		(*shutdown)(ide_drive_t *);
>> +	void		(*resume)(ide_drive_t *);
>>  } ide_driver_t;
>>     
>
> ide_driver_t changed a bit in 2.6.22 due to /proc/ide/ rework so this
> chunk (and one chunk in ide-disk.c) rejected to apply.  Fixed them by hand.
>
>   
>> @@ -1279,7 +1281,12 @@
>>  	rqpm.pm_step = ide_pm_state_start_resume;
>>  	rqpm.pm_state = PM_EVENT_ON;
>>  
>> -	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
>> +	err = ide_do_drive_cmd(drive, &rq, ide_head_wait);
>> +
>> +	if (err == 0 && drv->resume)
>> +		drv->resume(drive);
>> +
>>     
>
> Added extra drv != NULL check (there may be no IDE device driver et all).
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
Thanks for cleaning it up I've been really busy lately. I just
downloaded 2.6.22-rc3  and the patch still wasn't in there will it be in
rc4 or is there something else I need to do? Also a few weeks ago I
tested the HPA patch for libata and the same issue comes up. I'll look
into releasing another patch for libata once its in the kernel and I
have more time.

Lee
