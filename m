From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
	and IDE
Date: Mon, 04 Aug 2008 15:35:04 +1000
Message-ID: <1217828104.24157.53.camel@pasglop>
References: <1217779055.4179.10.camel@localhost.localdomain>
	 <20080803173941.314edf33@lxorguk.ukuu.org.uk>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53685 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbYHDFfW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Aug 2008 01:35:22 -0400
In-Reply-To: <20080803173941.314edf33@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

On Sun, 2008-08-03 at 17:39 +0100, Alan Cox wrote:
> On Sun, 03 Aug 2008 10:57:35 -0500
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> - For PC class hardware libata covers everything in old IDE and a lot
> more.
> - For the older Mac hardware libata does not have pre PCI Macintosh
> support although it is in progress
> - For certain embedded PPC boards there are some things to sort out with
> IRQ routing on non standards sane configurations using pata_ali in
> particular.
> 
> There is a trend in new hardware to interfaces that simply won't fit old
> IDE so that process of libata only drivers is likely to continue.

Actually, libata is missing anything using the Apple proprietary (I call
it "macio") IDE controller. That includes pretty much all Macs with IDE
not only pre-PCI. IE, it's used for the CD-ROM on the G5's for example
(the disks use sata_svw).

I'm working on it though :-)

> Won't be at KS and I suspect that is true of most of the folks hacking on
> both sets so the right place for discussion would be the net. Right now
> the PPC bits need fixing, and the lack of libata Macio support for the
> moment makes the debate premature.

Hopefully that will be fixed by .28

Cheers,
Ben.


