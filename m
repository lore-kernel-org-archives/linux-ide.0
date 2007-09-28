From: Mark Lord <liml@rtr.ca>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 16:00:21 -0400
Message-ID: <46FD5D55.4070706@rtr.ca>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<20070928155703.490d7575@the-village.bc.nu>	<46FD1BAD.8020506@garzik.org> <20070928164312.208b8c56@the-village.bc.nu> <46FD2071.2070608@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1179 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647AbXI1UAW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 16:00:22 -0400
In-Reply-To: <46FD2071.2070608@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Jeff Garzik wrote:
> Alan Cox wrote:
>>> This doesn't affect Tejun or anyone else really, but going through 
>>> -mm tends to gum up the works.  Your patches wind up not applying to 
>>> libata#upstream, in which case they get dropped and I assume Andrew 
>>> or someone will resend usable versions.
>>
>> Its the only way to get testing done and get them into distributions in
>> time.
> 
> Not true...  libata gets auto-propagated into -mm, and Andrew pulls 
> regularly.

I believe the point was that getting things into libata is glacial
compared with getting them into -mm.  Witness the PMP patchset.

Cheers
