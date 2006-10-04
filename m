From: Mark Lord <lkml@rtr.ca>
Subject: Re: What's in libata-dev.git
Date: Wed, 04 Oct 2006 14:48:24 -0400
Message-ID: <452401F8.5000004@rtr.ca>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <4523F602.6070608@rtr.ca> <4523F77B.1030908@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:40453 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1422825AbWJDSsZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Oct 2006 14:48:25 -0400
In-Reply-To: <4523F77B.1030908@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Sergei Shtylyov wrote:
>..
>> I suspect Sergei simply had a bad controller card at the time.
> 
>    I can hardly imagine the reason why a PCI IDE controller (that was 
> something like VT82C586 I think) would need to mess with the sector 
> count reg. in PIO mode and return "command aborted" in the error reg... 
> That was the exact sympthom IIRC.

Ahh.. well, if it just returned command aborted, then Jeff's original
change would present no real danger --> any occurances would be detected.

But to answer the imaginative question, the *reason* why a PCI (or VLB) IDE
controller would mess with the registers, is because the makers have this
nasty habit of wanting to do data prefetching (and posting) to speed up
transfers, particularly PIO transfers.  And the only way they can do the
prefetching/posting "safely", is to snoop the taskfile registers and have
the contoller "know" their meanings.

This has lead to all kinds of lunacies, like the RZ1000, CMD640, and other
memorable disasters of mis-implementation.

Cheers!
