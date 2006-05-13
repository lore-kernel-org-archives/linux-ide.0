From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Fri, 12 May 2006 23:37:58 -0400
Message-ID: <44655496.9030402@pobox.com>
References: <44614592.7080301@gmail.com> <446536C5.80503@pobox.com> <44653807.3030101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:26337 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751127AbWEMDiL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 May 2006 23:38:11 -0400
In-Reply-To: <44653807.3030101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> tested.  I implemented AHCI PM support half-way but then realized I 
>>> don't have any AHCI controller which supports PM (I have ICH7R).  Is 
>>> there any AHCI controller which reports PM support?
>>
>> You can always use SCR-based PM support...
>>
> 
> Can you elaborate a bit?

Sections A.1 and 6.1 of the PM spec.  You set the PMP field of the 
SControl register.  This has obvious parallelism limitations, which is 
why "hardware context switching support" aka native PM support is 
greatly preferred.


> @ welcome back.

Thanks!  :)

	Jeff, learning to type with a ring on the finger


