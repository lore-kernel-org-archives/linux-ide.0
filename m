From: Mark Lord <lkml@rtr.ca>
Subject: Re: What's in libata-dev.git
Date: Wed, 04 Oct 2006 13:57:22 -0400
Message-ID: <4523F602.6070608@rtr.ca>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2310 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030716AbWJDR5Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Oct 2006 13:57:24 -0400
In-Reply-To: <45056627.7030202@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Sergei Shtylyov wrote:
> ..
>> Jeff Garzik:
> [...]
>>       [ATA] Increase lba48 max-sectors from 200 to 256.
> 
>    So was it for LBA28 or for LBA48?
>    As for LBA28, it might be quite dangerous. Particularly, I know that 
> IBM drives used to mistreated 256 as 0 in the past (bumped into that on 
> a 8-year old drive which is still alive though).
..
>The exact model was IBM DHEA-34331. 

I've been travelling for the past month, so pardon the late tuning in here.
I've *never* encountered a drive that had this problem.
Controllers, yes, and those are easily dealt with in the chipset drivers.

But never drives.  Not since 1992 when I first took up Linux IDE stuff.

I have some 7-year old IBM drives here, and they certainly don't have
this problem either (but they do have working TCQ etc..).

I suspect Sergei simply had a bad controller card at the time.

Cheers
