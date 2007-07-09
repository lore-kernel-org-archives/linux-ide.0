From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CHRP PCI fixup for Pegasos IDE (looking for testers)
Date: Mon, 9 Jul 2007 16:06:56 +0100
Message-ID: <20070709160656.2666ef61@the-village.bc.nu>
References: <46924C27.8020100@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45839 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750796AbXGIPAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 11:00:35 -0400
In-Reply-To: <46924C27.8020100@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: linux-ide@vger.kernel.org

On Mon, 09 Jul 2007 15:54:31 +0100
Matt Sealey <matt@genesi-usa.com> wrote:

> Hi guys,
> 
> Just a heads up here, I hammered out this little bit of code over the
> weekend which "solves" the Pegasos IDE problem by making PCI native
> mode work like PCI native mode should (it tweaks the ISA bridge to
> steer both IDE IRQs to 14)
> 
> http://www.powerdeveloper.org/files/Pegasos/ide_fixup.c
> 
> I definitely need someone to test it though. I can't compile it and
> I can't run it on a Pegasos here, and I am not sure if the fix is
> being done early enough (Alan said "before pci_setup_device"..).

Close but no cookie. The fixup is done at a sensible point, the fixup
makes sense.

The ifdef is wrong (could be modular PATA_VIA)
The viaide->irq check is iffy as this is the PCI IRQ rather than the
legacy one. Probably you should just force it to 14 if you know that is
the correct behaviour.

Otherwise looks a good basis. If it works sanely then I'd bump the other
fix out of the old IDE driver and use the quirk fixup for both.

Alan
