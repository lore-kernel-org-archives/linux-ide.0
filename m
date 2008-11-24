From: Tejun Heo <tj@kernel.org>
Subject: Re: unexpected downspeed of AHCI controller on Intel     Seaburg
 5400
Date: Mon, 24 Nov 2008 14:18:10 +0900
Message-ID: <492A3912.3060305@kernel.org>
References: <6.2.5.6.2.20081118154009.01c8a2d0@binnacle.cx> <4923743A.2050903@shaw.ca> <6.2.5.6.2.20081118210621.01d6c680@binnacle.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45001 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbYKXFSQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Nov 2008 00:18:16 -0500
In-Reply-To: <6.2.5.6.2.20081118210621.01d6c680@binnacle.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: starlight@binnacle.cx
Cc: linux-ide@vger.kernel.org

starlight@binnacle.cx wrote:
> Is it possible for the BIOS to tell the chip to not negogiate 
> above 1.5 Gbps?  I'm wondering if HP might have done this to 
> prevent the bug below from happening.  If so it would be
> nice for the driver to put it back to 3 Gbps.

The standard way to put that limit is to use SControl but it isn't doing
that, as far as ahci is concerned, it's free to negotiate any speed but
is negotiating 1.5Gbps.  Maybe they capped using some hidden register to
workaround the erratum.  At any rate, it doesn't really matter unless
you're gonna hang multiple devices to a single port using PMP.

Thanks.

-- 
tejun
