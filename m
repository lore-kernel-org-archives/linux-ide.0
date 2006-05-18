From: Ric Wheeler <ric@emc.com>
Subject: Re: [RFT] major libata update
Date: Thu, 18 May 2006 09:22:34 -0400
Message-ID: <446C751A.20000@emc.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com> <446A7E4A.1080003@gmail.com> <446A9F13.4020907@emc.com> <446AAA33.5010800@gmail.com> <446B8F25.3040907@pobox.com> <446B8FC6.5040009@garzik.org> <446B9AA7.4000305@gmail.com> <446B9C1A.1060106@rtr.ca> <446BEB11.4030703@emc.com> <446BE97A.2080303@gmail.com> <446C6163.7010002@emc.com> <446C6DF7.6030202@pobox.com>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:59864 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1750933AbWERNYw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 May 2006 09:24:52 -0400
In-Reply-To: <446C6DF7.6030202@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>


Mark Lord wrote:
>>
>> A different discussion is what we should do or log when we detect this 
>> - i.e., write cache enabled and barrier ops not supported (disable 
>> write cache?  log a scarier message? ignore it?).  Today's behavior is 
>> probably what most home users want (run as fast as I can, absolute 
>> data integrity over power failures not a big deal) but not the right 
>> behavior for critical data (i.e., forget performance, make sure my 
>> data is always safe ). 
> 
> Yes, 99.99% of Linux users would really complain like mad
> if the *kernel* took over the *policy* decision of disabling
> write-caching.  The long-term kernel rule has always been,
> leave *policy* to user-space.
> 
> Cheers

Agreed - I think that only challenge is for us to make sure that the messages in 
the upstream kernel are informative enough to let people know what this means 
and some level of their exposure.

Maybe the "enterprise" distro install programs would want to treat write barrier 
  like we do support for 3D video card acceleration with a good overview & let 
the user configure the system as best suits their needs.  I think that it is 
still quite difficult to get right today for most casual users...

ric

