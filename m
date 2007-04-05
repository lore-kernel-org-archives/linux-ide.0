From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] add correct interrupt property for pegasos ide
Date: Thu, 5 Apr 2007 12:32:09 +0200
Message-ID: <20070405103209.GA15974@aepfle.de>
References: <20070404111635.GA1855@aepfle.de> <200704042010.50088.bzolnier@gmail.com> <20070404181138.GA6050@aepfle.de> <200704042042.15108.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52035 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966073AbXDEKbs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Apr 2007 06:31:48 -0400
Content-Disposition: inline
In-Reply-To: <200704042042.15108.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mackeras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Apr 04, Bartlomiej Zolnierkiewicz wrote:

> 
> On Wednesday 04 April 2007, Olaf Hering wrote:
> > On Wed, Apr 04, Bartlomiej Zolnierkiewicz wrote:
> > 
> > > ?
> > 
> > You are right, I did not test the ide driver again. pata_via works with
> > the change. 
> > I will test the ide driver tomorrow.
> 
> Thanks.
> 
> There might be also the another issue here - the chipset claims fully native
> mode (prog-if 8f - taken from your previous mail) so driver takes IRQ value
> from dev->irq (which your patch fixes to be 14 instead of 20 if I'm reading
> it correctly) but in reality chipset seems to be still using legacy IRQs
> (14 for the primary port and 15 for the secondary one).  What IRQ value is
> reported by the libata for the secondary port?  Does the second port work?

The second port does not work. My added printks did not trigger. There
is not enough time to hack on this today.
I found maple_pci_get_legacy_ide_irq, maybe a similar function can be
added for pegasos to remove the ifarch code from the IDE driver.
