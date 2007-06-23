From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Sat, 23 Jun 2007 10:33:46 +0100
Message-ID: <467CE8FA.2040304@genesi-usa.com>
References: <467C689E.3050800@genesi-usa.com> <20070623103349.23cad9b7@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:1554 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbXFWJdI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 05:33:08 -0400
In-Reply-To: <20070623103349.23cad9b7@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org


Alan Cox wrote:
> On Sat, 23 Jun 2007 01:26:06 +0100
>
> The simplest way is probably to load the pci class and programming
> interface bits correctly for the device to match how your IRQ setup has
> been arranged. See page 78 of the VIA 8231 spec if you have it, and load
> the programming class in the boot firmware or in a PCI header quirk)

Ah so the correct way *is* to change the PCI class? I don't think we're
going to be publishing such a thing in the firmware (sadly) but this could
be done in a platform fixup for sure, then? Or a Forth script in the
firmware... hmm.. that sounds pretty easy actually.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
