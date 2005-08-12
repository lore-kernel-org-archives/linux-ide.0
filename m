From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 3/3] libata-dev: pdc2027x ATAPI DMA lost irq problem workaround
Date: Fri, 12 Aug 2005 16:20:05 +0800
Message-ID: <42FC5BB5.9080504@tw.ibm.com>
References: <42FC4B36.9080805@tw.ibm.com> <42FC4E7B.9030503@tw.ibm.com> <42FC52A8.8070102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:39935 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S1750705AbVHLIVi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Aug 2005 04:21:38 -0400
In-Reply-To: <42FC52A8.8070102@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>



Jeff Garzik wrote:

> Albert Lee wrote:
> 
>>   Root cause for the irq lost is unknown yet. I've tried your ATAPI 
>> DMA alignment
>> patch, but the problem still occurs, even the buffer is aligned. I 
>> guess it is pdc2027x hardware problem.
> 
> 
> 
> Note that my ATAPI DMA alignment patch was buggy, as Tejun noted...
> 
> Tejun's updated patch is worth a try.
> 

Thanks for the advice. Will try.

Albert


