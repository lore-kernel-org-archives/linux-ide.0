From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Please help me to understand the interaction of the various ATA
 drivers
Date: Thu, 30 Apr 2015 11:43:06 +0100
Message-ID: <20150430114306.37cb3425@lxorguk.ukuu.org.uk>
References: <1430343517.30346.10.camel@afalanga4.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:33883 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbbD3KnY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Apr 2015 06:43:24 -0400
In-Reply-To: <1430343517.30346.10.camel@afalanga4.micron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Andy Falanga (afalanga)" <afalanga@micron.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Wed, 29 Apr 2015 21:38:41 +0000
"Andy Falanga (afalanga)" <afalanga@micron.com> wrote:

> Jeff,
> 
> I don't know if you're still the maintainer of these drivers but you're
> listed as the original author of the code in the 2.6 kernel which I'm

Think Jeff is mostly off doing wonderous things with Bitcoin. 

> working on modifying.  I have to write a driver which I can expose
> access to the various HBA and Port registers for an AHCI class HBA.  In
> addition, this driver must act as a pass through driver for my clients
> to be able to execute ATA commands.  I'd like for it to be a true pass
> through driver and not have to run through the kernel's schedules and
> such, but that's another discussion.

Then you probably need to make the existing kernel drivers skip whatever
specific device you are driving directly (I assume for things like
validation ?)

> My question for you is simply, how are these various drivers supposed to
> work together?  On the VM which I'm doing my development, I see the
> following from lsmod:
> 
> # lsmod
> ...
> ahci                      41208         2
> pata_acpi                  3701         0
> ata_generic                3837         0
> ata_piix                  24409         1

ata_generic is a bus mastering driver for PCI IDE class devices. In your
case its been loaded for some reason but is not being used

pata_acpi is a driver for ACPI described generic interfaces, and again is
not being used

ata_piix is a driver specifically for Intel PIIX/ICH interfaces in legacy
mode and does seem to be getting used, so presumably your virtual machine
has at least one legacy mode PIIX or ICH emulated on it

ahci is a driver for controllers that are AHCI class, or match a few
identifiers for AHCI controllers not declaring themselves AHCI class (eg
those that try and hide from Windows AHCI drivers so proprietary raid
products can be used with them on Windows)

So I think you'd need to

a) modify ahci to ignore your specific device in its probe method
b) write a simple driver so you can poke the ports and do any needed DMA

Alan


