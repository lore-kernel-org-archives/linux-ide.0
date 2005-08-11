From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/3] libata-dev: Convert pdc2027x from PIO to MMIO
Date: Wed, 10 Aug 2005 22:37:36 -0400
Message-ID: <42FAB9F0.9080103@pobox.com>
References: <42F24DBE.0@tw.ibm.com> <42F25114.1050009@tw.ibm.com> <42F26F1F.8010903@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:43426 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932233AbVHKChq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2005 22:37:46 -0400
In-Reply-To: <42F26F1F.8010903@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Brett Russ wrote:
> Albert Lee wrote:
> 
>> +    cgcr = readl(port_mmio(ap, PDC_GLOBAL_CTL));
> 
> 
> I've read that read[bwl]() and write[bwl]() are deprecated and 
> discouraged in new code and instead ioread{8,16,32}() and 
> iowrite{8,16,32}() should be used.  Is this the case?

ioread/write should only be used when the code in question may have to 
use either readl() or inl().

When a driver is written for hardware that is -always- used in MMIO 
mode, then readl() is preferred, since its faster.

	Jeff



