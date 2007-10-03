From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] libata: change the last state of pio read to HSM_ST_IDLE
Date: Wed, 03 Oct 2007 14:16:14 -0400
Message-ID: <4703DC6E.8040204@garzik.org>
References: <468B5930.3070000@tw.ibm.com> <468B5B3D.6040805@tw.ibm.com> <4702616B.1000402@garzik.org> <470316FE.2000406@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59402 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758220AbXJCSQQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 14:16:16 -0400
In-Reply-To: <470316FE.2000406@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Jeff Garzik wrote:
>> Albert Lee wrote:
>>
>>> Patch 2/2:
>>>   After reading the last pio data block, the HSM is waiting for device
>>> to be idle, not waiting for the last interrupt.
>>>
>>> This patch changes the state after "PIO data-in" to HSM_ST_IDLE instead
>>> of HSM_ST_LAST for accuracy.
>>>
>>> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
>>
>> Is this still needed?
>>
> 
> Not quite needed; it only makes the state transition after reading the
> last PIO block more accurate.
> 
> However, if we want to do part of the irq PIO in the workqueue sometime
> in the future, this patch will be needed (otherwise the HSM might think
> it expecting another irq). For the time being, maybe we can just skip
> this patch until sometime it's really needed.

OK, thanks.

	Jeff



