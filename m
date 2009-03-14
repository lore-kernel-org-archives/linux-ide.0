From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: Re: [PATCH 02/73] [ide/ata]: add ATA_MWDMA3 and ATA_MWDMA4 masks
Date: Sat, 14 Mar 2009 21:00:06 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142058180.61753@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net> <alpine.BSF.1.00.0903142010100.59456@anduin.net> <49BC041B.4040700@garzik.org> <20090314194245.7d15a9ae@lxorguk.ukuu.org.uk> <49BC0BEB.1020204@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62834 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757356AbZCNUAO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Mar 2009 16:00:14 -0400
In-Reply-To: <49BC0BEB.1020204@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Sat, 14 Mar 2009, Jeff Garzik wrote:
> Alan Cox wrote:
> > > It is the same logical change, and therefore should not be broken up into
> > > 73 tiny patches.
> > 
> > I'd rather the functional changes ones were kept separated for bisection
> > purposes but agreed
> 
> Were there functional changes in this patchset?
> 
> If yes, I missed that.  It looked like all no-functional-change replacement to
> me.

If there were, I've goofed. Where?

--
-erik	http://useofwords.blogspot.com/
