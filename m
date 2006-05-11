From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/11] sata_sil: convert to new EH
Date: Fri, 12 May 2006 01:10:27 +0900
Message-ID: <446361F3.4040505@gmail.com>
References: <11473536881889-git-send-email-htejun@gmail.com>	 <1147357322.26130.17.camel@localhost.localdomain>	 <44634CB6.80804@gmail.com>	 <1147362385.26130.42.camel@localhost.localdomain>	 <44635C29.6080903@gmail.com> <1147363974.26130.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:51058 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030302AbWEKQKd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:10:33 -0400
Received: by wr-out-0506.google.com with SMTP id i12so401045wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:10:33 -0700 (PDT)
In-Reply-To: <1147363974.26130.56.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2006-05-12 at 00:45 +0900, Tejun Heo wrote:
>> a spurious interrupt or HSM violation.  But, it sounds like it could
>> result in screaming IRQ for controllers without IRQ pending bit.  Could
>> it?  If so, maybe unconditional irq clearing in ata_interrupt() should
>> be resurrected to handle such conditions.
> 
> Not sure how the sil24 handles it but the PATA chips seem (its not well

I'm pretty sure most modern controllers including sil24 drops IRQ once
masked.  Also, as they have IRQ pending bit, such IRQs can easily be
cleared.

> documented) to drop any pending interrupt once it is masked, thus you
> would take the interrupt once (or maybe 2 or 3 times in weird obscure
> corner cases on a pentium II SMP box) and then no more.

So, they will drop interrupt after several unhandled IRQs at most even
if the driver doesn't read TF status register to clear it, right?

-- 
tejun
