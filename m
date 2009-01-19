From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards
Date: Mon, 19 Jan 2009 19:28:35 +0100
Message-ID: <200901191928.35474.bzolnier@gmail.com>
References: <20090112233909.221080@gmx.net> <1231822958.22571.38.camel@pasglop> <20090113123337.199060@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f18.google.com ([209.85.218.18]:48512 "EHLO
	mail-bw0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756913AbZASSio (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 13:38:44 -0500
Received: by bwz11 with SMTP id 11so1458586bwz.17
        for <linux-ide@vger.kernel.org>; Mon, 19 Jan 2009 10:38:42 -0800 (PST)
In-Reply-To: <20090113123337.199060@gmx.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca

On Tuesday 13 January 2009, Gerhard Pircher wrote:
> 
> -------- Original-Nachricht --------
> > Datum: Tue, 13 Jan 2009 16:02:38 +1100
> > Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > An: Gerhard Pircher <gerhard_pircher@gmx.net>
> > CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
> > Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards
> 
> > > Yes, it can wait.
> > > Although I would like to know from the powerpc maintainer, if my
> > > platform patches could still go in 2.6.29, if I resend them in the next days? I
> > > guess it's too late, right?
> > 
> > Yes it is. I'll put them in -next after -rc2 or later, when we are happy
> > with them. That gives us a bit of time to do extra polishing.
> Good, then I'll send out a new patch for the IDE driver and the current one
> can be reverted.

The following patchset fixes core IDE PCI code to always use
pci_get_legacy_ide_irq() and ide_pci_is_in_compatibility_mode():

http://lkml.org/lkml/2009/1/19/163

so via82cxxx specific solution is no longer necessary.

[ IOW I'll keep your previous patch and the #ifdef issue will
  solve itself after the above patchset is merged. ]

Thanks,
Bart
