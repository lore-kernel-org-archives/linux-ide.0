From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/4] sata_sil: implement Mod15Write workaround by split
 request processing
Date: Tue, 31 Oct 2006 21:31:13 -0500
Message-ID: <454806F1.8010703@pobox.com>
References: <11612370993859-git-send-email-htejun@gmail.com> <4547FF96.4070808@pobox.com> <454803BB.6000006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52438 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946478AbWKACbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 21:31:16 -0500
In-Reply-To: <454803BB.6000006@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Instead of limiting max_sectors to 15 unconditionally, this patch
>>> leaves max_sectors at the default value and process write requests
>>> larger than 15 sectors by processing them in <= 15 sectors chunks.
>>> This results in unhamplered read performance and better write
>>> performance.
>>>
>>> Split request processing is performed only for DMA write requests > 15
>>> sectors.  dev->max_sectors is limited to 15 sectors when the device is
>>> put into PIO mode.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> I'm still put off by the complexity that this adds to each transfer, 
>> and to the overall driver itself.
>>
>> It's largely older chips and drives, so I don't think it's worth 
>> carrying this code for decades to come, just for some early SATA 
>> screwups.
> 
> Hey, you are the one who said that this can be included in the mainline. 
> I agree that this is a complex workaround, but...
> 
> * There are quite some number of users out there.  My sil m15w 
> workaround page has quite some visitors and many of them are returning 
> visitors.
> 
> * The workaround kicks in only under certain circumstances, so it's not 
> like it adds overhead to normal command processing.
> 
> * It's complex but I've been carrying this around for quite some time 
> now and it's pretty easy to maintain.  If you prefer, I can put all the 
> workaround implementation inside #if 1 .. #endif, so it can be dropped 
> very easily in the future.
> 
> I think it's worthwhile to have the workaround included.  It has real 
> users out there and they benefit a lot from it.  Complexity is contained 
> inside sata_sil proper and it has been shown that maintenance overhead 
> isn't too big.
> 
> I'll even put /* feel free to turn off #if for m15w workaround if it 
> causes any problem to new feature/bug fix/whatsoever.  I'll follow up 
> and update it accordingly. */ comment above it.

Sorry, I just think it adds too much complexity to sata_sil itself.  If 
the driver ever grows PIO-DMA support, it may make sense in that case, 
since you would need the complexity (sil context) anyway.

Seeing the patch, and comparing with the current driver, really weights 
in favor of the current more-simple driver.  There are a lot of 
"early-rev hardware bug" things that we just don't bother with in Linux, 
and I think this is one of them.

	Jeff



