From: Tejun Heo <htejun@gmail.com>
Subject: Re: Marvell 6141 support
Date: Sat, 29 Mar 2008 22:01:51 +0900
Message-ID: <47EE3DBF.4070300@gmail.com>
References: <1205578981.3107.18.camel@localhost.localdomain> <loom.20080324T074551-373@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:31496 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbYC2NCU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 09:02:20 -0400
Received: by wf-out-1314.google.com with SMTP id 28so629086wff.4
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 06:02:19 -0700 (PDT)
In-Reply-To: <loom.20080324T074551-373@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Micael Beronius <micael.beronius@abc.se>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Micael Beronius wrote:
> Andy Sturrock <linux-kernel <at> sturrock.org> writes:
> 
>> Hi Jeff,
>>
>> The patch you submitted back in May 2007 you called "Add Marvell 6141
>> ..
> 
>> Initially all seems fine, I can see the attached drives in /dev and
>> fdisk and mkfs.ext3 seem to work OK.  
>> Then I tried putting the drives into a RAID 5 array using
>> mdadm and it all went pear-shaped - see output from dmesg etc attached.
> 
> 
> Hi Andy, I am not Jeff, unforturnately... :) But I just wanted to confirm that 
> what you have seen is exactly what I learned and posted last summer (2007-08-04 
> 10:11:48 GMT). At the time, I tried all kernels and branches I could get my 
> hands on.
> 
> Also I would not mind helping, but similar to you, I have not any knowledge 
> about the sata subsystem. But I can certainly test etc.
> 
> In order to get into trouble, it seams that exercising more than one disk at 
> the same time on the interface "does it". - i.e. one doesn't have to go raid.

Mark is currently working on improving sata_mv support.  Mark, are you 
working on ahci flavored marvells too?

-- 
tejun
