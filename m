From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Sil 3124: "softreset failed (SRST command error)"
Date: Mon, 18 Oct 2010 22:36:03 +0300
Message-ID: <20101018193606.88DDB7F103@oliivipuu.dnainternet.net>
References: <i8vbcg$4hc$1@dough.gmane.org> <i93t9u$c60$1@dough.gmane.org> <i9700c$g3o$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sypressi.dnainternet.net ([83.102.40.135]:43398 "EHLO
	sypressi.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932965Ab0JRTnn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Oct 2010 15:43:43 -0400
In-Reply-To: <i9700c$g3o$1@dough.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Sanders <jeremy@jeremysanders.net>
Cc: linux-ide@vger.kernel.org

On Thursday 14 October 2010 14:19:07 Jeremy Sanders wrote:
> Jeremy Sanders wrote:
> > Tim Small wrote:
> >> Bad PCI express to PCI-X bridge chip maybe, or maybe the Linux bug
> >> lies
> >> there?  I have seen cards with 2 3132s on instead (and a PCI express
> >> bridge), perhaps it'd be worth trying one of those?
> > 
> > It looks like the problem was an incompatibility with the Intel
> > motherboard.
> > 
> > It seems to work fine in an old foxconn Athlon 64 motherboard (in the
> > PCIex graphics slot when using a PCI card for video).
> 
> Unfortunately it doesn't look like it works that well :-(
> 
> Read speeds to a standard drive are great - 70 MB/s.
> 
> Write speeds are awful - they range on one system at 17 MB/s down to a more
> modern system at 1.7 MB/s! There is no CPU load.

For the record, I encountered the same issues some time ago.

I couldn't get a SiI 3124 based PCI-E card to work on an IIRC NVIDIA based 
(AMD) motherboard: I encountered the "softreset failed" messages.

I had a friend try the card on another system, and this time it reportedly 
detected the drives successfully but the performance was bad.

> I assume this is a problem with the PCIe bridge. There are no errors or
> warnings given. I couldn't get MSI interrupts to work on this system.
> 
> Time to throw the card away I think!

-- 
Anssi Hannula
