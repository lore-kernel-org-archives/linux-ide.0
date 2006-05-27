From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH alt4 v2] libata resume fixes
Date: Sat, 27 May 2006 17:09:39 -0400
Message-ID: <4478C013.90900@rtr.ca>
References: <20060527195847.GA28334@havoc.gtf.org> <20060527201024.GA29015@havoc.gtf.org> <4478B312.5040901@garzik.org> <4478B611.2030201@rtr.ca> <4478B743.2050006@garzik.org> <4478B971.3060409@rtr.ca> <4478BD09.5010309@garzik.org> <4478BDFD.60209@rtr.ca> <4478BF72.5010708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:11466 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964975AbWE0VJi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:09:38 -0400
In-Reply-To: <4478BF72.5010708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Mark Lord wrote:
>
>> But does it fall over any worse than we already do with the stock kernel?
> 
> Are you talking about my x86-64 box + Linus's patch, or the future 
> implications?
> 
> For the former, the previous behavior was EH spew like what you are 
> seeing.  After apply Linus's patch, it hardlocks.  But I don't want that 
> to hold up the patch...  libata suspend/resume is one part luck, and one 
> part "it's only ata_piix so far."  It has a looooong way to go before it 
> is usable outside of that domain.

I was asking if Linus's one-liner patch makes things any worse
than they already were on your own machine.  It sounds like "Not".

Cheers
