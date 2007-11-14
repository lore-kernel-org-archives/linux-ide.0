From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB
Date: Tue, 13 Nov 2007 22:11:56 -0600
Message-ID: <473A758C.1020105@shaw.ca>
References: <4738DE21.8090702@shaw.ca> <47390B2F.7090105@gmail.com>
 <47392768.3030509@shaw.ca> <47392B3D.1020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760541AbXKNEMe@vger.kernel.org>
In-reply-to: <47392B3D.1020101@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
>> Could be done.. but, I don't want to constrain the ADMA APRD/CPB area in
>> that way (there are some dual-socket Opteron boxes with this controller,
>> forcing an allocation below 4GB for this could force a non-optimal node
>> allocation I think..) To do this I'd have to raise the mask for the APRD
>> allocation, drop it again, then raise it again in ADMA mode, which is
>> kind of ugly.
> 
> I don't think it really matters.  The table isn't too big and it's not
> like access to the table has any processor locality.  Maybe it's better
> to allocate to the same node as the irq but raising DMA mask doesn't
> help at all.

It's quite possible that restricting the DMA mask will also restrict 
what node that can get allocated on. I'm not so much thinking of the CPU 
access to the table but the controller's banging on the thing several 
times for each command..

> 
> I think performance impact is nil either way but even in highly unlikely
> case it has any impact, allocating PRDs under 4G should be better as it
> avoids DAC cycles on the bus.  But again, this is just irrelevant.
> 
> I'd say just allocate everything under 4G.

The DAC issue shouldn't matter as these controllers are integrated into 
the chipset so it will be using all HT bus transactions, not PCI.

We can do it without all that mess in slave_config though, just by 
delaying raising the DMA mask until after the PRD/pad buffers are allocated.

> 
>> Also, I'd rather not allocate the legacy PRD at all if we're in ADMA
>> mode. That way, if some bug causes us to try and do legacy DMA in ADMA
>> mode, we'll crash from null pointer dereference instead of potentially
>> transferring incorrect data (as we had in this case) and corrupting things.
> 
> Yeap, I can agree with this.  But can you add BUG_ON()/WARN_ON() at
> places instead?  I know blanking pointers feel safer but I think it's
> best to keep resource allocation / release in ->port_start/stop().

Yeah, I've got rid of that stuff now and added some BUG_ONs for this. 
Will submit the patches shortly.
