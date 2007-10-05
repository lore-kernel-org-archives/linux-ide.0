From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: apparent need to blacklist Lexar flash drive in ide-dma.c
Date: Sat, 6 Oct 2007 00:27:55 +0100
Message-ID: <20071006002755.37c365bf@the-village.bc.nu>
References: <Pine.LNX.4.64.0710051600030.29942@banach.math.auburn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54001 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756913AbXJEXXP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Oct 2007 19:23:15 -0400
In-Reply-To: <Pine.LNX.4.64.0710051600030.29942@banach.math.auburn.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kilgota@banach.math.auburn.edu
Cc: linux-ide@vger.kernel.org

> "Ultra 33/66" (I would assume this means UDMA 33 or 66)

If it is cabled for it, DMA capable CF is quite new and that seems to
cause problems sometimes.

> Under the circumstances, I am of course uncertain whether the "ALL" is 
> appropriate or not, but I suspect it is. So perhaps you would like to add 
> this entry to the blacklist.

The problem is almost certainly your box not the flash drive so ide=nodma
is probably most appropriate. It really ought to handle both flash drives
however.

ide=nodma seems the right answer.

Alan
