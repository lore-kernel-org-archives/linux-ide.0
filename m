From: Tejun Heo <htejun@gmail.com>
Subject: Re: TASKFILE ioctl for libata?
Date: Thu, 16 Feb 2006 18:30:04 +0900
Message-ID: <43F4461C.1080501@gmail.com>
References: <20060215143439.GA17850@harddisk-recovery.com> <43F37A5E.1090301@rtr.ca> <20060216005643.GA28396@harddisk-recovery.com> <43F3E17E.1090701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.194]:64398 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751251AbWBPJaW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Feb 2006 04:30:22 -0500
Received: by xproxy.gmail.com with SMTP id i30so41070wxd
        for <linux-ide@vger.kernel.org>; Thu, 16 Feb 2006 01:30:21 -0800 (PST)
In-Reply-To: <43F3E17E.1090701@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Erik Mouw wrote:
> 
>> On Wed, Feb 15, 2006 at 02:00:46PM -0500, Mark Lord wrote:
>>
>>> Erik Mouw wrote:
>>>
>>>> Hdparm (6.3) needs the TASKFILE ioctl for the ATA security feature set
>>>> (security freeze, security unlock, etc.). I can't find it in Jeff's
>>>> libata-dev tree, is there somebody already working on it? Or is there a
>>>> workaround?
>>>
>>>
>>> If that ioctl is missing in libata, then I'll have to convert hdparm
>>> to use SGIO to submit ATA Passthru packets instead for libata devices.
>>
>>
>>
>> If SGIO can be used for ATA Passthru, then why are the HDIO_DRIVE_CMD
>> and HDIO_DRIVE_TASK ioctl()s implemented in libata? AFAICS, the same
>> functionality can be accomplished through SGIO ATA Passthru.
> 
> 
> For compatibility :)  The HDIO compat ioctls are implemented internally 
> via the ATA passthru SCSI command.
> 
> Although in general I resist adding compat ioctls, I think avoiding 
> TASKFILE when we have TASK/CMD ioctls would be inconsistent.  If 
> somebody wants to submit a tested patch...
> 

Hello.

Just a side note.  Taskfile has finer granuality regarding which 
registers are written and read back than current libata does and IDE 
taskfile implementation is somewhat broken/weird in a few delicate fun 
ways, so... be careful.  Whoever tries it.

-- 
tejun
