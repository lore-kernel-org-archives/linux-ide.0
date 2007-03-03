From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] libata: warn if speed limited due to 40-wire cable (v2)
Date: Sat, 03 Mar 2007 15:28:48 -0500
Message-ID: <45E9DA80.2080109@tmr.com>
References: <45DA44B4.6000209@shaw.ca>	<45E8B42E.7010900@garzik.org> <20070303005433.714d75ad@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tmr.com ([64.65.253.246]:56730 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932279AbXCCU1l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Mar 2007 15:27:41 -0500
In-Reply-To: <20070303005433.714d75ad@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Alan Cox wrote:
>> it seems broken to manipulate xfer_mask after returning from the 
>> driver's ->mode_filter hook.
>>
>> this patch is more than just a speed-limited warning printk, afaics
> 
> I actually suggested that order because the only way the printk can be
> done correctly is for it to be the very last test made. Since the mode
> filter is not told what mode will be used but just subtracts modes that
> are not allowed this should be safe.

Far better to have a drive which works slowly than one which works 
unreliably.

-- 
Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot
