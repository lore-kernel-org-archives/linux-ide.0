From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: PATCH libata-2.6 4/5] Prevent the device from overrunning the
 buffer in __atapi_pio_bytes()
Date: Fri, 18 Mar 2005 17:04:09 +0800
Message-ID: <423A9989.7050008@tw.ibm.com>
References: <423A8AA4.5040601@tw.ibm.com> <58cb370e0503180031d40b0a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:16869 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261523AbVCRJEj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Mar 2005 04:04:39 -0500
In-Reply-To: <58cb370e0503180031d40b0a3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

 >
 > Bartlomiej Zolnierkiewicz wrote:
>>
>>Problem:
>>   Some bad behaved CD-ROM drives will return more data than ask to.
>>(I have such CD-RW drive and it crashed the kernel.)
> 
> 
> These devices are compliant with original ATAPI spec.
> 
> Such condition shouldn't be treated as an error
> - extra data should be read and dumped.
> 
> 
Hi Bart,

For read, we can read and discard the extra data from the device.
For write, the device is asking for more data than we have.
Should we supply some dummy data to the device? Or we just stop and return it as error?


Albert



