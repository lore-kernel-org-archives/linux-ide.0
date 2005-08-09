From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/3] libata-dev: Convert pdc2027x from PIO to MMIO
Date: Tue, 09 Aug 2005 19:04:43 +0800
Message-ID: <42F88DCB.9070407@tw.ibm.com>
References: <42F24DBE.0@tw.ibm.com> <42F25114.1050009@tw.ibm.com> <42F26F1F.8010903@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:28139 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S932514AbVHILFl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Aug 2005 07:05:41 -0400
In-Reply-To: <42F26F1F.8010903@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>



Hi,

> 
> 
>> +    cgcr = readl(port_mmio(ap, PDC_GLOBAL_CTL));
> 
> 
> I've read that read[bwl]() and write[bwl]() are deprecated and 
> discouraged in new code and instead ioread{8,16,32}() and 
> iowrite{8,16,32}() should be used.  Is this the case?
> 
> BR

   I've read Linux Device Drivers 3rd Edition, it does say readx() and writex()
are deprecated. However, other libata drivers use readx() and writex(); and
io_read_x() and io_write_x() are not available on older kernel, say, 2.6.5.

So, I'm not sure. Maybe later Jeff will need all libata drivers to use
new io_read_x() and io_write_x() API?


Albert



