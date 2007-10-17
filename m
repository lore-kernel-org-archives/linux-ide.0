From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_via(?): cdrom is recognized as hard drive
Date: Wed, 17 Oct 2007 17:58:25 +0100
Message-ID: <20071017175825.1b0e0ecb@the-village.bc.nu>
References: <47162BD8.1010109@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51279 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754621AbXJQQzv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Oct 2007 12:55:51 -0400
In-Reply-To: <47162BD8.1010109@msgid.tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-ide@vger.kernel.org

On Wed, 17 Oct 2007 19:35:52 +0400
Michael Tokarev <mjt@tls.msk.ru> wrote:

> And one more issue with my attempt to switch
> from via82cxxx to pata_via.
> 
> I noticied that on all machines I tried to convert,
> CD-Rom devices are recognized as hard disks.

Thats deeply weird.

> But with pata_via and 2.6.23, it's handled by sd_mod:

CD's are handled by sr_mod. I suspect this is actually arising out of the
fact both devices seem to be falling over each other after the SRST.

Can you stick all this in a bugzilla and assign it to me so it doesn't
get lost.

Alan
