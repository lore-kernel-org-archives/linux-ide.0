From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/4] sata_sil: implement Mod15Write workaround by split
 request processing
Date: Wed, 01 Nov 2006 11:17:31 +0900
Message-ID: <454803BB.6000006@gmail.com>
References: <11612370993859-git-send-email-htejun@gmail.com> <4547FF96.4070808@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:16311 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946421AbWKACRp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Oct 2006 21:17:45 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1623759ugm
        for <linux-ide@vger.kernel.org>; Tue, 31 Oct 2006 18:17:44 -0800 (PST)
In-Reply-To: <4547FF96.4070808@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Instead of limiting max_sectors to 15 unconditionally, this patch
>> leaves max_sectors at the default value and process write requests
>> larger than 15 sectors by processing them in <= 15 sectors chunks.
>> This results in unhamplered read performance and better write
>> performance.
>>
>> Split request processing is performed only for DMA write requests > 15
>> sectors.  dev->max_sectors is limited to 15 sectors when the device is
>> put into PIO mode.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> I'm still put off by the complexity that this adds to each transfer, and 
> to the overall driver itself.
> 
> It's largely older chips and drives, so I don't think it's worth 
> carrying this code for decades to come, just for some early SATA screwups.

Hey, you are the one who said that this can be included in the mainline. 
I agree that this is a complex workaround, but...

* There are quite some number of users out there.  My sil m15w 
workaround page has quite some visitors and many of them are returning 
visitors.

* The workaround kicks in only under certain circumstances, so it's not 
like it adds overhead to normal command processing.

* It's complex but I've been carrying this around for quite some time 
now and it's pretty easy to maintain.  If you prefer, I can put all the 
workaround implementation inside #if 1 .. #endif, so it can be dropped 
very easily in the future.

I think it's worthwhile to have the workaround included.  It has real 
users out there and they benefit a lot from it.  Complexity is contained 
inside sata_sil proper and it has been shown that maintenance overhead 
isn't too big.

I'll even put /* feel free to turn off #if for m15w workaround if it 
causes any problem to new feature/bug fix/whatsoever.  I'll follow up 
and update it accordingly. */ comment above it.

Thanks.

-- 
tejun
