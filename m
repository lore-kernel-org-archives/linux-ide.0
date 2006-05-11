From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/11] sata_sil: convert to new EH
Date: Thu, 11 May 2006 23:39:50 +0900
Message-ID: <44634CB6.80804@gmail.com>
References: <11473536881889-git-send-email-htejun@gmail.com> <1147357322.26130.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:8201 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751799AbWEKOj6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:39:58 -0400
Received: by wr-out-0506.google.com with SMTP id i28so151936wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:39:57 -0700 (PDT)
In-Reply-To: <1147357322.26130.17.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Hello, Alan.

Alan Cox wrote:
> On Iau, 2006-05-11 at 22:21 +0900, Tejun Heo wrote:
>> Convert sata_sil to new EH.  As these controllers have hardware
>> interrupt mask and are known to have screaming interrupts issues, use
>> hardware IRQ masking for freezing.  sil_freeze() masks interrupts for
>> the port and sil_thaw() unmasks them.  As ports are automatically
>> frozen before probing reset, there is no need to initialize interrupt
>> masks sil_init_onde().  Remove related code.
> 
> Word of caution. When you mask an interrupt on chip like this remember
> that an IRQ may still be pending so the freeze is *not* safe for
> synchronization, merely for shutting the chip up. Otherwise this patch
> set looks pretty nice.

I'm not sure what you mean by synchronization.  But, freezing is indeed
 for shutting the chip up.  If the port is frozen, EH doesn't touch
active qcs nor tries to issue new command.  The port is thawed/used only
after the port & device are put into known good state via successful
reset.  Is this what you're talking about?

> Patchsets all look good with my PATA hat on. The dev->ap stuff tidies up
> the ->data_xfer methods I need to add and the other stuff fits nicely.

Great.  I haven't removed @ap from methods in ata_port_operations() yet
because the change affects all LLDDs and later ata_link addition would
require another sweep all over again.  I think the change can wait until
EH stuff settles down.

Thanks for reviewing this.

-- 
tejun
