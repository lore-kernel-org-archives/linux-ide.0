From: Kallol Biswas <kallol@nucleodyne.com>
Subject: Re: Fwd: Re: Performance figure for sx8 driver
Date: 12 Jun 2005 10:43:17 -0700
Message-ID: <1118598197.25250.20.camel@driver>
References: <20050611021814.riaatwh8ztskw4g4@www.nucleodyne.com>
	 <42AC6310.7030809@rtr.ca>
Reply-To: kallol@nucleodyne.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc14.comcast.net ([204.127.202.59]:26781 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262266AbVFLRnI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Jun 2005 13:43:08 -0400
In-Reply-To: <42AC6310.7030809@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

I have been investigating what the cause of performance loss could be.

I have noticed several things:

0) Setting to CARM_MAX_Q to 30 hangs. So we have been testing only with
CARM_MAX_Q == 1. The firmware has not been updated yet.

1) If we keep on increasing number of SATA disks, hdparm does not get
multiplied total read performance (hdparm -t ....).

With a Maxtor 60 GB disk with 8MB cache we get 50Mb/sec. If we put
two disks we get 35 on each. Total  70MB/sec. If we put more
then total does not get above 70MB/sec.

It  looks like that a part of the driver serializes the commands.
We have a 32 processor MIPS based system.

2) It looks like that there is while(1) loop under spinlock in isr
stack. If we start queuing many commands then it may take a while for
this loop to break. Though I am not quite familiar with the driver yet.

If we set CARM_MAX_Q to 30 then the request/response queue length should
also be increased right?

3)  Next I will put PCI-X analyzer and figure  out the root cause of
performance loss. May be need to get hold of the technical manual.

Kallol

On Sun, 2005-06-12 at 09:30, Mark Lord wrote:
> kallol@nucleodyne.com wrote:
> > 
> > 
> > Hello Jeff,
> >            How did you verify that performance improved making the
> > changes those
> > you suggested?
> > 
> > hdparm does not show it.
> 
> My hdparm tool performs a single I/O at a time,
> disregarding any kernel read-ahead that may be added on.
> 
> As such, it won't often show the effects of queued commands
> as well as some other test might.
> 
> Cheers
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

