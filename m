From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Sat, 23 Jun 2007 10:33:49 +0100
Message-ID: <20070623103349.23cad9b7@the-village.bc.nu>
References: <467C689E.3050800@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49701 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753218AbXFWJ2A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 05:28:00 -0400
In-Reply-To: <467C689E.3050800@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: linux-ide@vger.kernel.org

On Sat, 23 Jun 2007 01:26:06 +0100
Matt Sealey <matt@genesi-usa.com> wrote:

> There are several different ways you can set it up from having a single
> IRQ (true PCI native), to using PCI register access but with IRQ routing
> through a certain pair of interrupts (14/15 or 10/11) or by having real
> legacy ISA access (ports in the low memory ranges and the old 14/15 pair
> we all remember from the first ATA controllers).

SFF8038i is the standard you want for PCI ATA controllers.

> noticed a strange patch on the linuxppc-dev mailing list by a Freescale
> employee which changed the PCI class code of a ULI controller which
> somehow made the libata driver for that controller consider it a
> not-quite-native driver; I am not sure how that was meant to work but
> it was obviously a platform-specific solution.

Its part of the spec. The native/legacy/non-ide status of a device is
determined according to the SFF spec from the PCI class information bits.

> 
> Does anyone have an idea how we can integrate this 'quirk' of the
> non-native native PCI mode and support two IRQs properly so we can
> have pata_via work on Pegasos (distros are dropping the old drivers
> as we speak..)

The simplest way is probably to load the pci class and programming
interface bits correctly for the device to match how your IRQ setup has
been arranged. See page 78 of the VIA 8231 spec if you have it, and load
the programming class in the boot firmware or in a PCI header quirk)

Alan


