From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Wed, 3 Oct 2007 17:30:12 -0600
Message-ID: <20071003233012.GA8721@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-dub.bigfish.com ([213.199.154.10]:44564 "EHLO
	mail104-dub-R.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751615AbXJCXxh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 19:53:37 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <mkp@mkp.net>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, info-linux@geode.amd.com

Hi Martin - make sure you CC me on responses, I'm not on linux-ide.

> I'll try this later and see what comes up.  But I'm not sure I see the
> advantage of having two ways to configure the 5536.

There are multiple ways to do it, simply because of the way the architecture
is designed underneath.  Thats why we enforce the policy
of using the PCI mechanism when ever we can to encourage everybody on the
same page.

> Anyway.  That's my personal take on it.  If there's a general
> consensus that the timings should be in pata_amd.c then so be it.

No - I think if we're going to have the different timings, they should
be in their own driver, not bothering the other users of this IP.

> The board I'm using has a BIOS which exposes the IDE registers in PCI
> space but doesn't appear to listen when they are written to.  I'm
> hoping that will get fixed eventually.

Thats a bug, pure and simple.  If the PCI space is there, but the IDE
registers are not - then you are deep into breakage mode, and you need
to yell very loud and very long at your BIOS vendor. 

In the standard AMD VSA, writeos to PCI space 0x48 (DTC), 0x49 (CAST) and 
0x50 (ETC) should work - and the change should be immediately reflected
in the MSR.   You can see for yourself, the code is open:

http://dev.laptop.org/git?p=geode-vsa;a=blob;f=sysmgr/pci_wr.c;h=9a984998ba3b8ed06358a85faf16a6ddebdad4a9;hb=HEAD#l359

Not all BIOS vendors follow the AMD model, but most do.

> PS. So what's the story wrt. a PRD length of 0?

Alan is right, the NSC/Cyrix block had issues.  Thats why when we started
on the 5536, we searched around in AMD's attic, and found
the 8111 IDE block under an pile of old clothes and Life magazines.
We dusted it off and stuck it in.  So this fundamentally different
silicon then before.

I believe that the datasheet is correct - at least, there aren't any
errata, and we've been pretending to be a AMD74xx for quite a while now
with no ill effects in this regard.

Jordan
-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.


