From: Mark Lord <liml@rtr.ca>
Subject: Re: libata total system lockup fix
Date: Thu, 18 Aug 2005 23:36:59 -0400
Message-ID: <430553DB.5030807@rtr.ca>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com> <42FA70A9.6080608@pobox.com> <43052C03.7060306@pobox.com> <4305504B.7080201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:24205 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932258AbVHSDg4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 23:36:56 -0400
In-Reply-To: <4305504B.7080201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
>
>  I've been trying to reproduce your lockup here, but haven't succeeded 
> yet.  I'm currently doing multiple "while true; do cat /dev/sr0; done", 
> bonnie, raw random IOs (latter two are to give some randomness to test 
> condition).

Gotta trigger the eh code to get lockups, and hard disks are
so reliable by themselves that it just ain't gonna happen
very often that way.

My notebook has a DVD+-RW/DL drive, which the desktop (KDE) polls
every second or so -- generates a libata error every time it does
that with no disk in the drive.  But hours or days can go by before
this produces the race that locks things up (and it NEVER locks up
if I keep a disc in the drive).

However, I have had the machine lock up solid during suspend/resume (RAM)
at least once in the past couple of days --> perhaps a command timeout
on accessing the disk on resume (or suspend?) is aggrievating
the situation.  No problems with the large "broken" fix,
but the one-liner was just giving me too much grief.

The laptop & I are off for a road trip for the next seven days or so,
and it will be in constant daily use for presentations and stuff.
So, no risky testing over the next week, sorry.

Cheers!
