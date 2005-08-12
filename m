From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/3] libata-dev: pdc2027x fixes
Date: Fri, 12 Aug 2005 03:37:31 -0400
Message-ID: <42FC51BB.2050401@pobox.com>
References: <42FC4B36.9080805@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:43690 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751154AbVHLHhk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Aug 2005 03:37:40 -0400
In-Reply-To: <42FC4B36.9080805@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Jeff,
> 
> pdc2027x driver fix:
> 
> 1/3 pdc1.diff:
>     - Convert pdc2027x from PIO to MMIO.
> 
> 2/3 pdc2.diff:
>    - use "long" for the counter data type instead of "unsigned long"
> 
> 3/3 pdc3.diff:
>    - pdc2027x ATAPI DMA irq lost problem workaround

Applied all three patches to pdc2027x branch of libata-dev.git.

I continue to dislike patch #3, but without more info, I fear this 
workaround may be necessary.

	Jeff



