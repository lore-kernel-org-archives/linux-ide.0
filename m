From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.21-rc1 1/2] sata_vsc: factor the error and normal
 intr	paths into separate routines
Date: Fri, 23 Feb 2007 17:24:06 -0500
Message-ID: <45DF6986.9040408@garzik.org>
References: <20070221175354.21231.15372.stgit@dwillia2-linux.ch.intel.com> <20070221175646.21231.90731.stgit@dwillia2-linux.ch.intel.com> <45DE68D2.4010306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49876 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933239AbXBWWYL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 17:24:11 -0500
In-Reply-To: <45DE68D2.4010306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

Tejun Heo wrote:
> Sorry to keep nagging about patch separation and your way could be okay
> too, but IMHO this can be done better in one of the following ways.
> 
> 1. Keep two patches.  One to break down the interrupt handler the other
> to improve it.  In this case the first one shouldn't introduce major new
> features but just focus on breaking down existing one.
> 
> 2. Do it in single patch.  It seems the changes are localized enough.
> Just name it something like 'reimplement irq handler' and list changes
> in the commit message.
> 
> After seeing the change, I'm leaning toward #2.  Thanks.  :-)


These two sata_vsc changes should be done in a single patch.  "add new 
stuff" and "use new stuff" patches can be combined.  The types of 
patches that normally should be separated are logical changes like 
"clean up irq handling" or "improve EH", changes that can be 
git-bisect'd usefully.

The changes look OK to me.

	Jeff


