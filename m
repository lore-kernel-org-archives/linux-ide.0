From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [SATA] max-sect and sii-m15w branches merged
Date: Thu, 10 Aug 2006 08:00:44 -0400
Message-ID: <44DB1FEC.8090101@garzik.org>
References: <44DB106C.6090504@garzik.org> <44DB17C4.2070908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:2525 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161192AbWHJMAs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 08:00:48 -0400
In-Reply-To: <44DB17C4.2070908@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> I just merged the max-sect and sii-m15w branches into the upstream 
>> branch.
>>
>> This means that the following two changes are queued for 2.6.19:
>>
>> * increase max sectors from 200 to 256 (for lba28)
>> * better mod15write support for sata_sil
> 
> Are we ready for m15w-iterate-over-large-write patch?  It has been used 
> by many people for quite some time and works great.  If you think we can 
> merge that patch, I'll port it over #upstream.

I would prefer that be considered after 2.6.19, since sii-m15w will be 
first appear in 2.6.19.

Feel free to send it along, if you wish.  I'll keep it in a separate 
branch, and make sure it appears in #ALL (and thus Andrew's -mm tree).

	Jeff



