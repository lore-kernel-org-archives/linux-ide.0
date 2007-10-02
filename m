From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/15] qd65xx: fix deadlock on error handling
Date: Tue, 02 Oct 2007 09:04:13 -0400
Message-ID: <470241CD.4060507@garzik.org>
References: <200710012333.02643.bzolnier@gmail.com> <470240BC.9070707@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35150 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbXJBNEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 09:04:16 -0400
In-Reply-To: <470240BC.9070707@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>> Stop abusing ide_lock lock (switch to a private locking).
> 
>> Fixes same issue as fixed by Alan Cox in atiixp host driver with
>> commit 6c5f8cc33eb2e10b6ab788bbe259fc142a068627.
> 
>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>> Index: b/drivers/ide/legacy/qd65xx.c
>> ===================================================================
>> --- a/drivers/ide/legacy/qd65xx.c
>> +++ b/drivers/ide/legacy/qd65xx.c
>> @@ -89,13 +89,15 @@
>>  
>>  static int timings[4]={-1,-1,-1,-1}; /* stores current timing for 
>> each timer */
>>  
>> +static DEFINE_SPINLOCK(qd65xx_lock);
>> +
>>  static void qd_write_reg (u8 content, unsigned long reg)
>>  {
>>      unsigned long flags;
>>  
>> -    spin_lock_irqsave(&ide_lock, flags);
>> +    spin_lock_irqsave(&qd65xx_lock, flags);
>>      outb(content,reg);
>> -    spin_unlock_irqrestore(&ide_lock, flags);
>> +    spin_unlock_irqrestore(&qd65xx_lock, flags);
>>  }
>>  
>>  static u8 __init qd_read_reg (unsigned long reg)
>> @@ -103,9 +105,9 @@ static u8 __init qd_read_reg (unsigned l
>>      unsigned long flags;
>>      u8 read;
>>  
>> -    spin_lock_irqsave(&ide_lock, flags);
>> +    spin_lock_irqsave(&qd65xx_lock, flags);
>>      read = inb(reg);
>> -    spin_unlock_irqrestore(&ide_lock, flags);
>> +    spin_unlock_irqrestore(&qd65xx_lock, flags);
>>      return read;
>>  }
> 
>    I don't see why all the locking above is needed at all -- isn't these 
> atomic functions? :-/

Agreed.

	Jeff



