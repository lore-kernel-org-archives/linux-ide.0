From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Why is NCQ enabled by default by libata? (2.6.20)
Date: Tue, 27 Mar 2007 01:59:21 -0400
Message-ID: <4608B2B9.7090503@garzik.org>
References: <Pine.LNX.4.64.0703241232580.11608@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33172 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934057AbXC0F7X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Mar 2007 01:59:23 -0400
In-Reply-To: <Pine.LNX.4.64.0703241232580.11608@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Justin Piszcz wrote:
> Without NCQ, performance is MUCH better on almost every operation, with 
> the exception of 2-3 items.

Variables to take into account:

* the drive (NCQ performance wildly varies)
* the IO scheduler
* the filesystem (if not measuring direct to blkdev)
* application workload (or in your case, benchmark tool)
	* in particular, the threaded-ness of the apps

For the overwhelming majority of combinations, NCQ should not /hurt/ 
performance.

For the majority of combinations, NCQ helps (though it may not be often 
that you use more than 4-8 tags).

In some cases, NCQ firmware may be broken.  There is a Maxtor firmware 
id, and some Hitachi ids that people are leaning towards recommending be 
added to the libata 'horkage' list.

	Jeff


