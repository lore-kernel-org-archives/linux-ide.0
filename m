From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 03/86] pata_artop: add 32-bit PIO support
Date: Wed, 25 Nov 2009 17:59:41 +0000
Message-ID: <20091125175941.56a6f52d@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170239.5446.26287.sendpatchset@localhost>
	<20091125171242.70b8019f@lxorguk.ukuu.org.uk>
	<200911251818.18521.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54960 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758188AbZKYR5f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:57:35 -0500
In-Reply-To: <200911251818.18521.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 25 Nov 2009 18:18:18 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Wednesday 25 November 2009 06:12:42 pm Alan Cox wrote:
> > On Wed, 25 Nov 2009 18:02:39 +0100
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> > > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Subject: [PATCH] pata_artop: add 32-bit PIO support
> > > 
> > > There shouldn't be any problems with it as IDE aec62xx host driver
> > > has been allowing 32-bit PIO operations for years.
> > 
> > Allowing or defaulting too ?
> 
> For aec62xx: allowing, for some other drivers: defaulting ('using'
> in the patch description instead of 'allowing').  However some
> popular distributions have been defaulting to always enabling it
> if was supported by the driver.

I wonder what their coverage of old devices is like though and what they
enabled. No problem with those that defaulted, would be nice to get the
rest tested more systematically
