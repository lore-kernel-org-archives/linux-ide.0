From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git-patches] EH, irq-pio merge and NCQ patches
Date: Mon, 15 May 2006 11:39:20 -0400
Message-ID: <4468A0A8.2070300@pobox.com>
References: <20060515120808.GA23124@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:1471 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751489AbWEOPjX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 11:39:23 -0400
In-Reply-To: <20060515120808.GA23124@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> I didn't add DMA engine stopping to ata_bmdma_freeze() in this series.
> When BMDMA engine is turned off, all status bits go too.  However, the
> status is used by BMDMA EH to report and to recognize host bus error
> reprsented as timeout.
> 
> To make all of them work, the BMDMA status needs to be stored in
> ata_bmdma_freeze() and used in EH, which is currently a bit difficult
> to implement for generic BMDMA.  I think we can resolve this later.

Agree re storing BMDMA status.  The very next operation needs to be 
DMA-stop, though.  Otherwise shadow register block isn't accessible. 
And you must still check BMDMA status -after- stopping DMA, too (that 
doesn't invalidate your logic quoted above, of course).


> The series can be browsed at the following URL.
> 
> 	http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=for-jeff
> 
> If you're satisfied with the updates, please pull from.
> 
> 	git://htj.dyndns.org/libata-tj for-jeff

Pulled into #upstream and other branches, and pushed to kernel.org. 
Please check and make sure everything looks OK, after kernel.org 
finishes mirroring to the outside world.

Thanks.

BTW, it would be nice if you would start with branch #sii-irq when you 
are updating the sata_sil interrupt handling path.  And eventually we 
want to push #sii-lbt too.

	Jeff


