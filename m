From: Andreas Werner <andreas.werner@men.de>
Subject: Re: libata-core: devslp fails on ATP mSATA
Date: Thu, 3 Dec 2015 17:05:10 +0100
Message-ID: <20151203160508.GH10207@awelinux>
References: <20151201092234.GB29791@awelinux>
 <20151201161715.GA12922@mtj.duckdns.org>
 <20151201190410.GA21252@mtj.duckdns.org>
 <20151202093310.GE10207@awelinux>
 <20151202164753.GA19878@mtj.duckdns.org>
 <20151203093355.GF10207@awelinux>
 <20151203151549.GD27463@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.150]:32024 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752294AbbLCQHI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2015 11:07:08 -0500
Content-Disposition: inline
In-Reply-To: <20151203151549.GD27463@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andreas Werner <andreas.werner@men.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>, "Martin K. Petersen" <martin.petersen@oracle.com>

On Thu, Dec 03, 2015 at 10:15:49AM -0500, Tejun Heo wrote:
> Hello,
> 
> On Thu, Dec 03, 2015 at 10:33:55AM +0100, Andreas Werner wrote:
> > All the other "flag" fields in the structs are used and/or reserved
> > and it seems to be no good place for such flags.
> 
> You can use the port flags - ATA_FLAG_*.
> 
> > What I am thinking about is.
> > 
> > 1. Add new flag e.g. ATA_HORKAGE_NOLOG_PAGE_RD
> 
> ATA_FLAG_NO_LOG_PAGE?

That seems to be much more simpler than my idea :-)
Did not see the port stuff, i was focused on the host struct.

Thank you for the hint. I will prepare a Patch next week.

> 
> Thanks.
> 
> -- 
> tejun

Regards
Andy
