From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Libata VIA woes continue. Worked around - *wrong*
Date: Sun, 29 Aug 2004 11:32:16 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41318680.8080102@wasp.net.au>
References: <412F3DEA.2070307@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:1422 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S267330AbUH2Hbn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Aug 2004 03:31:43 -0400
In-Reply-To: <412F3DEA.2070307@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Brad Campbell wrote:
> Ok, so after a couple of reboots with max_sector set to 200 the problem 
> re-occurs.
> 
> It must be something to do with programming the controller or timing or 
> some other issue.
> 
> I have worked around it by putting my 2 raid-0 drives on my spare 
> promise ports, and at UDMA100 with transfers of 2048 sectors they behave 
> fine no matter what I throw at them.

Scratch that. After a couple of days if intensive testing/rebooting and abuse they play up on the
Promise controller in exactly the same failure mode. Just far harder to trigger.

I have removed these bridge board from my system now and thus the problem no longer exists. I'm a
little concerned that this might show itself for other people in the future but then I guess most
sane people buy SATA hard disks rather than re-use old ATA drives with bridge boards.
Cross that bridge if we come to it I guess.

Regards,
Brad (again and again and again)

