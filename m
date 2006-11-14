From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Is the SIL 3112 capable of PMP support?
Date: Tue, 14 Nov 2006 16:29:19 +0400
Message-ID: <4559B69F.7080207@wasp.net.au>
References: <455810BC.6090304@wasp.net.au> <45587548.7020808@garzik.org> <45587B3C.3080303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:7570 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S965463AbWKNM3l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Nov 2006 07:29:41 -0500
In-Reply-To: <45587B3C.3080303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Brad Campbell wrote:
>>> I've been planning on doing some testing with PMP's and noticed that 
>>> sata_sil does not support PMP. Is that a hardware limitation or just 
>>> that nobody has implemented it in the driver yet ?
>>
>> Well, it doesn't support hardware context switching.  It probably 
>> supports PMP "the slow way" (one PMP-attached device at a time)
> 
> I doubt 3112 can do pmp even "the slow way".  It doesn't expose FIS 
> interface nor does it have PMP field in its SControl register.  It just 
> can't generate PMP-aware FIS.
> 

That answers the question nicely then. Time to upgrade to some 3124's I guess.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
