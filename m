From: Andre Tomt <andre@tomt.net>
Subject: Re: [PATCH, RFT, v2] sata_mv: convert to new EH
Date: Fri, 02 Mar 2007 01:54:52 +0100
Message-ID: <45E775DC.9080405@tomt.net>
References: <20070225233454.GA31282@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.skjellin.no ([80.239.42.67]:59362 "EHLO mx1.skjellin.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422688AbXCBB1G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Mar 2007 20:27:06 -0500
In-Reply-To: <20070225233454.GA31282@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>

Jeff Garzik wrote:
> Just got sata_mv working under the new EH, on my 6041.
>
> It probes and talks to disks just fine (chip doesn't support ATAPI),
> and hotplug actually has a chance of working.
>
> The 'mv-eh' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git mv-eh
>   

It's great to see this driver getting some more love. On a 6041 I'm 
seeing very bad behaviour when encountering errors using the 2.6.19 
driver. If a disk gets the fits, the port dies and 500000 interrupts/s 
gets fired until the server gets rebooted. Good thing it only pegs one 
of four available cpu cores.. I hope the new EH is more robust in this 
regard ;-)

Ramblings aside; I see there is a mv-ncq head in libata-dev.git, do you 
have it working? Is there a timeframe for NCQ support?
