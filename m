From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: [PATCH] ide: disable dma for transcend CF
Date: Tue, 20 Jun 2006 12:29:29 +0100
Message-ID: <E1FseQD-0001Tn-00@chiark.greenend.org.uk>
References: <200606201452.37905.kirr@mns.spb.ru>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chiark.greenend.org.uk ([193.201.200.170]:53448 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S932586AbWFTL3r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jun 2006 07:29:47 -0400
In-Reply-To: <200606201452.37905.kirr@mns.spb.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Kirill Smelkov <kirr@mns.spb.ru> wrote:

> but if dma is turned on i get a lot of errors::
> 
>     hdc: dma_timer_epiry: dma_status == 0x21
>     hdc: DMA timeout error
>     hdc: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
>     ide: failed opcode was: unknown

Are you sure that your CF adapter has the DMA lines hooked up? See 
http://lkml.org/lkml/2006/5/23/198 for instance - IIRC, the kernel has 
no way of telling whether the failure is because the card supports DMA 
and the adapter doesn't, or whether the card is lying. If it's the 
former, the card shouldn't be blacklisted.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
