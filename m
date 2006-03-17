From: Tejun Heo <htejun@gmail.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Sat, 18 Mar 2006 00:29:26 +0900
Message-ID: <441AD5D6.10109@gmail.com>
References: <1142344212.4416ca14a26b4@webmail.aon.at> <44182CD7.9070401@rtr.ca> <20060316100838.GF3595@suse.de> <441A4873.3030102@rtr.ca> <441A80CA.6080407@tw.ibm.com> <441AD3AE.1030301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:28562 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932501AbWCQP3k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Mar 2006 10:29:40 -0500
Received: by pproxy.gmail.com with SMTP id w49so34429pyg
        for <linux-ide@vger.kernel.org>; Fri, 17 Mar 2006 07:29:39 -0800 (PST)
In-Reply-To: <441AD3AE.1030301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: albertl@mail.com, Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>, me_trash1@aon.at, linux-ide@vger.kernel.org

Mark Lord wrote:
> Albert Lee wrote:
> 
>> Mark Lord wrote:
> 
> ..
> 
>>> We're both correct, in that 0x35 is ATA_CMD_WRITE_EXT as I said.
>>> But the naming had me fooled -- they really are DMA commands,
>>> even if the linux/ata.h names are incomplete.
>>>
>>  
>> How about the attached renaming patch?
>> It could make the command names more consistent to what's in the 
>> ATA/ATAPI spec.
> 
> ..
> 
> Hey, that's a great idea.  And the patch is quite small, too.
> 
> Stick a Signed-Off-By line on it, and we'll see what our
> benevolent overJeff says for it.  ;)
> 

One more Signed-off-by here. :-)

-- 
tejun
