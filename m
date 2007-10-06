From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: apparent need to blacklist Lexar flash drive in ide-dma.c
Date: Sat, 6 Oct 2007 10:57:11 +0100
Message-ID: <20071006105711.5ea9c0c5@the-village.bc.nu>
References: <Pine.LNX.4.64.0710051600030.29942@banach.math.auburn.edu>
	<20071006002755.37c365bf@the-village.bc.nu>
	<Pine.LNX.4.64.0710051841340.30041@banach.math.auburn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43492 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753997AbXJFJwc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Oct 2007 05:52:32 -0400
In-Reply-To: <Pine.LNX.4.64.0710051841340.30041@banach.math.auburn.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kilgota@banach.math.auburn.edu
Cc: linux-ide@vger.kernel.org

> If you think that the Lexar flash drive ought to function with DMA and you 
> suspect that the problem might be in the box (which it could easily be!) 
> then I would be curious if you have any ideas what one could do about 
> that.

If they didn't wire the CF slot for DMA (as sometimes happens, and the
idea of CF cards with DMA was considered ludicrous not many years ago)
then you'll need to be very very good with a fine soldering iron 8)

Alan
