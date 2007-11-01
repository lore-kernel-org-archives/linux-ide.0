From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata ATAPI transfer size cleanups
Date: Thu, 1 Nov 2007 10:59:02 +0000
Message-ID: <20071101105902.6e411c20@the-village.bc.nu>
References: <20071101090733.GA9258@havoc.gtf.org>
	<20071101094344.6eb9d8bc@the-village.bc.nu>
	<4729A23E.7000601@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:34019 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753882AbXKAK5h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Nov 2007 06:57:37 -0400
In-Reply-To: <4729A23E.7000601@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thu, 01 Nov 2007 05:54:06 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > On Thu, 1 Nov 2007 05:07:33 -0400
> > Jeff Garzik <jeff@garzik.org> wrote:
> > 
> >> This is purely for comment and testing, not for merging (yet?).
> >>
> >> A common recipe in several vendor drivers (either GPL'd, or I have NDA'd
> >> access to use them as a documentation-like reference) for ATAPI was
> >> slightly different from ours.  This recipe can be found in
> >> atapi_tf_xfer_size(), and it's slightly different from Alan's.
> > 
> > Looks mostly good. Might cause breakage on one or two controllers by
> > setting lbam/lbah to 0 for DMA but we can test that and find out.
> 
> DMA always zeroed lbam/lbah thanks to memset(), my patch merely made it 
> explicit.

That would be a bug if so - need to try fixing that and see if it sorts
out the remaining recalcitrant ALi chips.

Alan
