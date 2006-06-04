From: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.17-rc5-mm2+ahci resume] NULL pointer dereference in
 cfq_dispatch_requests
Date: Sat, 3 Jun 2006 18:41:34 -0700
Message-ID: <20060603184134.ee6dcc3b.akpm@osdl.org>
References: <4482389F.6030403@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:48102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751259AbWFDBll (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Jun 2006 21:41:41 -0400
In-Reply-To: <4482389F.6030403@goop.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, linux-ide@vger.kernel.org

On Sat, 03 Jun 2006 18:34:23 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

>     BUG: unable to handle kernel NULL pointer dereference at virtual
>     address 00000054
> 
> in cfq_dispatch_requests+0x2c5/0x454.
> 
> I'm running 2.6.17-rc5-mm2 with Forrest Zhao's ahci resume patches of 
> the other day.
> 
> The system was basically idle with very little IO going on.  It happens 
> fairly regularly, but not triggered by any particular activity.  The 
> system had not been through a suspend/resume cycle.

There have been a number of CFQ fixes post-2.6.17-rc5-mm2.  Fingers
crossed, please test -mm3.  Hopefully I'll have that out 4-6 hours hence.


