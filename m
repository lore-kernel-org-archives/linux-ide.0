From: Tejun Heo <htejun@gmail.com>
Subject: Re: SIL3512 lockup problem using driver verion 0.9 and Linux 2.6.14
Date: Tue, 12 Dec 2006 10:21:17 +0900
Message-ID: <457E040D.2020707@gmail.com>
References: <74342.74582.qm@web52304.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:53934 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750819AbWLLBVY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 20:21:24 -0500
Received: by nz-out-0102.google.com with SMTP id s1so904869nze
        for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 17:21:24 -0800 (PST)
In-Reply-To: <74342.74582.qm@web52304.mail.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steve Graham <stgraham2000@yahoo.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

Steve Graham wrote:
> My name is Steve Graham and I work for a small
> startup.  Our company is developing a server board
> with the Silicon Images 3512 and we are getting some
> strange lockups during high levels of disk activity. 
> The test I'm currently running to cause the problem is
> to run the following concurrently: 'nbench',
> 'tiobench', and an 'scp' of a 200Meg file to the sata
> drive.  Every so often I will get the following
> message:
> 
> ata1: status=0x51 { DriveReady SeekComplete Error }
>   ata1: error=0x04 { DriveStatusError }

Which kernel version are you running?

> This doesn't mean the drive is locked up and doesn't
> appear to have any side effects on its own but
> eventually I will get the above message that is
> immediately followed by the next block of messages
> that do result in a lockup:
> 
> ata1: command 0x35 timeout, stat 0xd1 host_stat 0x1
>   ata1: status=0xd1 { Busy }
>   sd 0:0:0:0: SCSI error: return code = 0x8000002
>   sda: Current: sense key=0xb
>       ASC=0x47 ASCQ=0x0
>   end_request: I/O error, dev sda, sector 17033103
>   ata1: Abnormal status 0xD1 on port 0xC001E087
>   ata1: Alternate status 0xD1 on port 0xC001E08A
>   ata1: Error 0xd1
>   ata1: Abnormal status 0xD1 on port 0xC001E087
>   ata1: Alternate status 0xD1 on port 0xC001E08A
>   ata1: Error 0xd1
>   ata1: Abnormal status 0xD1 on port 0xC001E087
>   ata1: Alternate status 0xD1 on port 0xC001E08A

This is message from old error handling and doesn't really contain much
useful info.  Even if you have to use previous kernel in production
system, providing error messages from 2.6.19 will help chasing down the
cause.

-- 
tejun
