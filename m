From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall
 back
Date: Thu, 24 Jul 2008 16:26:35 +0100
Message-ID: <20080724162635.46faede8@lxorguk.ukuu.org.uk>
References: <20080723144227.253944199@fluff.org>
	<20080723163216.7477be06@lxorguk.ukuu.org.uk>
	<20080723190433.GB26938@trinity.fluff.org>
	<20080723201349.33226d58@lxorguk.ukuu.org.uk>
	<20080724112637.GG26938@trinity.fluff.org>
	<20080724121450.7c30bc61@lxorguk.ukuu.org.uk>
	<20080724115000.GJ26938@trinity.fluff.org>
	<20080724125823.727e96db@lxorguk.ukuu.org.uk>
	<20080724135203.GM26938@trinity.fluff.org>
	<20080724153338.646a8182@lxorguk.ukuu.org.uk>
	<20080724152417.GP26938@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47945 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751748AbYGXPnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 11:43:53 -0400
In-Reply-To: <20080724152417.GP26938@trinity.fluff.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

> I've changed drivers/ata/pata_ali.c to change the mode back to compatibility
> mode, but libata-sff.c is still trying to use the pci configuration BARs
> to map the control registers. If the copy of the "PCI IDE Controller
> Specification, Revision 1.0" [1] is to be belived, the values in the PCI BARs
> should be ignored.

The PCI code knows about this and fills in BAR0 to BAR3 correctly
according to the host platform (defaulting to the usual PC values). We
have to do that anyway to keep the PCI resource management straight.

If you switch it in pata_ali that'll break, use a PCI quirk as I said
before - switch it with a HEADER quirk for your platform.

Alan
