From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Fwd: Re: Performance figure for sx8 driver
Date: Sun, 12 Jun 2005 23:39:25 -0400
Message-ID: <42ACFFED.9050701@pobox.com>
References: <20050611021814.riaatwh8ztskw4g4@www.nucleodyne.com>	 <42AC6310.7030809@rtr.ca> <1118598197.25250.20.camel@driver>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:60129 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261346AbVFMDja (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Jun 2005 23:39:30 -0400
In-Reply-To: <1118598197.25250.20.camel@driver>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kallol@nucleodyne.com
Cc: Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Kallol Biswas wrote:
> I have been investigating what the cause of performance loss could be.
> 
> I have noticed several things:
> 
> 0) Setting to CARM_MAX_Q to 30 hangs. So we have been testing only with
> CARM_MAX_Q == 1. The firmware has not been updated yet.

Note that CARM_MAX_Q controls the --host-- queue.

This means that, with CARM_MAX_Q==1, only one command can be sent to 
--any-- disk, at a time.  disks 1-7 must wait for disk 0 to complete an 
I/O, and so on.  Each command is host-synchronous.

As such, this limits multi-disk performance quite severely, but does not 
hamper single disk performance.

CARM_MAX_Q==1 is set as such (as mentioned earlier in the thread) 
because early firmwares would lock up if that value was increased.

It has been reported that newer firmwares work fine with CARM_MAX_Q==30, 
which completely eliminates the host-synchronous condition.

	Jeff


