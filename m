From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [patch 02/10] sata_nv: add back some verbosity into ADMA
 error_handler
Date: Sat, 28 Apr 2007 13:56:17 -0600
Message-ID: <4633A6E1.9040907@shaw.ca>
References: <200704260719.l3Q7JMhB023682@shell0.pdx.osdl.net>
 <46339C63.1020206@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:54163 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031275AbXD1T4T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Apr 2007 15:56:19 -0400
Received: from pd2mr1so.prod.shaw.ca
 (pd2mr1so-qfe3.prod.shaw.ca [10.0.141.110]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JH80059A4PVE3C0@l-daemon> for linux-ide@vger.kernel.org; Sat,
 28 Apr 2007 13:56:19 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
 by pd2mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JH800G344PVKCP0@pd2mr1so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Sat, 28 Apr 2007 13:56:19 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.1.86])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JH800EPU4PUS060@l-daemon> for linux-ide@vger.kernel.org; Sat,
 28 Apr 2007 13:56:18 -0600 (MDT)
In-reply-to: <46339C63.1020206@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, htejun@gmail.com

Jeff Garzik wrote:
> akpm@linux-foundation.org wrote:
>> From: Robert Hancock <hancockr@shaw.ca>
>>
>> Some debug output in the ADMA error_handler function was removed 
>> recently,
>> but it may be useful in certain cases, like NCQ commands timing out.  Add
>> it back in, but make it a bit more intelligent so that it only prints if
>> command(s) are active and only prints the CPBs for those commands.  That
>> way it won't spew at inappropriate times like suspend/resume.
>>
>> [akpm@osdl.org: cleanup]
>> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
>> Cc: Jeff Garzik <jeff@garzik.org>
>> Cc: Tejun Heo <htejun@gmail.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>>  drivers/ata/sata_nv.c |   31 +++++++++++++++++++++++++++++--
>>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> Robert, is this patch still wanted?
> 
> It looks OK; I've held because I thought it was created to debug a 
> special situation.
> 
> But I might be mistaken...
> 
>     Jeff

Wait a minute, this patch is essentially already merged in mainline:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=2cb27853b7cbf0c908444e25c61b62fa336b88cd

The only part that hasn't been merged is the whitespace cleanup that 
Andrew added in his tree.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


