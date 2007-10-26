From: Tejun Heo <htejun@gmail.com>
Subject: Re: seagate disks on sil3114 - slow?
Date: Fri, 26 Oct 2007 11:32:51 +0900
Message-ID: <472151D3.6060403@gmail.com>
References: <1192683290.5720.38.camel@localhost>	 <4716EA25.7060205@garzik.org> <1192697546.5720.51.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:49953 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbXJZCdA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 22:33:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so654502rvb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 19:33:00 -0700 (PDT)
In-Reply-To: <1192697546.5720.51.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Soeren Sonnenburg wrote:
> On Thu, 2007-10-18 at 01:07 -0400, Jeff Garzik wrote:
>> Soeren Sonnenburg wrote:
>>> Dear all,
>>>
>>> I just now realize that all disk i.o. on my machine is quite slow
>>> compared with the pata disks I had before. Furthermore I recognized that
>>> I only have seagates (ST3400832AS,ST3400620AS,ST3750640AS,ST3750640AS)
>>> connected to a sil3114 controller.
>>>
>>> Being on kernel 2.6.23.1 and stumbling across
>>> http://home-tj.org/wiki/index.php/Sil_m15w I am now wondering if this
>>> patch made it already in kernel (or when it will make it if it is not
>>> yet in/why never).
>> Are you sure you have a 3114?  the mod15write isn't applied to that chip.
>> Does your dmesg say "applying Seagate errata fix (mod15write workaround)" ?
> 
> At least lspci / dmesg indicates I have a 3114 ... but maybe the problem
> is something else. Is there a raw device speed, readonly benchmark to
> check whether things are as expected?

"dd if=/dev/sdX of=/dev/null bs=1M"?  Also, does changing IO scheduler
to deadline make any difference?

-- 
tejun
