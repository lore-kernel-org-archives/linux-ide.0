From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Kernel Panic sata_promise with atapi on dual Opteron
Date: Tue, 17 May 2005 21:06:43 +0800
Message-ID: <4289EC63.6080901@tw.ibm.com>
References: <42897C2F.9060609@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:32224 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261443AbVEQNHP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 May 2005 09:07:15 -0400
In-Reply-To: <42897C2F.9060609@utoronto.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Stubbs <dave.stubbs@utoronto.ca>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org



Dave Stubbs wrote:

> Hello Jeff,
> 
> Don't know if you've seen this before, but I thought I should mention it 
> since I seem to be able to reproduce it quite reliably.
> 
> I am trying to get my new Plextor SATA DVD-RW drive working under 
> linux.  I have it hooked up to a Promise SATAII150 TX4 controller, which 
> sees it ok during BIOS init.  The system this is all running on is a 
> Dual Opteron 246 system on a Tyan Tiger motherboard.
> 
> If I enable ATAPI support in include/linux/libata.h and recompile the 
> kernel, I get the following when the module tries to load:
> 
> Kernel Bug at sata_promise:468
> invalid operand 0000 [1] SMP
> 
> and then the kernel panics.
> 
> This happens the same with 2.6.11.8, 2.6.11.9, and 2.6.11-gentoo-r6.  It 
> also happens whether sata_promise is compiled as a module or integrated.
> 
> Does this give enough information to make heads or tails of this?
> Thanks very much for your time,
> 
> Dave...
> -

Since the machine is x86-64, I guess this is caused by the sg_dma_len() issue as in:
http://marc.theaimsgroup.com/?l=linux-ide&m=111113103410355&w=2

Albert


