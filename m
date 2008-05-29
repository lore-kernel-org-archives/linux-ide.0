From: Jeff Garzik <jeff@garzik.org>
Subject: Re: RESEND: [PATCH] libata-sff: Fix oops reported in kerneloops.org
 for pnp devices with no ctl
Date: Thu, 29 May 2008 15:31:42 -0400
Message-ID: <483F049E.2090809@garzik.org>
References: <20080529161453.24735.805.stgit@core>	<alpine.LFD.1.10.0805290950230.2958@woody.linux-foundation.org>	<20080529190235.258d304e@core>	<483EF536.90801@garzik.org> <20080529194238.36458a46@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42545 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbYE2Tbr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 May 2008 15:31:47 -0400
In-Reply-To: <20080529194238.36458a46@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>> Please grep the remaining users, IMO you will find that's not really 
>> true.  After your patch no core users remain, only ones in a few 
>> scattered drivers that most likely want your logic (or a 
>> simplified-for-that-controller version thereof).
> 
> That said if you want to be clearer we can hide the altstatus function
> internally and only export an ata_sff_dma_sync() which does go *BANG* if
> you call it with no altstatus (where you would immediately violate DMA
> timing rules)
> 
> Want me to roll a patch in that style ?

Works for me...


