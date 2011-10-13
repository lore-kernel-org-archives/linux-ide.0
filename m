From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] pata_oldpiix: enable parallel scan
Date: Thu, 13 Oct 2011 20:12:15 +0100
Message-ID: <20111013201215.50541413@lxorguk.ukuu.org.uk>
References: <201110131603.34443.bzolnier@gmail.com>
	<20111013164753.69a5e92c@lxorguk.ukuu.org.uk>
	<201110131806.27248.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43547 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752352Ab1JMTMW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 15:12:22 -0400
In-Reply-To: <201110131806.27248.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 13 Oct 2011 18:06:08 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> Alan Cox wrote:
> 
> > On Thu, 13 Oct 2011 16:03:34 +0200
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> > > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Subject: [PATCH] pata_oldpiix: enable parallel scan
> > > 
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > 
> > Have you tested this. When I talked with Intel people about parallel
> > scanning nobody in Intel I could find could answer whether it was safe on
> > the ancient PIIX versions.
> 
> No, it wasn't tested on the real hardware.
> 
> I think it should be in libata-dev or -mm/-next for rather long time..

I don't see it's worth adding, its near impossible to test and its for
old hardware that doesn't fast boot anyway. Really it's the netbook
generation devices where this matters.
