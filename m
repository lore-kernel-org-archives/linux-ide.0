From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata total system lockup fix
Date: Fri, 19 Aug 2005 12:45:58 +0900
Message-ID: <430555F6.4090709@gmail.com>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com> <42FA70A9.6080608@pobox.com> <43052C03.7060306@pobox.com> <4305504B.7080201@gmail.com> <430553DB.5030807@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.205]:25420 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932259AbVHSDqG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Aug 2005 23:46:06 -0400
Received: by wproxy.gmail.com with SMTP id i2so525766wra
        for <linux-ide@vger.kernel.org>; Thu, 18 Aug 2005 20:46:06 -0700 (PDT)
In-Reply-To: <430553DB.5030807@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
> 
>>
>>  I've been trying to reproduce your lockup here, but haven't succeeded 
>> yet.  I'm currently doing multiple "while true; do cat /dev/sr0; 
>> done", bonnie, raw random IOs (latter two are to give some randomness 
>> to test condition).
> 
> 
> Gotta trigger the eh code to get lockups, and hard disks are
> so reliable by themselves that it just ain't gonna happen
> very often that way.

  Yeap, the sr0 is my SATA DVD+-RW/DL drive, and as no media is present, 
each cat results in EH handling leading to No medium found error.

> 
> My notebook has a DVD+-RW/DL drive, which the desktop (KDE) polls
> every second or so -- generates a libata error every time it does
> that with no disk in the drive.  But hours or days can go by before
> this produces the race that locks things up (and it NEVER locks up
> if I keep a disc in the drive).

  Okay, I'll keep my test running for longer.

> 
> However, I have had the machine lock up solid during suspend/resume (RAM)
> at least once in the past couple of days --> perhaps a command timeout
> on accessing the disk on resume (or suspend?) is aggrievating
> the situation.  No problems with the large "broken" fix,
> but the one-liner was just giving me too much grief.

  Hmmm, if the lockup only occurs w/ suspend/resume w/ one-liner.  The 
lockup could be a different problem.  I'll try to dig deeper.

> The laptop & I are off for a road trip for the next seven days or so,
> and it will be in constant daily use for presentations and stuff.
> So, no risky testing over the next week, sorry.

  Dang. :-p

-- 
tejun
