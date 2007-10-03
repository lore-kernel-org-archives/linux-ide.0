From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/15] qd65xx: fix deadlock on error handling
Date: Wed, 03 Oct 2007 18:51:17 -0400
Message-ID: <47041CE5.90407@garzik.org>
References: <200710012333.02643.bzolnier@gmail.com> <200710030015.44586.bzolnier@gmail.com> <4702C3D9.6040606@garzik.org> <200710040041.40047.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60931 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbXJCWvW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 18:51:22 -0400
In-Reply-To: <200710040041.40047.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 03 October 2007, Jeff Garzik wrote:
>> Bartlomiej Zolnierkiewicz wrote:
>>
>> ACK everything else (that I snipped)...
>>
>>> @@ -303,6 +281,7 @@ static void qd6580_set_pio_mode(ide_driv
>>>  
>>>  static int __init qd_testreg(int port)
>>>  {
>>> +	static DEFINE_SPINLOCK(qd65xx_lock);
>>>  	unsigned long flags;
>>>  	u8 savereg, readreg;
>> At this point, the lock is largely pointless, isn't it?
>>
>> Seems like you might as well use local_irq_save/restore.
> 
> Yeah.
> 
> 
> [PATCH] qd65xx: remove pointless qd_{read,write}_reg() (take 2)
> 
> These functions are atomic so locking is pointless (noticed by Sergei).
> 
> v2:
> We can now just use local_irq_save/restore() in qd_testreg() (noticed by Jeff).
> 
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

ACK


