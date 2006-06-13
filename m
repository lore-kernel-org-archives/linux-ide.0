From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/10] libata: implement new Power Management framework
Date: Tue, 13 Jun 2006 11:08:07 +0900
Message-ID: <448E1E07.7010803@gmail.com>
References: <11501274293403-git-send-email-htejun@gmail.com> <1150130098.25462.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:55001 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932775AbWFMCIP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 22:08:15 -0400
Received: by py-out-1112.google.com with SMTP id x31so1859256pye
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 19:08:14 -0700 (PDT)
In-Reply-To: <1150130098.25462.10.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> Ar Maw, 2006-06-13 am 00:50 +0900, ysgrifennodd Tejun Heo:
>> Suspend is performed parallely on all ports of a host_set and resume
>> is done parallely in background to decrease the time necessary before
>> responding to user.
> 
> Do we need a disk count here - some large disk setups rely on the fact
> drives don't all spin up at once to avoid overloading the PSU ?

For most desktops and notebooks, it doesn't really matter as power is 
removed from disks during memsleep and they all spin up immediately 
after resume regardless of what libata does.  For external enclosures 
with separate power supply, limiting the number of concurrent spinups 
during resume is necessary though.

I think we need to make a central disk spinup limiter to control the 
number of concurrent spinups across both ATA and SCSI.  SATA staggered 
spinup should be considered too.  Depending on situation, a drive may 
spin up on power up, PHY ready or IDLE_IMM after resuming from memsleep.

FWIW, my cheapo 325w PSU (< 30USD) hasn't had any problem spinning up 11 
drives simultaneously.

I think it's okay to leave it as it is for the time being.  It's not 
like people w/ external enclosures use suspend/resume a lot.

-- 
tejun
