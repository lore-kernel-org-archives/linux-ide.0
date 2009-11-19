From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 20:03:09 +0100
Message-ID: <200911192003.09675.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <20091119182132.5155f819@lxorguk.ukuu.org.uk> <4B0590A2.9050306@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:8012 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbZKSTDr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 14:03:47 -0500
In-Reply-To: <4B0590A2.9050306@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Thursday 19 November 2009 19:38:26 Sergei Shtylyov wrote:
> Alan Cox wrote:
> 
> >>Fixed where?  I posted the patch as soon as I noticed the problem.
> 
> > Its not posted because unlike you I don't post patches as soon as I
> > notice them. I test them first. Which is why for example I discovered the
> > bug in the drivers/ide one. Did you check the vendor driver and then
> > stick 40 and 80 wire cables on the system to check the bits on a 3x2N ?
> 
> > No I didn't think so. You see if you had you'd have discovered something
> > else. You'd have discovered another bug in the old IDE one. The driver
> > code for these chips isn't reliable and doesn't work at all in some cases.
> 
> >>Told me about it?  
> 
> > Yes - or do you only write replies not read them ?
> 
> > NAK - the patch is inadequate.
> 
>     No, it was. And yours isn't quite.
> 
> > The procedure in the vendor driver does
> > appear to work on the newer chips however.
> 
> > Probably worth double checking
> > the HPT37x and seeing if it needs the same debounce delays.
> 
>     All vendor drivers I have do call StallExec(10) when detecting cable 
> type, so need to add the delay to pata_hpt37x too.

Given this I take back my ACK to Alan's patch.

>     I'd suggest to address the delay by another, separate patch to both 
> pata_hpt37x and pata_hpt3x2n drivers, and accept Bart's original patch for 
> bit reversing...

Yes.

-- 
Bartlomiej Zolnierkiewicz
