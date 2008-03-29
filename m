From: Mark Lord <liml@rtr.ca>
Subject: Re: Marvell 6141 support
Date: Sat, 29 Mar 2008 16:46:42 -0400
Message-ID: <47EEAAB2.2060404@rtr.ca>
References: <1205578981.3107.18.camel@localhost.localdomain> <loom.20080324T074551-373@post.gmane.org> <47EE3DBF.4070300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1122 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754444AbYC2Uqp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Mar 2008 16:46:45 -0400
In-Reply-To: <47EE3DBF.4070300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Micael Beronius <micael.beronius@abc.se>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Micael Beronius wrote:
>> Andy Sturrock <linux-kernel <at> sturrock.org> writes:
>>
>>> Hi Jeff,
>>>
>>> The patch you submitted back in May 2007 you called "Add Marvell 6141
>>> ..
>>
>>> Initially all seems fine, I can see the attached drives in /dev and
>>> fdisk and mkfs.ext3 seem to work OK.  Then I tried putting the drives 
>>> into a RAID 5 array using
>>> mdadm and it all went pear-shaped - see output from dmesg etc attached.
>>
>>
>> Hi Andy, I am not Jeff, unforturnately... :) But I just wanted to 
>> confirm that what you have seen is exactly what I learned and posted 
>> last summer (2007-08-04 10:11:48 GMT). At the time, I tried all 
>> kernels and branches I could get my hands on.
>>
>> Also I would not mind helping, but similar to you, I have not any 
>> knowledge about the sata subsystem. But I can certainly test etc.
>>
>> In order to get into trouble, it seams that exercising more than one 
>> disk at the same time on the interface "does it". - i.e. one doesn't 
>> have to go raid.
> 
> Mark is currently working on improving sata_mv support.  Mark, are you 
> working on ahci flavored marvells too?
..

Nope.  No plans to, either.

Cheers

