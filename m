From: Tejun Heo <htejun@gmail.com>
Subject: Re: Promise SATA TX4 300 port timeout with sata_promise in 2.6.22,
 kernel panic in 2.6.23
Date: Mon, 12 Nov 2007 21:01:38 +0900
Message-ID: <473840A2.5090909@gmail.com>
References: <200711121025.lACAPf3S017955@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.227]:54453 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449AbXKLMBr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 07:01:47 -0500
Received: by qb-out-0506.google.com with SMTP id e11so2485952qbe
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 04:01:46 -0800 (PST)
In-Reply-To: <200711121025.lACAPf3S017955@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: i.d.stratford@gmail.com, linux-ide@vger.kernel.org

Hello,

Mikael Pettersson wrote:
>> Also, if 3Gbps can't be made reliable on those controllers, how about
>> limiting it to 1.5Gbps by default with appropriate warning messages?
>> Without PMP, it's not like we're gonna earn anything by driving the
>> thing at 3Gbps.
> 
> There are two things going on here:
> 
> First, a workaround for a HW erratum affecting 2nd-generation
> chips like the SATA300 TX4 was included in kernel 2.6.24-rc2.
> Outstanding bug reports for 2nd-generation chips in older kernels
> are not unlikely to be related to this erratum, so we should not
> butcher the driver because of issues reported against old kernels.

Alright, if it's fixable, no problem.  I just wanted to remind that
running the link at 3Gbps isn't worth if it continues to cause problems.

> Secondly, Stratford's system is seriously overloaded:
> - a desktop mainboard
> - worked with 6 mainboard and 8 Promise 150 TX4 ports
> - problems began when two Promise 300 TX4 cards and
>   more disks were added
> On several occasions we've traced people's problems to
> overtaxed system components (cooling, PSU, PCI busses).

Agreed, I've seen my share of those issues.  Especially, SATA links seem
very dependent on power quality and very weird things happen when the
power isn't good enough.  Easy way to debug this is connect half of the
drives to a separate PSU and see what happens.

Thanks.

-- 
tejun
