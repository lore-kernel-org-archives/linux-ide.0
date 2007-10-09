From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Mon, 08 Oct 2007 22:09:37 -0400
Message-ID: <470AE2E1.5060208@garzik.org>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<46FD1C4A.8010101@garzik.org>	<46FD306C.3050205@gmail.com>	<46FD5DE1.8000206@rtr.ca> <20070928220309.7c9ed816@the-village.bc.nu> <46FDADD9.9050007@garzik.org> <46FE45CE.1050007@rtr.ca> <4700EA52.10701@garzik.org> <47018CEC.6060203@gmail.com> <47024001.6090306@garzik.org> <47024257.4050606@rtr.ca> <470247E1.2070905@garzik.org> <470805F1.6050303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60833 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450AbXJICJr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Oct 2007 22:09:47 -0400
In-Reply-To: <470805F1.6050303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> A few days before that, both PMP and SAS /were/ slated for 2.6.24, and
>> after I fix the design problems, they will be again.
>>
>> One way or another, upstream will /not/ be doing polling PMP in 2.6.24.
> 
> Just an update to let you know that I've been working on it.  sata_sil24
> works okay but ahci still craps itself after resetting downstream ports.

Thanks for your patience and perseverance.

It looks like it would be too difficult to get SAS PMP working for 
2.6.24 merge window open, so I think it is only fair to rescind my 
assertion of "polling PMP not in 2.6.24 release."

Removing the polling remains a design requirement for SAS, but the more 
I look at old-EH-encrusted libsas, the more work I feel it needs before 
its ready for PMP.  Sorry.

	Jeff



