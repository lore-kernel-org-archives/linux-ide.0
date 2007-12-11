From: Tejun Heo <htejun@gmail.com>
Subject: Re: [stable] [PATCH -stable] libata: kill spurious NCQ completion
 detection
Date: Wed, 12 Dec 2007 08:30:08 +0900
Message-ID: <475F1D80.5040402@gmail.com>
References: <4759E47B.8000108@gmail.com> <20071211225149.GB17643@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:42105 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXLKXaR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Dec 2007 18:30:17 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4476rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 11 Dec 2007 15:30:16 -0800 (PST)
In-Reply-To: <20071211225149.GB17643@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: stable@kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Jeff Garzik <jeff@garzik.org>, Diego Torres <dtorres@coral.dnsalias.org>

Greg KH wrote:
> On Sat, Dec 08, 2007 at 09:25:31AM +0900, Tejun Heo wrote:
>> Spurious NCQ completion detection implemented in ahci was incorrect.
>> On AHCI receving and processing FISes and raising interrupts are not
>> interlocked and spurious interrupts are expected.
>>
>> For example, if an interrupt occurs while interrupt handler is running
>> and the running interrupt handler handles the event the new IRQ
>> indicated, after IRQ handler finishes, it will be executed again
>> because IRQ pending bit is set by the new interrupt but there won't be
>> anything to process.
>>
>> Please read the following message for more information.
>>
>>   http://article.gmane.org/gmane.linux.ide/26012
>>
>> This patch...
> 
> Is this already in Linus's tree?  Is this for 2.6.23-stable, and/or
> older ones too?

Yes, this is in Linus's tree and it's for 2.6.23-stable.  2.6.22 is
affected too so it'll be a good idea to update 2.6.22 too.  Kernels
before 2.6.22 are fine.

Thanks.


-- 
tejun
