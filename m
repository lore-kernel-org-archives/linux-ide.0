From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3] libata-dev: Fix pdc2027x ATAPI DMA lost irq problem
Date: Wed, 10 Aug 2005 23:05:43 -0400
Message-ID: <42FAC087.2000800@pobox.com>
References: <42F24DBE.0@tw.ibm.com> <42F252ED.8020206@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:60834 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932233AbVHKDFq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Aug 2005 23:05:46 -0400
In-Reply-To: <42F252ED.8020206@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Albert Lee wrote:
> Jeff,
> 
> Patch 3/3: Fix pdc2027x ATAPI DMA lost irq problem
> 
> Description:
>   Sometimes pdc2027x will lost irq after ATAPI DMA data transfer.
>   With the previous rule (cmd->request_bufflen % 256), the ATAPI DMA irq 
> lost
> problem still occurs during the test.
> 
>   Root cause for the irq lost is unknown. I've tried your ATAPI DMA 
> alignment
> patch, but the problem still occurs, even the buffer is aligned. I guess 
> it is pdc2027x hardware problem.
> 
>   The following workarounds are adapted from the Promise pdc618 GPL driver.
> They seems know about the problem and has the workaround.

I think this needs to be investigated a bit more, but the pdc618 driver 
does it, we may need to do this eventually.

	Jeff



