From: Doug Maxey <dwm@maxeymade.com>
Subject: Re: PATA drivers in libata?
Date: Sun, 13 Feb 2005 18:19:31 -0600
Message-ID: <200502140019.j1E0JV66028132@falcon30.maxeymade.com>
References: <420FCE4F.7010205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from falcon30.maxeymade.com ([24.173.215.190]:32393 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S261321AbVBNATh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Feb 2005 19:19:37 -0500
In-reply-to: <420FCE4F.7010205@pobox.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


On Sun, 13 Feb 2005 17:01:51 EST, Jeff Garzik wrote:
>Mark Hahn wrote:
>>>* With ATA passthru (in libata-dev currently), libata supports SMART and 
>>>the HDIO_CMD/HDIO_TASK generalized ioctls.  Should I care about 
>>>supporting other ioctls?
>> 
>> 
>> is there some other mechanism to en/disable write caching?
>
>Besides the SG_IO | HDIO_DRIVE_CMD | HDIO_DRIVE_TASK | 
>HDIO_DRIVE_TASKFILE ioctls?  Nope.
>
>	Jeff

One thing that I would hope for is the ability to recognize that a drive
may prefer the use of write cache be set by the drive, defaulting to off,
and not have to come back later and turn it off.  Certain drives destined
to be used in server class machines will be coming that way.

++doug


