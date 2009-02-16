From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Mon, 16 Feb 2009 16:30:40 -0500
Message-ID: <20090216163040.194f5389@dhcp-100-2-144.bos.redhat.com>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>
	<49922A2D.508@kernel.org>
	<49924F48.4000009@rtr.ca>
	<20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com>
	<49934B20.4060206@rtr.ca>
	<49934D24.1050204@garzik.org>
	<49935157.6020002@rtr.ca>
	<20090211175409.4fb27541@dhcp-100-2-144.bos.redhat.com>
	<49944A13.3050105@rtr.ca>
	<49944AA9.8040308@rtr.ca>
	<4998D9B8.9020309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:55898 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbZBPVd1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Feb 2009 16:33:27 -0500
In-Reply-To: <4998D9B8.9020309@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Mon, 16 Feb 2009 12:12:56 +0900
Tejun Heo <tj@kernel.org> wrote:


> > 
> > Mmm.. I think it is the SD_TIMEOUT value, defined in drivers/scsi/sd.h
> > which currently uses (30 * HZ) as the timeout for most things,
> > including for cache flushes.
> > 
> > Try changing it to (180 * HZ) just for fun.
> 
> Yeap, SD_TIMEOUT should be it.  But I've never personally seen disk
> flushing taking as long as 30 seconds.  Does it really happen?  It's
> not like the drive would be doing random seeking.  One full stroke
> across the platter should be it.  Even with the rotational delay,
> going over 30 seconds doesn't seem very likely.

I just noticed that the other drive, a Western Digital, was using 1.5Gbps
instead of 3.0. So I forced the Samsung to the slower speed and now I
can't make the timeout happen anymore.
