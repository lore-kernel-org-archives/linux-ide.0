From: "Norman Diamond" <n0diamond@yahoo.co.jp>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Thu, 26 Feb 2009 20:56:38 +0900
Message-ID: <B2BE4BF16058416F88555755CB1823DF@DIAMOND8600>
References: <82AA7849DFA14958B6A74CB6ED0B591B@DIAMOND8600> <26917692A9574F3A9363ED5253B42D2F@DIAMOND8600> <49A570DB.8090401@rtr.ca> <200902252035.05347.bzolnier@gmail.com> <DF79A3D50A1548A2A22EEFD769318266@DIAMOND8600> <49A5C9A5.20005@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp06.mail.tnz.yahoo.co.jp ([203.216.246.69]:22447 "HELO
	smtp06.mail.tnz.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754436AbZBZL4z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Feb 2009 06:56:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Mark Lord wrote:
> Norman Diamond wrote:
>>
>> Meanwhile I also can't help wondering, if Mark Lord has patched
>> drivers/ide to make it work, why has he delayed submitting the patches?
>
> There's simply too much churn in drivers/ide for me to keep up with, and
> my patches won't apply to kernels from the past year.

OK!  For my present needs, a year-old kernel didn't need your patches.

This problem with 2.6.27.7 and 2.6.27.8 was solved by grading to 2.6.24.3.
Slax 6.0.3 came with configuration files for 2.6.24.3, I edited the
configuration to set CONFIG_IDE_TASK_IOCTL=y, and the result ran without
crashing -- today anyway.  It still needs more testing.

This kind of solution, fixing a problem by upgrading to an older version, is
something that we normally expect to pay for.  Usually we have to pay for
that kind of software every time we buy a PC.  I'm well aware that this one
came from volunteers, and I ought to contribute by finding where the bug was
introduced, but sorry, I don't have that kind of free time.

> Drivers/ide is on the way out FAST now, and any new systems that still use
> it are mostly based on older kernels, where patches like mine are
> inappropriate for maintenance point releases.

Some are old systems that need their own maintenance, their maintenance
ought to be accompanied by upgrading to newer kernels, and patches would be
very highly appropriate for maintenance point releases.

> Libata should be used for any new setup that doesn't have a strict legacy
> requirement now.

90% agreed.  However, I've read that libata will never support add-on IDE
boards. 

--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
