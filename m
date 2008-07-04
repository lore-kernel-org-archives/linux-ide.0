From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_it821x completely broken
Date: Fri, 4 Jul 2008 22:46:36 +0100
Message-ID: <20080704224636.352e4a7b@lxorguk.ukuu.org.uk>
References: <200807042153.56644.linux@rainbow-software.org>
	<20080704212204.7c94ca7c@lxorguk.ukuu.org.uk>
	<200807042339.02444.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49723 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752885AbYGDWE2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jul 2008 18:04:28 -0400
In-Reply-To: <200807042339.02444.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alan@redhat.com, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

> It complains pretty loudly - something like 3 screens (with framebuffer at 
> 1024x768) of errors like this:

Interesting. I need to have a poke at that - it used to work fine but
I've not tested the 821x recently and the HPA code has changed. It
shouldn't be issuing HPA commands in the first place. Added to the TODO
list. The HPA is supposed to be cleared by the driver setup code but if
the newer firmware is faking it then I wonder what it does if we allow
the command through.

> It's BIOS v1.7.1.94, firmware 02093030. Haven't tried waiting for the rebuild 
> to complete. It will probably take ages for 400GB drives. I'll try with some 
> much smaller drives (something <1GB).

Thanks
