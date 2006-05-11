From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 08/11] sata_sil: convert to new EH
Date: Fri, 12 May 2006 00:45:45 +0900
Message-ID: <44635C29.6080903@gmail.com>
References: <11473536881889-git-send-email-htejun@gmail.com>	 <1147357322.26130.17.camel@localhost.localdomain>	 <44634CB6.80804@gmail.com> <1147362385.26130.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:57940 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030287AbWEKPpw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:45:52 -0400
Received: by wr-out-0506.google.com with SMTP id i12so395288wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:45:51 -0700 (PDT)
In-Reply-To: <1147362385.26130.42.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Iau, 2006-05-11 at 23:39 +0900, Tejun Heo wrote:
>> I'm not sure what you mean by synchronization.  But, freezing is indeed
>>  for shutting the chip up.  If the port is frozen, EH doesn't touch
>> active qcs nor tries to issue new command.  The port is thawed/used only
>> after the port & device are put into known good state via successful
>> reset.  Is this what you're talking about?
> 
> Sort of. I wanted to point out that this can occur
> 
> 	IRQ is issued on chip
> 
> 	->freeze
> 	returns
> 
> 	->intr finally arrives and is serviced

I see.  As far as EH is concerned, this should be okay.  Once qc
ownership is transferred, irq handler cannot access the qc
(ata_qc_from_tag() prevents it) and has no way other than handling it as
a spurious interrupt or HSM violation.  But, it sounds like it could
result in screaming IRQ for controllers without IRQ pending bit.  Could
it?  If so, maybe unconditional irq clearing in ata_interrupt() should
be resurrected to handle such conditions.

-- 
tejun
