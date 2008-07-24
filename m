From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall
 back
Date: Thu, 24 Jul 2008 17:06:50 +0100
Message-ID: <20080724170650.07b542d5@lxorguk.ukuu.org.uk>
References: <20080723144227.253944199@fluff.org>
	<20080724145215.496d3ed4@lxorguk.ukuu.org.uk>
	<20080724141710.GN26938@trinity.fluff.org>
	<200807241812.32988.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54791 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751849AbYGXQYI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 12:24:08 -0400
In-Reply-To: <200807241812.32988.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

> Please note that the recommended PATA support in kernel.org kernels
> is IDE subsystem and libata PATA is still considered experimental.

This is false. Most distributions now use libata, and the old IDE code
has recently had an enormous amount of patching so is if anything far
more experimental than libata.

> - add PCI HEADER quirk to claim legacy mode (as suggested by Alan)
> 
> - move ALi IRQ handling code to PCI layer and then hook it into
>   pci_get_legacy_ide_irq()

The second isn't needed and will happen automatically if the chip is
properly configured (again see the BIOS writers guide)

Alan
