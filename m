From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Thu, 21 Jan 2010 17:11:03 +0000
Message-ID: <20100121171103.3db5b496@lxorguk.ukuu.org.uk>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59136 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753256Ab0AURIo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jan 2010 12:08:44 -0500
In-Reply-To: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Check <paul@thechecks.ca>
Cc: linux-ide@vger.kernel.org

On Thu, 21 Jan 2010 10:57:39 -0500
"Paul Check" <paul@thechecks.ca> wrote:

> I am having an intermittent problem:
> 
> ata1.01: SATA link down (SStatus 0 SControl 301)
> 
> which is causing one of my four hard drives to not get recognized.
> 
> This happens on ata1.01, ata2.00 or ata2.01, although it seems to happen
> more on the 01 channels, I believe.  My motherboard is an ASUS P6T Deluxe
> V2, with the Marvel 88SE61XX ATA controller.

My first suspect would be power - that's a drive dropping off the link by
the look of it. One thing you could try is swapping the cables over
(first the SATA and then the power) and seeing if the problem moves with
either.

Do you get other errors (in particular a message about resetting) just
before the link down error?

> Would deselecting the pata_marvell likely get rid of this problem? The
> descriptor says:

Probably not. The Marvell situation is this (ignoring Jeff's devel driver
whose state I'm not sure of)

PATA_MARVELL - can drive SATA and PATA ports but without all the extra
features
AHCI - can drive Marvell SATA fully featured but not the PATA at all.

The kernel tries to select the AHCI driver if it sees no PATA drive is
present. So you can turn it off on a SATA only box but I'd expect no
change.

> As I look through kern.log I see that the numbering on the ATA channels is
> not always consistent.  For example, sometimes the Seagates come on
> ata3.00, ata3.01, ata4.00 and ata4.01. Is this usual, or indicating a
> problem with the controller/driver?
> 
> Regards, Paul (on list)

Difficult to tell without more info.
