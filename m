From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [KERNEL 2.6.26-rc4]  bugreport : pata_pcmcia with Sandisk Extreme
 III 8GB
Date: Sat, 14 Jun 2008 03:20:41 -0400
Message-ID: <48537149.4040102@garzik.org>
References: <20080528225049.9a134e0d.Kristoffer.Ericson@Gmail.com>	<20080528222740.GB20893@isilmar.linta.de>	<20080530135728.be02d3dc.Kristoffer.Ericson@Gmail.com>	<20080607223716.7d142072.komurojun-mbn@nifty.com>	<20080611072029.GB28692@comet.dominikbrodowski.net> <20080614120055.ad8fbee0.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54128 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbYFNHUv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jun 2008 03:20:51 -0400
In-Reply-To: <20080614120055.ad8fbee0.komurojun-mbn@nifty.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: Tejun Heo <htejun@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, jgarzik@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pcmcia <linux-pcmcia@lists.infradead.org>, Kristoffer Ericson <kristoffer.ericson@gmail.com>

Komuro wrote:
> Dear Tejun
> 
>>>>>> pcmcia: registering new device pcmcia1.1
>>>>>> 1.1: GetNextTuple: No more items
>>>>>> pata_pcmcia: probe of 1.1 failed with error -12
> 
> The patch "libata: kill hotplug related race condition"
> introduced the pata_pcmcia error.
> 
> Please fix this problem.
> 
> 
> Best Regards
> Komuro
> 
>>> f046519fc85a8fdf6a058b4ac9d897cdee6f3e52 is first bad commit
> commit f046519fc85a8fdf6a058b4ac9d897cdee6f3e52
> Author: Tejun Heo <htejun@gmail.com>
> Date:   Mon May 19 01:15:08 2008 +0900
> 
>     libata: kill hotplug related race condition
>     
>     Originally, whole reset processing was done while the port is frozen
>     and SError was cleared during @postreset().  This had two race
>     conditions.  1: hotplug could occur after reset but before SError is
>     cleared and libata won't know about it.  2: hotplug could occur after
>     all the reset is complete but before the port is thawed.  As all
>     events are cleared on thaw, the hotplug event would be lost.

Interesting!  Thanks for the diagnosis...

	Jeff



