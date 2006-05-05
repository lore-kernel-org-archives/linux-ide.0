From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: Problem with disk
Date: Fri, 5 May 2006 19:49:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44.0605051939120.13704-100000@coffee.psychology.mcmaster.ca>
References: <44590DAC.6010107@emc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:43489 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S1750786AbWEEXtr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 May 2006 19:49:47 -0400
In-Reply-To: <44590DAC.6010107@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David.Ronis@McGill.CA
Cc: linux-ide@vger.kernel.org

> >I notice from hdparm that disk write caching is turned on.  Any chance
> >that there is a problem with the cache not being flushed before powering
> >down?

pretty unlikly.  linux normally offlines the drive before halting.

> I would suggest that you should run with the write cache disabled unless 
> you can verify working barrier support.

this is true, but extremely conservative/paranoid.  it makes a lot 
of sense if you're handling banking transactions or if you really
see a lot of abrupt power-offs (yank the battery).  what are the chances
of a drive failing to write dirty blocks when idle, halting?

don't get me wrong: write barriers are A Good Thing.  just that Linux 
survived very nicely for many years before such things were bothered with.

> The fact that your drive reports IO errors is also worrying - you might 
> just have a bad drive...  You can look at drive help with tools like 
> smartctl.

IO errors trump any concerns for write barriers - there's no need to 
even think about barriers or cache settings if the disk is, for instance,
reporting media errors...

