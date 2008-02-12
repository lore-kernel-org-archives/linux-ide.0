From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 00/18] ide: warm-plug support for IDE devices and other
 goodies
Date: Tue, 12 Feb 2008 21:41:37 +0000
Message-ID: <20080212214137.47478e5e@core>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<1202460043.7079.157.camel@pasglop>
	<1202850247.7410.24.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44842 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751142AbYBLVtK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 16:49:10 -0500
In-Reply-To: <1202850247.7410.24.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

On Wed, 13 Feb 2008 08:04:07 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Fri, 2008-02-08 at 19:40 +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2008-02-08 at 01:44 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > - couple of fixes and preparatory patches
> > > 
> > > - rework of PowerMac media-bay support ([un]register IDE devices instead of
> > >   [un]registering IDE interface) [ it is the main reason for spamming PPC ML ]
> > 
> > Interesting... I was thinking about doing a full remove of the device at
> > a higher level instead but I suppose what you propose is easier.
> > 
> > I'll have a look & test next week hopefully.
> 
> Also, the above would have the advantage of not relying on drivers/ide
> infrastructure, and thus working with libata (once somebody has ported
> pmac ide to libata).

Unfortunately you need a degree in dentistry to open a Macintosh up and
fix it otherwise we would have support by now.

Alan
