From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] ide: fix serverworks.c UDMA regression
Date: Wed, 14 Nov 2007 08:55:46 -0800
Message-ID: <20071114165546.GA13889@kroah.com>
References: <4713B9FA.8050803@cybernetics.com> <200710162125.41987.bzolnier@gmail.com> <20071113232859.GB10338@kroah.com> <473B0787.1010805@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:35669 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760282AbXKNRCr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 12:02:47 -0500
Content-Disposition: inline
In-Reply-To: <473B0787.1010805@cybernetics.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Battersby <tonyb@cybernetics.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, stable@kernel.org

On Wed, Nov 14, 2007 at 09:34:47AM -0500, Tony Battersby wrote:
> Greg KH wrote:
> > On Tue, Oct 16, 2007 at 09:25:41PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >   
> >> On Monday 15 October 2007, Tony Battersby wrote:
> >>     
> >>> The patch described by the following excerpt from ChangeLog-2.6.22 makes
> >>> it impossible to use UDMA on a Tyan S2707 motherboard (SvrWks CSB5):
> >>>
> >>> commit 2d5eaa6dd744a641e75503232a01f52d0768884c
> >>> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >>> Date:   Thu May 10 00:01:08 2007 +0200
> >>>
> >>>     ide: rework the code for selecting the best DMA transfer mode (v3)
> >>>
> >>>     ...
> >>>
> >>> This one-line patch against 2.6.23 fixes the problem.
> >>>       
> >> Thanks!! (and sorry for the bug)
> >>
> >>     
> >>> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
> >>>       
> >> applied
> >>
> >> Greg/Chris: this is a perfect candidate for 2.6.23.2
> >>     
> >
> > Thanks, got it now.
> >
> > greg k-h
> >
> >   
> 
> Also applies to 2.6.22, if you are still maintaining that stable branch.

Thanks, yes, I am, in fact it's already in my todo-22 directory which
I'll get to after cleaning out this HUGE backlog of .23 patches that
I've been slack on attending to :(

thanks,

greg k-h
