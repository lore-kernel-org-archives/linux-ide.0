From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and Power Management
 patches against v2.6.17
Date: Sun, 25 Jun 2006 22:48:44 +0900
Message-ID: <449E943C.4050706@gmail.com>
References: <20060625073003.GA21435@htj.dyndns.org> <449E73C1.4050604@tomt.net> <449E770E.4010102@gmail.com> <449E935E.4090006@tomt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:62725 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750955AbWFYNsr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jun 2006 09:48:47 -0400
Received: by py-out-1112.google.com with SMTP id t32so1183482pyc
        for <linux-ide@vger.kernel.org>; Sun, 25 Jun 2006 06:48:46 -0700 (PDT)
In-Reply-To: <449E935E.4090006@tomt.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andre Tomt wrote:
> Tejun Heo wrote:
>> Andre Tomt wrote:
>>> Tejun Heo wrote:
>>>> Hello, all.
>>>>
>>>> libata-tj-stable patches against v2.6.17 and v2.6.17.1 are available.
>>>
>>> It appears drivers/scsi/libata-eh.c isn't getting built in the 2.6.17 
>>> patch, seems to be missing in drivers/scsi/Makefile:
>>
>> Yeap, right.  My bad.  I forgot to do 'quilt add' the Makefile.  The 
>> updated tarball is at
>>
>> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625-1.tar.bz2 
> 
> 
> Seems to work great so far, only knit is that the kernel log does not 
> print it out the NCQ bits as indicated in the README. queue_depth in 
> sysfs do show proper values however, just a backport issue I guess.

It's actually a hiccup introduced by recent selective msg-enable in 
#upstream.  It will be resolved soon.

Thanks.

-- 
tejun
