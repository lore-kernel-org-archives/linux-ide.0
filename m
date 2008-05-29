From: Jeff Garzik <jeff@garzik.org>
Subject: Re: RESEND: [PATCH] libata-sff: Fix oops reported in kerneloops.org
 for pnp devices with no ctl
Date: Thu, 29 May 2008 14:25:58 -0400
Message-ID: <483EF536.90801@garzik.org>
References: <20080529161453.24735.805.stgit@core>	<alpine.LFD.1.10.0805290950230.2958@woody.linux-foundation.org> <20080529190235.258d304e@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47869 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021AbYE2S0G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 May 2008 14:26:06 -0400
In-Reply-To: <20080529190235.258d304e@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> maybe_altstatus is crap naming but simply making ata_sff_altstatus fake a
> reply in arbitary cases risks not catching mistakes and could mean we
> don't catch corrupting mistakes which would be very bad indeed.

Please grep the remaining users, IMO you will find that's not really 
true.  After your patch no core users remain, only ones in a few 
scattered drivers that most likely want your logic (or a 
simplified-for-that-controller version thereof).

	Jeff


