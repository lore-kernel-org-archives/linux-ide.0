From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
Date: Wed, 12 Oct 2005 11:49:12 -0400
Message-ID: <434D3078.50205@pobox.com>
References: <43146CC3.4010005@gentoo.org>	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com> <434D2DF1.9070709@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:8677 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964784AbVJLPtS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2005 11:49:18 -0400
In-Reply-To: <434D2DF1.9070709@gentoo.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Daniel Drake wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>> I would prefer /proc/via
>> to vanish because it complicates driver needlessly (could you do
>> this in separate patch?).
> 
> 
> I'm working on a user-space app to provide the same info. It's nearly 
> there but lacking some timing info.
> 
> Do you have any suggestions for how I can compute the value of via_clock 
> in userspace? (i.e. some equivalent of system_bus_clock())

A sysfs read-only attribute, associated with the PCI device?

Of course, procfs sure seems a whole lot easier some days...

	Jeff


