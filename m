From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall
 back
Date: Thu, 24 Jul 2008 14:52:15 +0100
Message-ID: <20080724145215.496d3ed4@lxorguk.ukuu.org.uk>
References: <20080723144226.807475493@fluff.org>
	<20080723144227.253944199@fluff.org>
	<20080723163216.7477be06@lxorguk.ukuu.org.uk>
	<20080723190433.GB26938@trinity.fluff.org>
	<20080723201349.33226d58@lxorguk.ukuu.org.uk>
	<20080724112637.GG26938@trinity.fluff.org>
	<20080724121328.5d281b97@lxorguk.ukuu.org.uk>
	<20080724115042.GK26938@trinity.fluff.org>
	<20080724125922.744923d7@lxorguk.ukuu.org.uk>
	<20080724135002.GL26938@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48240 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751667AbYGXOJj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 10:09:39 -0400
In-Reply-To: <20080724135002.GL26938@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

> > Ok so you've got a board reporting native mode using the legacy IRQ
> > numbering (14/15 - or platform equivalents) ? In which case may I suggest
> > you rewrite the header to indicate it is in legacy mode as per the BIOS
> > guide ?
> 
> The drivers/ide/pci/alim15x3.c driver currently has code to correctly
> set the IRQ fields for anything that isn't SPARC. Does this mean we
> must disable the libata driver for anything that isn't SPARC? What about
> other boards where this device combination is present?

There should be no boards where this combination is present. IRQ 0 in
native mode means "polled". It would therefore be helpful if you would
start considering your board as a problem special case - one we need to
support yes - rather than trying to argue that we should break support
for standard configurations.

Alan
