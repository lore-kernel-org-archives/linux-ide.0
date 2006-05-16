From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git-patches] EH, irq-pio merge and NCQ patches
Date: Tue, 16 May 2006 11:11:10 +0900
Message-ID: <446934BE.8090804@gmail.com>
References: <20060515120808.GA23124@htj.dyndns.org> <4468A0A8.2070300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:21022 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751045AbWEPCLQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 22:11:16 -0400
Received: by wr-out-0506.google.com with SMTP id i32so1018584wra
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 19:11:15 -0700 (PDT)
In-Reply-To: <4468A0A8.2070300@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> I didn't add DMA engine stopping to ata_bmdma_freeze() in this series.
>> When BMDMA engine is turned off, all status bits go too.  However, the
>> status is used by BMDMA EH to report and to recognize host bus error
>> reprsented as timeout.
>>
>> To make all of them work, the BMDMA status needs to be stored in
>> ata_bmdma_freeze() and used in EH, which is currently a bit difficult
>> to implement for generic BMDMA.  I think we can resolve this later.
> 
> Agree re storing BMDMA status.  The very next operation needs to be 
> DMA-stop, though.  Otherwise shadow register block isn't accessible. And 
> you must still check BMDMA status -after- stopping DMA, too (that 
> doesn't invalidate your logic quoted above, of course).

I see.  I think this can be done by making all BMDMA related stuff into 
a layer between highlevel libata and BMDMA LLDDs.  We can move all IO 
ops into that layer and newer controllers like ahci, sata_sil24 and 
sata_mv don't have to care about them.  Have yet to think about how to 
do it in simple way though, such that changes to BMDMA LLDDs are minimal.

> Pulled into #upstream and other branches, and pushed to kernel.org. 
> Please check and make sure everything looks OK, after kernel.org 
> finishes mirroring to the outside world.

I glanced over them and diffed with my own tree.  All look good & dandy.

> BTW, it would be nice if you would start with branch #sii-irq when you 
> are updating the sata_sil interrupt handling path.

I certainly can, but I'm not sure it's a good idea to do it.  Most 
likely, it will end up in another rewriting of the rewritten irq handler 
(commit-wise, it will be merge-sii-irq then rewrite sii-irq).  The new 
one in hp-LLDD-prep uses BMDMA2 to cut down on IO access and also makes 
use of the fact that sata_sil uses ATA_DMA_INTR bit to indicate IRQ 
pending even when non-DMA command is in progress, so the whole structure 
is somewhat different from the one in sii-irq.

 > And eventually we want to push #sii-lbt too.

Yeap, I looked at that one, too.  But, IIRC, the test result wasn't too 
positive.  Am I remembering correctly?

-- 
tejun
