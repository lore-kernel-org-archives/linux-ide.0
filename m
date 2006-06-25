From: Andre Tomt <andre@tomt.net>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and Power Management
 patches against v2.6.17
Date: Sun, 25 Jun 2006 15:45:02 +0200
Message-ID: <449E935E.4090006@tomt.net>
References: <20060625073003.GA21435@htj.dyndns.org> <449E73C1.4050604@tomt.net> <449E770E.4010102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.skjellin.no ([80.239.42.67]:6279 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S1750911AbWFYNpF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jun 2006 09:45:05 -0400
In-Reply-To: <449E770E.4010102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Andre Tomt wrote:
>> Tejun Heo wrote:
>>> Hello, all.
>>>
>>> libata-tj-stable patches against v2.6.17 and v2.6.17.1 are available.
>>
>> It appears drivers/scsi/libata-eh.c isn't getting built in the 2.6.17 
>> patch, seems to be missing in drivers/scsi/Makefile:
> 
> Yeap, right.  My bad.  I forgot to do 'quilt add' the Makefile.  The 
> updated tarball is at
> 
> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625-1.tar.bz2 

Seems to work great so far, only knit is that the kernel log does not 
print it out the NCQ bits as indicated in the README. queue_depth in 
sysfs do show proper values however, just a backport issue I guess.
