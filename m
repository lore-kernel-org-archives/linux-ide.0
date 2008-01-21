From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Mon, 21 Jan 2008 13:02:56 +0000
Message-ID: <20080121130256.2443d7c1@lxorguk.ukuu.org.uk>
References: <200801140019.20668.g.chulkov@jacobs-university.de>
	<20080115025435.1e21b703.akpm@linux-foundation.org>
	<20080115113552.75731bf8@lxorguk.ukuu.org.uk>
	<4794501E.90306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53864 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751820AbYAUNFF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 08:05:05 -0500
In-Reply-To: <4794501E.90306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

> transmission failure as timeouts.  Of course, if we're ticking the timer
> while the command is not in flight, that's a bug.  If there are cases
> where 30 secs isn't enough, can you please point me to those reports?

I have been, in bugzilla - the raid failure example where old IDE
eventually reports a media error while libata keeps timing out,
resetting, repeating.

Alan
