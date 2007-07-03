From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Tue, 3 Jul 2007 14:53:34 +0100
Message-ID: <20070703145334.2bc9b773@the-village.bc.nu>
References: <467C689E.3050800@genesi-usa.com>
	<20070623103349.23cad9b7@the-village.bc.nu>
	<467CE8FA.2040304@genesi-usa.com>
	<20070623105344.3ece6db1@the-village.bc.nu>
	<467CF1E6.8000905@genesi-usa.com>
	<4689FBCB.90608@gmail.com>
	<468A04A0.1020003@genesi-usa.com>
	<20070703131736.5ddc0b89@the-village.bc.nu>
	<468A41CC.6030203@genesi-usa.com>
	<20070703143809.5064fa35@the-village.bc.nu>
	<468A5223.4050906@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:35435 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753212AbXGCNr2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 09:47:28 -0400
In-Reply-To: <468A5223.4050906@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Tue, 03 Jul 2007 14:41:55 +0100
Matt Sealey <matt@genesi-usa.com> wrote:

> The chip isn't in legacy mode. We never set it to legacy mode. Legacy mode would not work.
> It's set to native mode. However the PCI class code does not reflect this :)

By the time the OS has booted to the point the IDE layer runs the PCI
class code has been read and pci->resource[] arrays have been set up for
the legacy addresses not the PCI BAR ones.

So with a current kernel at the point the pci header quirks run you can
load the PCI bar values back into the pci->resource[] array. The code is
designed to allow for this. Unfortunately libata then ignores the values
provided because some changes haven't been made that have been pending
for ages. I'll push the relevant trivial bits to Andrew today after
testing them

> The old Via driver checked the host controller configuration space, rather
> than trust the PCI class code and the ATA specs, it seems? Well, you would
> know since you wrote it? 

Not those bits.

The intended code flow is this

	pci probe
		early quirk
		class IDE legacy
			Load the resources 0 to 3 specially
		header quirk

	resource tree reserved	

	libata
		Use resource 0-3 for legacy or native

Right now the last bit is using hardcoded numbers that need fixing up.

Alan
