From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall back
Date: Thu, 24 Jul 2008 12:50:00 +0100
Message-ID: <20080724115000.GJ26938@trinity.fluff.org>
References: <20080723144226.807475493@fluff.org> <20080723144227.253944199@fluff.org> <20080723163216.7477be06@lxorguk.ukuu.org.uk> <20080723190433.GB26938@trinity.fluff.org> <20080723201349.33226d58@lxorguk.ukuu.org.uk> <20080724112637.GG26938@trinity.fluff.org> <20080724121450.7c30bc61@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:55952 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbYGXLuC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 07:50:02 -0400
Content-Disposition: inline
In-Reply-To: <20080724121450.7c30bc61@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

On Thu, Jul 24, 2008 at 12:14:50PM +0100, Alan Cox wrote:
> > Does anyone know if the ALi M5229 actually exists outside of one of
> > the M1543 bridges?
> 
> Yes - it exists in various forms in all sorts of ALi/ULi chipset products.
> 
> > Note, this hardly seems to be a board-quirk, it is more of a device
> > quirk...
> 
> Your description so far is of "device not put in a valid configuration
> according to the spec"  - that seems to me to be board problems.

No, the configuration is correct, you cannot assign this device an
PCI IRQ when it is embedded in the M1543 bridge. The bridge itself
has other configuration registers that specify where the IDE IRQs
get routed.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

