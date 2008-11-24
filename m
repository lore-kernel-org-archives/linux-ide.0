From: starlight@binnacle.cx
Subject: Re: unexpected downspeed of AHCI controller on Intel
  Seaburg 5400
Date: Mon, 24 Nov 2008 00:32:54 -0500
Message-ID: <6.2.5.6.2.20081124002812.01ca7788@binnacle.cx>
References: <6.2.5.6.2.20081118154009.01c8a2d0@binnacle.cx>
 <4923743A.2050903@shaw.ca>
 <6.2.5.6.2.20081118210621.01d6c680@binnacle.cx>
 <492A3912.3060305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx.binnacle.cx ([74.95.187.105]:34049 "EHLO mx.binnacle.cx"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbYKXFhe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Nov 2008 00:37:34 -0500
In-Reply-To: <492A3912.3060305@kernel.org>
References: <6.2.5.6.2.20081118154009.01c8a2d0@binnacle.cx>
 <4923743A.2050903@shaw.ca>
 <6.2.5.6.2.20081118210621.01d6c680@binnacle.cx>
 <492A3912.3060305@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Thank you for explaining how it works.  Have resigned to living 
with 1.5G.  A reason exists to run the ES.2s at their full 
sequential 100 Mbytes/sec (800 Mbits/sec), and I had hoped that 
lowering the latency on the link might squeeze a bit more 
performance.  But 1.5 is good enough.



At 14:18 11/24/2008 +0900, Tejun Heo wrote:
>starlight@binnacle.cx wrote:
>> Is it possible for the BIOS to tell the chip to not negogiate 
>> above 1.5 Gbps?  I'm wondering if HP might have done this to 
>> prevent the bug below from happening.  If so it would be
>> nice for the driver to put it back to 3 Gbps.
>
>The standard way to put that limit is to use SControl but it isn't doing
>that, as far as ahci is concerned, it's free to negotiate any speed but
>is negotiating 1.5Gbps.  Maybe they capped using some hidden register to
>workaround the erratum.  At any rate, it doesn't really matter unless
>you're gonna hang multiple devices to a single port using PMP.
>
>Thanks.
>
>-- 
>tejun

