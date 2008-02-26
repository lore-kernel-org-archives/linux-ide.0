From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC] Disk shock protection (revisited)
Date: Mon, 25 Feb 2008 19:02:28 -0500
Message-ID: <47C35714.4090604@garzik.org>
References: <87skzgd1zk.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46761 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757531AbYBZACa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 19:02:30 -0500
In-Reply-To: <87skzgd1zk.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Elias Oltmanns wrote:
> The general idea: A daemon running in user space monitors input data
> from an accelerometer. When the daemon detects a critical condition,
> i.e., a sudden acceleration (for instance, laptop slides off the desk),
> it signals the kernel so the hard disk may be put into a (more) safe
> state. To this end, the kernel has to issue an idle immediate command
> with unload feature and stop the block layer queue afterwards. Once the
> daemon tells us that the imminent danger is over, the most important
> task for the kernel is to restart the block layer queue. See below for
> more details.

Speaking specifically to that problem, it seems to me that you either 
want an mlock'd daemon, or just simply to keep everything in the kernel, 
for this specific solution.

You don't want, for example, to swap out other apps, swap in the daemon, 
in order to handle a sudden acceleration.

	Jeff


