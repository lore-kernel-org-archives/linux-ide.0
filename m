From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 02/10] sata_nv: add back some verbosity into ADMA error_handler
Date: Sat, 28 Apr 2007 16:08:00 -0400
Message-ID: <4633A9A0.9000002@garzik.org>
References: <200704260719.l3Q7JMhB023682@shell0.pdx.osdl.net> <46339C63.1020206@garzik.org> <4633A6E1.9040907@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53962 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754136AbXD1UIH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 16:08:07 -0400
In-Reply-To: <4633A6E1.9040907@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, htejun@gmail.com

Robert Hancock wrote:
> Jeff Garzik wrote:
>> akpm@linux-foundation.org wrote:
>>> From: Robert Hancock <hancockr@shaw.ca>
>>>
>>> Some debug output in the ADMA error_handler function was removed 
>>> recently,
>>> but it may be useful in certain cases, like NCQ commands timing out.  
>>> Add
>>> it back in, but make it a bit more intelligent so that it only prints if
>>> command(s) are active and only prints the CPBs for those commands.  That
>>> way it won't spew at inappropriate times like suspend/resume.
>>>
>>> [akpm@osdl.org: cleanup]
>>> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
>>> Cc: Jeff Garzik <jeff@garzik.org>
>>> Cc: Tejun Heo <htejun@gmail.com>
>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>>
>>>  drivers/ata/sata_nv.c |   31 +++++++++++++++++++++++++++++--
>>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> Robert, is this patch still wanted?
>>
>> It looks OK; I've held because I thought it was created to debug a 
>> special situation.
>>
>> But I might be mistaken...
>>
>>     Jeff
> 
> Wait a minute, this patch is essentially already merged in mainline:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=2cb27853b7cbf0c908444e25c61b62fa336b88cd 
> 
> 
> The only part that hasn't been merged is the whitespace cleanup that 
> Andrew added in his tree.

ah, indeed.  That's probably why my scripts thought the changes had not 
yet been applied.

Sorry for the noise.

	Jeff



