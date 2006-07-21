From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1] - sgiioc4: fixup use of mmio ops
Date: Fri, 21 Jul 2006 06:16:42 -0700
Message-ID: <20060721061642.923c7052.akpm@osdl.org>
References: <20060719153155.30856.2479.sendpatchset@attica.americas.sgi.com>
	<20060720051929.GB763333@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:55780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750705AbWGUNRK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Jul 2006 09:17:10 -0400
In-Reply-To: <20060720051929.GB763333@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: jpk@sgi.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 19 Jul 2006 22:19:29 -0700
Jeremy Higdon <jeremy@sgi.com> wrote:

> On Wed, Jul 19, 2006 at 10:31:55AM -0500, John Keller wrote:
> > Resend #2 changes include:
> > 
> > - use 'void __iomem *' for ioremap() return values,
> >   and handle error cases.
> > 
> > sgiioc4.c had been recently converted to using mmio ops.
> > There are still a few issues to cleanup.
> > 
> > Signed-off-by: jpk@sgi.com
> Signed-off-by: jeremy@sgi.com

hrm.  I think we're owed a couple of iounmap()s, please.  One in the
ide_dma_sgiioc4() error path and one in the takedown path.

Maybe that was one of the "few issues to cleanup", but it's a pretty simple
one.
