From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Sat, 23 Jun 2007 10:53:44 +0100
Message-ID: <20070623105344.3ece6db1@the-village.bc.nu>
References: <467C689E.3050800@genesi-usa.com>
	<20070623103349.23cad9b7@the-village.bc.nu>
	<467CE8FA.2040304@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41610 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753107AbXFWJrw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 05:47:52 -0400
In-Reply-To: <467CE8FA.2040304@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: linux-ide@vger.kernel.org

On Sat, 23 Jun 2007 10:33:46 +0100
Matt Sealey <matt@genesi-usa.com> wrote:

> 
> Alan Cox wrote:
> > On Sat, 23 Jun 2007 01:26:06 +0100
> >
> > The simplest way is probably to load the pci class and programming
> > interface bits correctly for the device to match how your IRQ setup has
> > been arranged. See page 78 of the VIA 8231 spec if you have it, and load
> > the programming class in the boot firmware or in a PCI header quirk)
> 
> Ah so the correct way *is* to change the PCI class? I don't think we're
> going to be publishing such a thing in the firmware (sadly) but this could
> be done in a platform fixup for sure, then? Or a Forth script in the
> firmware... hmm.. that sounds pretty easy actually.

The programming interface.

http://t13.org/Documents/UploadedDocuments/project/d1510r1-Host-Adapter.pdf

explains it all.

The only other gotcha is that if you want to change the class bits to
indicate the device is in legacy mode you must do that in an "early"
fixup so that it occurs before pci_setup_device makes decisions based
upon the programming interface.


