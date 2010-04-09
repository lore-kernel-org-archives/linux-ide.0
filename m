From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Fri, 9 Apr 2010 19:53:15 +0100
Message-ID: <20100409195315.7f929440@lxorguk.ukuu.org.uk>
References: <eo2197-4lb.ln1@tux.abusar.org.br>
	<4bbde1ea.c701be0a.60ec.0270@mx.google.com>
	<20100408150920.5689564b@lxorguk.ukuu.org.uk>
	<4bbde4f7.1702be0a.5f6c.028e@mx.google.com>
	<4BBE6CA6.1010808@gmail.com>
	<4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
	<n2x51f3faa71004081909la494824ds60fcb5d26b53027a@mail.gmail.com>
	<4bbe8f84.1502be0a.0f89.0f16@mx.google.com>
	<o2i51f3faa71004081952s68d4861w28b9b73da284c91d@mail.gmail.com>
	<4BBEFDA1.5050607@buttersideup.com>
	<z2x51f3faa71004090747n908c389ez17cba33301c4c998@mail.gmail.com>
	<20100409160707.6116965e@lxorguk.ukuu.org.uk>
	<4BBF57D8.6040800@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48852 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755204Ab0DIStF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2010 14:49:05 -0400
In-Reply-To: <4BBF57D8.6040800@buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, =?ISO-8859-14?B?ROJuaWVs?= Fraga <fragabr@gmail.com>, linux-ide@vger.kernel.org

> Using DECLARE_PCI_FIXUP_SUSPEND etc?  I'll see if I can get some time to
> have a go at this.  The hardware I have access to without AHCI BIOS
> options are Dell Poweredge R200s and R300s.

Yep.

> As Robert said, the "off-by-default + if it breaks, you get to keep both
> pieces" policy is what I had in mind, and I think this should go into
> arch/x86/pci/fixup.c ?  Any obvious pit-falls to avoid?

There are probably two things to watch - you need to do the fixup early
enough (I think as a header fixup) that the resources are correctly seen,
and the chip docs say that if you hide one of the interfaces you can't
unhide it - which shouldn't be a problem in your case.

Alan
