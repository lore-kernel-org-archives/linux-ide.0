From: Tejun Heo <tj@kernel.org>
Subject: Re: Software RAID Problem
Date: Wed, 29 Jul 2009 11:09:24 +0900
Message-ID: <4A6FAF54.1060902@kernel.org>
References: <1248798289.4a6f26510c218@myaccount.bayarea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53535 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977AbZG2CHY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 22:07:24 -0400
In-Reply-To: <1248798289.4a6f26510c218@myaccount.bayarea.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rbroman@bayarea.net
Cc: linux-ide@vger.kernel.org

Hello,

When you reply further, can you please do the followings?

1. Don't drop cc list.

2. Use an email client which properly specifies References: and
   In-Reply-To:.

rbroman@bayarea.net wrote:
>> Can you attach full output of 'dmesg' after raid degradation?
> 
> For context, there are four RAID devices on this system. md0 is
> /boot, md1 is / and md2 and md3 are the problem devices. /proc/mdstat
> is below followed by the output of dmesg.
> 
> /proc/mdstat
> 
> Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4]
> [raid10]
> md_d3 : inactive sdd2[2](S)
>       366289920 blocks
> 
> md_d2 : inactive sdd1[2](S)
>       366281856 blocks
> 
> md1 : active raid0 sdb6[1] sda6[0]
>       781256704 blocks 64k chunks
> 
> md0 : active raid1 sda1[0] sdb1[1]
>       48829440 blocks [2/2] [UU]
> 
> unused devices: <none>
> 
> dmesg .....
> 

The dmesg doesn't contain ATA error messages and the actual
degradation.  Can you please trigger that and then attach dmesg?

Thanks.

-- 
tejun
