From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.23-rc7 - _random_ IRQ23 : nobody cared
Date: Thu, 27 Sep 2007 09:55:22 +0900
Message-ID: <46FAFF7A.5070208@gmail.com>
References: <20070924083336.7a08fd61@tux.DEF.witbe.net>	<46F7C933.4080003@davidnewall.com> <20070925090057.5778aa2a@tux.DEF.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:12399 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbXI0ETT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 00:19:19 -0400
Received: by rv-out-0910.google.com with SMTP id k20so2202052rvb
        for <linux-ide@vger.kernel.org>; Wed, 26 Sep 2007 21:19:19 -0700 (PDT)
In-Reply-To: <20070925090057.5778aa2a@tux.DEF.witbe.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Rolland <rol@as2917.net>
Cc: David Newall <david@davidnewall.com>, Linux Kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, rol@witbe.net

Paul Rolland wrote:
> Hi David,
> 
> On Mon, 24 Sep 2007 23:56:59 +0930
> David Newall <david@davidnewall.com> wrote:
> 
>> Paul Rolland "(???????) wrote:
>>> Hell, IRQ 23 is shared between libata and my modem !!!
>>>   
>> Tried using the modem?
> 
> When no problem is reported, both the libata part and the modem are OK.
> When the problem is reported, at that time, only libata is handling IRQ23
> (the modem is a WinModem, and the driver is an out-kernel module), this 
> is still kernel boot time, and the disabling of the IRQ makes my machine
> unable to complete the boot process (too many disk timeout).
> 
> It could be good to be able to delay the disabling of an IRQ something long
> enough to allow all the modules to be loaded...

Can you change driver load order such that the driver for the modem is
loaded first?

-- 
tejun

