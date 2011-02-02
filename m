From: Chris Webb <chris.webb@elastichosts.com>
Subject: Re: IO_PAGE_FAULT from SATA card during boot
Date: Wed, 2 Feb 2011 13:56:44 +0000
Message-ID: <20110202135644.GG11670@arachsys.com>
References: <20110129112456.GA13204@arachsys.com>
 <4D44433F.1040607@gmail.com>
 <20110130015442.GB13204@arachsys.com>
 <AANLkTim7+9WVVJAjbj4pNMB9OKVmf2B+XNQ+exDt9_Tm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alpha.arachsys.com ([91.203.57.7]:33660 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279Ab1BBN4n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Feb 2011 08:56:43 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim7+9WVVJAjbj4pNMB9OKVmf2B+XNQ+exDt9_Tm@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Robert Hancock <hancockrwd@gmail.com> writes:

> On Sat, Jan 29, 2011 at 7:54 PM, Chris Webb <chris.webb@elastichosts.com> wrote:
> > 03:00.0 Class 0106: Device 1b4b:9123 (rev 11) (prog-if 01)
> > ? ? ? ?Subsystem: Device 18ab:9115
> > ? ? ? ?Flags: bus master, fast devsel, latency 0, IRQ 41
> > ? ? ? ?I/O ports at d800 [size=8]
> > ? ? ? ?I/O ports at d400 [size=4]
> > ? ? ? ?I/O ports at e800 [size=8]
> > ? ? ? ?I/O ports at e400 [size=4]
> > ? ? ? ?I/O ports at e000 [size=16]
> > ? ? ? ?Memory at febef800 (32-bit, non-prefetchable) [size=2K]
> > ? ? ? ?Expansion ROM at febf0000 [disabled] [size=64K]
> > ? ? ? ?Capabilities: [40] Power Management version 3
> > ? ? ? ?Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > ? ? ? ?Capabilities: [70] Express Legacy Endpoint, MSI 00
> > ? ? ? ?Capabilities: [100] Advanced Error Reporting
> > ? ? ? ?Kernel driver in use: ahci
> 
> Hmm, so that 03:00.1 device doesn't seem to show up at all? I think
> that these Marvell 9123 cards have a PATA controller integrated as
> well, maybe that has something to do with the issue?

Yes, strange isn't it? There are no other add-on cards in this system, for
what it's worth, and the SATA card is definitely failing, so it does look
like it might be implicated. I have four such boxes, all of which show
identical symptoms.

Is there anything I can do to debug this better?

Cheers,

Chris.
