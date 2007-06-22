From: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [RFT] hpt366: reset DMA state machine on timeouts
Date: Fri, 22 Jun 2007 10:13:59 -0500
Message-ID: <20070622151359.GD8840@austin.ibm.com>
References: <200706212154.47398.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:58100 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756347AbXFVPOB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jun 2007 11:14:01 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5MFE0vb014722
	for <linux-ide@vger.kernel.org>; Fri, 22 Jun 2007 11:14:00 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5MFDxLG037834
	for <linux-ide@vger.kernel.org>; Fri, 22 Jun 2007 09:14:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5MFDxno017209
	for <linux-ide@vger.kernel.org>; Fri, 22 Jun 2007 09:13:59 -0600
Content-Disposition: inline
In-Reply-To: <200706212154.47398.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thu, Jun 21, 2007 at 09:54:47PM +0400, Sergei Shtylyov wrote:
> Reset HPT36x's DMA state machine on a DMA timeout the way it's done for HPT370.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Linas, here's what I've come up with -- this should apply against 2.6.21.y.
> Compile-tested only, not for merging.
> 
>  drivers/ide/pci/hpt366.c |   24 +++++++++++++++++++++++-

This worked great!  The patch is good. But it raises another interesting
issue, one of those akpm ZFS "voilates boundaries" isses.

However.. When raid goes to reconstruct the partition, I get one
of the Drive Ready Seek Complete etc. messages.  Your handler recovers 
from it (I put in a printk to verify this). And so these printk's
try to get logged into /var/log/messages ... which trigger more 
errors. At a very high rate ... sometimes hundreds a second, sometimes
less.  The system remains usable, but at one point, it hit 60% cpu usage
spewing these messages to the screen.  

I'd like to see several things.

1) This patch should go in.  It converts a system that hangs into
   one that doesn't hang.

2) There needs to be a way of failing the disk when there's a high
   number of errors. e.g. if there are more than 100 errors per minute
   then the disk needs to be marked "failed" in the raid array.

   Note it should be stopped only if the rate is high: if there is 
   only 1 error per minte, this might be very annoying, but acceptable,
   esp. if one is just trying to copy data off the disk.
   
   I'm not sure what to do if this had been the only disk in the system.
   Maybe if the eror reate exceed 100/minute, then dma is turned off 
   permanently?

--linas
