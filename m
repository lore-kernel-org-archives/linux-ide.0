From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: remove experimental tag on PATA drivers
Date: Sat, 14 Nov 2009 00:15:10 +0000
Message-ID: <20091114001510.2dd0ab5d@lxorguk.ukuu.org.uk>
References: <4AFCC0D4.9020708@gmail.com>
	<200911131715.24377.bzolnier@gmail.com>
	<20091113182515.38fb3793@lxorguk.ukuu.org.uk>
	<200911140046.29450.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50390 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757558AbZKNANT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2009 19:13:19 -0500
In-Reply-To: <200911140046.29450.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Jonathan Corbet <corbet@lwn.net>

On Sat, 14 Nov 2009 00:46:29 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Friday 13 November 2009 19:25:15 Alan Cox wrote:
> > > Fine but please update status of following host drivers that were
> > > marked as "stable" prematurely by commit e3389cb first:
> > > 
> > > PATA_PDC_OLD: needs to be marked as EXPERIMENTAL (or just BROKEN)
> > > - known reliability problems with UDMA
> > 
> > A few odd reports apparently linked to specific chip revs. It's at
> > least as stable as the old IDE one which doesn't work on my hardware. I'd
> 
> Skipping the technical merit of the quoted text for the moment -- I find

You mean the content ?

> the fact that you keep calling the present IDE host drivers (that many
> developers helped to fix) as "old" ones or "buggy" ones rather degrading

As you quoted the old PDC202xx driver does not work on my test hardware.
The libata one does. That is what is popularly known as a "fact". I'm not
entirely happy with either PDC driver for older chips and I've spent
considerable time grovelling through old drivers, alternate drivers and
what little documentation exists to try and figure it out in more detail.

The lost IRQ recovery patches seem to have helped a fair bit, and your
UDMA33 fix likewise.

> for their (this includes me of course) hard work.

All because you wouldn't work on the libata ones which had a future. You
are forgetting of course to mention that a good deal of analysis went
into deciding to switch to libata and teach libata to do PATA devices.
Stuff I'd say has proved to be bang on the mark as every PC class system
now has SATA, already has the SATA stack and in many cases have devices
where the PATA and SATA ports interact so must be driven by the same
stack. Now that CF is dying I'd say its pretty much proven the right
choice.

I am *really* glad to see that with the wireless you are contributing
heavily to both the old and new. If only you'd done that with PATA we
would all have been better off.

Alan
