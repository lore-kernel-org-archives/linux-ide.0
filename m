From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: remove experimental tag on PATA drivers
Date: Sat, 14 Nov 2009 02:08:29 +0100
Message-ID: <200911140208.29888.bzolnier@gmail.com>
References: <4AFCC0D4.9020708@gmail.com> <200911140046.29450.bzolnier@gmail.com> <20091114001510.2dd0ab5d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:2542 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbZKNBJg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2009 20:09:36 -0500
In-Reply-To: <20091114001510.2dd0ab5d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Jonathan Corbet <corbet@lwn.net>

On Saturday 14 November 2009 01:15:10 Alan Cox wrote:
> On Sat, 14 Nov 2009 00:46:29 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Friday 13 November 2009 19:25:15 Alan Cox wrote:
> > > > Fine but please update status of following host drivers that were
> > > > marked as "stable" prematurely by commit e3389cb first:
> > > > 
> > > > PATA_PDC_OLD: needs to be marked as EXPERIMENTAL (or just BROKEN)
> > > > - known reliability problems with UDMA
> > > 
> > > A few odd reports apparently linked to specific chip revs. It's at
> > > least as stable as the old IDE one which doesn't work on my hardware. I'd
> > 
> > Skipping the technical merit of the quoted text for the moment -- I find
> 
> You mean the content ?
> 
> > the fact that you keep calling the present IDE host drivers (that many
> > developers helped to fix) as "old" ones or "buggy" ones rather degrading
> 
> As you quoted the old PDC202xx driver does not work on my test hardware.
> The libata one does. That is what is popularly known as a "fact". I'm not

You want facts?  Here we go:

https://bugzilla.redhat.com/show_bug.cgi?id=250349
https://bugzilla.novell.com/show_bug.cgi?id=457037
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/399616

> entirely happy with either PDC driver for older chips and I've spent
> considerable time grovelling through old drivers, alternate drivers and
> what little documentation exists to try and figure it out in more detail.
> 
> The lost IRQ recovery patches seem to have helped a fair bit, and your
> UDMA33 fix likewise.

I regret this work -- because of it I share the blame for the new driver
and keep getting complains about it..

> > for their (this includes me of course) hard work.
> 
> All because you wouldn't work on the libata ones which had a future. You

The rest of your mail is "the same good old straw-man" to put me back
into specially created for me by you & co. "difficult to work with" box.

Guys, "the devil" has been long out of the box.. :)

-- 
Bartlomiej Zolnierkiewicz
