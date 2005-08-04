From: Doug Maxey <dwm@maxeymade.com>
Subject: Re: [PATCH 3/3] libata-dev: Fix pdc2027x ATAPI DMA lost irq problem
Date: Thu, 04 Aug 2005 13:41:09 -0500
Message-ID: <200508041841.j74If9fv027567@falcon30.maxeymade.com>
References: <42F252ED.8020206@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from falcon30.maxeymade.com ([24.173.215.190]:41400 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S262596AbVHDSrF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Aug 2005 14:47:05 -0400
In-reply-to: <42F252ED.8020206@tw.ibm.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

I suspect that Albert will not be able to reply for a few days, there 
seems to be an issue with the weather in Taiwan, as in, they may be 
hunkered down for a typhoon.

On Fri, 05 Aug 2005 01:39:57 +0800, Albert Lee wrote:
>Jeff,
>
>Patch 3/3: Fix pdc2027x ATAPI DMA lost irq problem
>
>Description:
>   Sometimes pdc2027x will lost irq after ATAPI DMA data transfer.
>   With the previous rule (cmd->request_bufflen % 256), the ATAPI DMA irq lost
>problem still occurs during the test.

Do you want to lash up the analyzer here in Austin?  I suspect this may be 
a manifestation of a READ CAPACITY issue.  It is legal for the device fw 
to report the lead-in, and lead-out blocks in the total, but you cannot 
actually access the blocks from the device.  The blocks reported by 
READ CAPACITY can be off by 3 to the high side.

>
>   Root cause for the irq lost is unknown. I've tried your ATAPI DMA alignment
>patch, but the problem still occurs, even the buffer is aligned. I guess it is pdc2027x hardware problem.
>
>   The following workarounds are adapted from the Promise pdc618 GPL driver.
>They seems know about the problem and has the workaround.
>
>Changes:
>   - Only turn on ATAPI DMA for READ, WRITE, READ_CD and READ_DVD_STRUCTURE commands.
>   - For WRITE_10, if LBA -45150 (FFFF4FA2h) to  -1 (FFFFFFFFh) then use PIO mode.
>

See above.

++doug

