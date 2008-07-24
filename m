From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall
 back
Date: Thu, 24 Jul 2008 18:23:46 +0100
Message-ID: <20080724182346.06d06bfd@lxorguk.ukuu.org.uk>
References: <20080723144227.253944199@fluff.org>
	<200807241812.32988.bzolnier@gmail.com>
	<20080724170650.07b542d5@lxorguk.ukuu.org.uk>
	<200807241905.22959.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55998 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751407AbYGXRlN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 13:41:13 -0400
In-Reply-To: <200807241905.22959.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

> config PATA_ALI
>         tristate "ALi PATA support (Experimental)"
>         depends on PCI && EXPERIMENTAL
> ...

I should update that now the ATAPI stuff is done.

> The second is of course optional for properly configured chips but it is
> not much of work and better be safe than sorry (also which 'BIOS writers

That might make sense for the specific chipset.

> guide' exactly are you referring to?).

The ALi one for the chipset. You might need to be nice to ULi to get a
copy however as I don't think its on the web site 8(
