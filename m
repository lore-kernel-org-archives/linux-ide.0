From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
Date: Sun, 02 Jul 2006 10:36:41 +0200
Message-ID: <44A78599.9060405@free.fr>
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org> <449E5445.60008@free.fr> <44A4CE21.30009@tw.ibm.com> <1151654134.44a4d8f6dc320@imp5-g19.free.fr> <44A4E01D.8020604@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:8405 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750796AbWGBIgo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Jul 2006 04:36:44 -0400
In-Reply-To: <44A4E01D.8020604@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com, Linux Kernel <linux-kernel@vger.kernel.org>, Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>

Hi Albert,

Albert Lee wrote:
> castet.matthieu@free.fr wrote:
> 
>>
>>>Could you please test the current libata-upstream tree and
>>>turn on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h.
>>>
>>
>>Is there a easy way to get libata-upstream tree ?
>>Do I need to install git for that or there are some snapshots somewhere ?
>>
>>
> 
> 
> Hi Matthieu,
> 
> Tejun has a patch against 2.6.17:
> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625-1.tar.bz2
> 
I don't know if I did someting wrong, but it didn't apply cleanly.
So I enable the trace on lastest -mm kernel and I disable the via quirk.

But the printk in the interrupt handler takes some times and hides the 
altstatus delay.

I will try to send you a trace, where I move the printk at the end of 
the interrupt handler.


Matthieu


