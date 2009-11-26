From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 16/86] pata_efar: MWDMA0 is unsupported
Date: Thu, 26 Nov 2009 15:15:46 +0000
Message-ID: <20091126151546.6c891014@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170415.5446.15073.sendpatchset@localhost>
	<20091125172552.6817e3da@lxorguk.ukuu.org.uk>
	<200911261553.58941.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49193 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754986AbZKZPNm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Nov 2009 10:13:42 -0500
In-Reply-To: <200911261553.58941.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 26 Nov 2009 15:53:58 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Wednesday 25 November 2009 06:25:52 pm Alan Cox wrote:
> > On Wed, 25 Nov 2009 18:04:15 +0100
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> > > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Subject: [PATCH] pata_efar: MWDMA0 is unsupported
> > > 
> > > MWDMA0 timings cannot be met with the PIIX based controller
> > > programming interface.
> > 
> > The efar documentation makes no reference to not being capable of MWDMA0,
> > so where does this come from ? No MWDMA0 is an Intel erratum it appears.
> 
> No MWDMA0 support is a common issue on all 'PIIX-like' controllers.
> 
> In case of this chipset while the (preliminary) documentation claims MWDMA0
> support on the 'FEATURES' page the later 'programming guide' part describes
> only PIO0-4, SWDMA2, MWDMA1-2 and UDMA0-4 transfer modes as supported.

Cool - I only have the original docs.
