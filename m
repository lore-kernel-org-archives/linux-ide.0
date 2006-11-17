From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2] libata: make sure IRQ is cleared after ata_bmdma_freeze()
Date: Fri, 17 Nov 2006 12:44:48 +0900
Message-ID: <455D3030.8060702@gmail.com>
References: <20061117030621.GD2184@htj.dyndns.org> <20061117030750.GE2184@htj.dyndns.org> <455D2C3E.8010509@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:52164 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424245AbWKQDo5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Nov 2006 22:44:57 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1212917nfa
        for <linux-ide@vger.kernel.org>; Thu, 16 Nov 2006 19:44:56 -0800 (PST)
In-Reply-To: <455D2C3E.8010509@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>>
>> Note that ->freeze() handler is always called under ap->lock held and
>> irq disabled.  Even if CTL manipulation causes stuck IRQ, it's cleared
>> immediately.  This should be safe (enough) even in SMP environment.
>> More correct solution is to mask the IRQ from IRQ controller but that
>> would be an overkill.
> 
> Could this possibly lead to a "nobody cared" message from the IRQ layer,
> followed by the kernel then disabling this IRQ?
> 
> Just wondering, because that's what can happen if we trigger an IRQ
> but then don't report "handled" for it from our interrupt handler.

Nobody cared triggers after a LOT of interrupts are consecutively 
unhandled, so this is safe for UP and safe enough for SMP, IMHO.  Also, 
that's how it has been done in ata_irq_on().  Without this patch, my 
ich7 in native pci mode w/ shared IRQ does cause nobody cared.  That's 
why this patch is written.

> I'm puzzling through a similar situation in sata_qstor right now,
> and the fix will involve manipulating the NIEN bit, with the same risk.

Well, I guess, testing is the only way to find answer.  :-(

-- 
tejun
