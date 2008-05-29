From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RESEND: [PATCH] libata-sff: Fix oops reported in kerneloops.org
 for pnp devices with no ctl
Date: Thu, 29 May 2008 12:46:24 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805291245330.2958@woody.linux-foundation.org>
References: <20080529161453.24735.805.stgit@core> <alpine.LFD.1.10.0805290950230.2958@woody.linux-foundation.org> <20080529190235.258d304e@core> <483EF536.90801@garzik.org> <20080529193813.4bc0a677@core>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53039 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751081AbYE2Tqj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 15:46:39 -0400
In-Reply-To: <20080529193813.4bc0a677@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org



On Thu, 29 May 2008, Alan Cox wrote:
> 
> I did check them all and review them and read the documentation right
> back to the original 1010 controller behaviour. I stand by my comment.

Your comment is pointless.

The old function oopsed for the case that you worry about. That is WORSE 
than anything else you can come up with. There is absolutely zero upside 
to using that old and broken thing.

		Linus
