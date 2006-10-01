From: Ric Wheeler <ric@emc.com>
Subject: Re: [PATCH 2/2] libata: turn off NCQ if queue depth is adjusted to
  1
Date: Sat, 30 Sep 2006 20:17:43 -0400
Message-ID: <451F0927.2010804@emc.com>
References: <20060930104439.GP25800@htj.dyndns.org> <20060930104500.GQ25800@htj.dyndns.org> <20060930180359.GP4163@kernel.dk> <1159649460.13029.145.camel@localhost.localdomain> <20060930202628.GF5670@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:27776 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751742AbWJAASf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 20:18:35 -0400
In-Reply-To: <20060930202628.GF5670@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org



Jens Axboe wrote:

>On Sat, Sep 30 2006, Alan Cox wrote:
>  
>
>>Ar Sad, 2006-09-30 am 20:04 +0200, ysgrifennodd Jens Axboe:
>>    
>>
>>>On Sat, Sep 30 2006, Tejun Heo wrote:
>>>      
>>>
>>>>Turn off NCQ if queue depth is adjusted to 1.
>>>>        
>>>>
>>>I had thought of that too but discarded it - it would be nicer to have
>>>an independent way of turning off NCQ. Say you are debugging a weird FIS
>>>issue, NCQ depth 1 is still a different beast to non-NCQ. I see Jeff
>>>already applied the patches, but just thought I'd voice my opinion.
>>>      
>>>
>>I've got a blacklist for NCQ in my work tree but really we need the
>>vendors to help fill it. So far it has some raptors in it but I am sure
>>there are more, and I am sure there are cases we should be advising
>>newer firmware or just tweaking our queue sizes etc.
>>    
>>
>
>Lots of the older Maxtors are pretty crappy for NCQ, so those too. Queue
>size tweaks fixed them for me (as low as 4, and I can't say for sure if
>it fixes all crashes).
>
>  
>
We have to be careful with the blacklisting - specifically, drive model 
is often less critical than the version of the firmware (which gets 
updated as people work drives through qualification, etc). 

Updating drive firmware for end users is pretty rare (and almost all 
tools are still DOS based ;-)).

Certain drives should default to non-NCQ (based on model), but we should 
be able to enable it if the firmware supports it.

Most of the newest drives are fine, but we will still need something 
like Tejun's fix to be able to turn it off for the odd cases that show 
up in certain odd applications, etc.




