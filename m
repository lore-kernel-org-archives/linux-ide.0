From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Wed, 10 May 2006 14:17:54 +0900
Message-ID: <44617782.7000302@gmail.com>
References: <44614592.7080301@gmail.com> <1147236696.7273.5.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.206]:62799 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964808AbWEJFSC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 May 2006 01:18:02 -0400
Received: by nz-out-0102.google.com with SMTP id 13so1644009nzn
        for <linux-ide@vger.kernel.org>; Tue, 09 May 2006 22:18:01 -0700 (PDT)
In-Reply-To: <1147236696.7273.5.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, Zhao, Forrest.

zhao, forrest wrote:
> On Wed, 2006-05-10 at 10:44 +0900, Tejun Heo wrote:
> 
>> The only Port Multiplier I've got is sil4726 and thus it's the only one 
>> tested.  I implemented AHCI PM support half-way but then realized I 
>> don't have any AHCI controller which supports PM (I have ICH7R).  Is 
>> there any AHCI controller which reports PM support?
>>
> Tejun,
> 
> There're some machines in our lab, which support PM. The IO controller
> on these machines is ICH7 family. But we have no port multiplier 

Does your ICH7 report 1 for the SMP bit (bit 17 of the CAP register)?
Cool.  How come mine doesn't?  :/  Can you tell me the exact name of the
product?

> hardware, which connect multiple SATA drives to a port on SATA
> controller. Do you know where we can buy a port multiplier card?

I couldn't buy one either.  Silicon Image guys were nice enough to send
me a sample board.  So, that's what I've worked on.  There seems to be
some external storage products incorporating PM, but I'm not sure about
the availability.

> Is it possible to conduct the PM test without this PM card?

No, I don't think that's possible in any meaningful way.

Zhao, I think I've ironed out all the problems you've reported with the
previous revision of hotplug.  If you've got some time, can you please
check whether those problems are really gone?

Thanks.

-- 
tejun
