From: Ryan Power <rpower@sysreset.com>
Subject: Re: [PATCH] Unbreak build of PMP with ACPI disabled
Date: Sun, 15 Jul 2007 21:38:00 -0600
Message-ID: <6.2.0.14.2.20070715213648.02fcaeb0@linux.sysreset.com>
References: <20070713065600.GB8320@vana.vc.cvut.cz>
 <46972519.80703@gmail.com>
 <46980AFD.3000503@shaw.ca>
 <6.2.0.14.2.20070713175627.031aada0@linux.sysreset.com>
 <4698356D.60605@gmail.com>
 <4698BE05.2080003@vandrovec.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.sysreset.com ([209.97.229.250]:10587 "EHLO sysreset"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759350AbXGPDiB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Jul 2007 23:38:01 -0400
In-Reply-To: <4698BE05.2080003@vandrovec.name>
References: <20070713065600.GB8320@vana.vc.cvut.cz>
 <46972519.80703@gmail.com>
 <46980AFD.3000503@shaw.ca>
 <6.2.0.14.2.20070713175627.031aada0@linux.sysreset.com>
 <4698356D.60605@gmail.com>
 <4698BE05.2080003@vandrovec.name>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <petr@vandrovec.name>, Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org

At 06:13 AM 7/14/2007, Petr Vandrovec wrote:
>Tejun Heo wrote:
>>Ryan Power wrote:
>>>I'm also experiencing this problem on a with the sata_nv module.  I
>>>suspect that it may at least not be controller dependant, as it's also
>>>occurring on my silicon image controller (sata_sil, SiI3512).  It looks
>>>like something is zeroing out part of the return registers for the
>>>overall smart status.
>>Hmmm... Incidentally, Jeff told me yesterday he was seeing the same
>>problem on sil.  Maybe it's something in the core.  I'll investigate.
>
>What about attached patch?  Seems to make my mcp61 happy... (it is sent 
>from Mozilla, so patch below is most probably whitespace challenged... 
>attachment should be fine)
>                                                         Petr

That patch fixes the problems I was seeing on both interfaces.  Everything 
looks be to working correctly again.

Thanks.
-Ryan 

