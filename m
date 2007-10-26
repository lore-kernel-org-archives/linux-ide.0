From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] ide: fix drive_is_ready() for non-PCI hosts and
 CONFIG_IDEPCI_SHARE_IRQ=y
Date: Fri, 26 Oct 2007 12:53:55 +0100
Message-ID: <20071026125355.7c4a3398@the-village.bc.nu>
References: <200710260136.37333.bzolnier@gmail.com>
	<20071026010515.260672b4@the-village.bc.nu>
	<472137E8.9020109@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54522 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751201AbXJZLvX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 07:51:23 -0400
In-Reply-To: <472137E8.9020109@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 25 Oct 2007 20:42:16 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > On Fri, 26 Oct 2007 01:36:37 +0200
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> >> Need to check if the host is a PCI one before reading IDE_ALTSTATUS_REG.
> >>
> >> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > 
> > Umm why ? The altstatus register goes back to ST-506 and the original IBM
> > XT hard disk controller card ?
> 
> I'm pretty sure there are at least a few controllers out there where the 
> AltStatus/Control register block is simply non-existent.

One or two of the commode Amiga controllers did this. Makes error
recovery rather interesting. The register itself is however present even
on things like the WD10xx devices.

Alan
