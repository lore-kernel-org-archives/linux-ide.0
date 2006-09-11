From: Jeff Garzik <jeff@garzik.org>
Subject: Re: What's in libata-dev.git
Date: Mon, 11 Sep 2006 09:37:38 -0400
Message-ID: <450566A2.1090009@garzik.org>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:12979 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750815AbWIKNhk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Sep 2006 09:37:40 -0400
In-Reply-To: <45056627.7030202@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Sergei Shtylyov wrote:
> Hello.
> 
> Jeff Garzik wrote:
>> The following libata changes are queued for 2.6.19:
>>
>> General
>> -------
>> * Increase lba28 max sectors from 200 to 256
> 
> [...]
> 
>> Jeff Garzik:
> [...]
>>       [ATA] Increase lba48 max-sectors from 200 to 256.
> 
>    So was it for LBA28 or for LBA48?
>    As for LBA28, it might be quite dangerous. Particularly, I know that 
> IBM drives used to mistreated 256 as 0 in the past (bumped into that on 
> a 8-year old drive which is still alive though).

That's a typo.  The first description ("lba28") is correct.

Let me know if your IBM drive has problems with current 
libata-dev.git#upstream...

	Jeff



