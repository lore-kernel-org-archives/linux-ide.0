From: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Tue, 22 Feb 2005 14:09:08 +0400
Message-ID: <421B04C4.2060108@wasp.net.au>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com> <42158774.9030406@wasp.net.au> <4216BD10.2070008@wasp.net.au> <42196345.5040501@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wasp.net.au ([203.190.192.17]:1206 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S262255AbVBVKJY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Feb 2005 05:09:24 -0500
In-Reply-To: <42196345.5040501@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Andy Warner <andyw@pobox.com>, Jeff Garzik <jgarzik@pobox.com>

Brad Campbell wrote:
> Now I have also replaced the PSU with a much better specced unit, so 
> that may have also been a contributing factor to the oops. (The 12v rail 
> was running on the edge).
> 
> If this rebuild this morning gets through then I'll go back to the old 
> kernel that was oopsing and try it again to compare.
> 

Ok, I have beat on all the kernels I have available. 2.6.10-bk10, 2.6.11-rc4-something, 
2.6.11-rc4-bk6 and 2.6.11-bk8 all with the libata-dev patches of the time, and none of them oops 
now. It *must* have been a flaky PSU.
SMART polling does cause the occasional drive timeout, causing the drive to be booted from the 
array, but nothing fatal and I have to be seriously hammering the disks with both I/O and SMART 
requests to get it to occur.

Sorry for the noise.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
