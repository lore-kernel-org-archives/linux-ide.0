From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Wed, 16 Feb 2005 17:47:58 -0500
Message-ID: <4213CD9E.9040703@pobox.com>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59035 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262107AbVBPWsN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Feb 2005 17:48:13 -0500
In-Reply-To: <20050216154033.I10699@florence.linkmargin.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: Brad Campbell <brad@wasp.net.au>, linux-ide@vger.kernel.org

Andy Warner wrote:
> Brad Campbell wrote:
> 
>>[...]
>>Actually, I'm not sure without the libata dev patch as that removes SMART support, and I'm not 
>>convinced that my smartd polling every 20 minutes does not have something to do with it. All I know 
>>is the older kernel seems to cope. We'll see. 320 minutes left on this rebuild. I expect it will be 
>>done in the morning if all goes according to plan. (With the 2.6.11 kernel it never survived past 
>>about 25% rebuilt)
> 
> 
> Can you find time to try it without smartd active ?
> You report running a uni-processor system, and I have only
> seen PIO problems with (fast) SMP systems in my testing,
> but I am forming the opinion that libata-PIO functions
> are in need of a minor overhaul.
> 
> I have seen issues where port activity monopolised
> data-paths/arbitration inside chipsets such that the
> PIO operations would appear to time out. Since you're
> doing a raid rebuild, perhaps the I/O load is causing
> something similar to occur.

Does the PIO code deviate from the ATA/ATAPI-[4567] host state machine 
somehow?

Or is it just that newer SATA-emulating-PATA chips have trouble with it?

	Jeff


