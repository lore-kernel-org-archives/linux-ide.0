From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] ide-generic: handle probing of legacy io-ports
Date: Sun, 3 Aug 2008 16:59:55 +0200
Message-ID: <200808031659.55953.bzolnier@gmail.com>
References: <20080715053356.GA18628@gollum.tnic> <200808031611.11033.bzolnier@gmail.com> <20080803144539.GA27766@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:21425 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184AbYHCPCV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 11:02:21 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1494580fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 03 Aug 2008 08:02:19 -0700 (PDT)
In-Reply-To: <20080803144539.GA27766@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 03 August 2008, Borislav Petkov wrote:

[...]

> > > +		if (probe_mask) {
> > > +			printk(KERN_WARNING "%s: enforcing probing of io ports "
> > > +			       "upon user request.\n", DRV_NAME);
> > > +			primary = 0;
> > > +			secondary = 0;
> > > +		} else
> > > +			printk(KERN_INFO DRV_NAME ": please use "
> > > +			       \"probe_mask=0x3f\" module parameter for probing"
> > > +			       "all legacy ISA IDE ports\n");
> > 
> > Help message is no longer printed for !primary
> > (we always want to have it unless probe_mask is set).
> 
> How about moving that info to Documentation/ide/ide.txt instead? Do we want to
> issue that on every boot, seems like a too unimportant message to be in the
> bootlog to me...

Some time ago we've changed the default from probing all ports to probe
only safe ones (we had to do it because probing all ports may break other
ISA devices) so there may be very unlikely cases when this bugfix caused
regression and we would like people to be able to deduce the workaround
from just reading kernel messages.
