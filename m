From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [PATCH] PA-RISC update to 87415
Date: Wed, 3 Nov 2004 16:23:56 -0700
Message-ID: <20041103232356.GD23415@colo.lackof.org>
References: <20041103200059.GC17672@colo.lackof.org> <58cb370e04110312215ee851e4@mail.gmail.com> <20041103213351.GB23415@colo.lackof.org> <58cb370e041103140121017ea1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:54179 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261996AbUKCXYA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Nov 2004 18:24:00 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e041103140121017ea1@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, matthew@wil.cx, linux-ide@vger.kernel.org

On Wed, Nov 03, 2004 at 11:01:58PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 1) both comments are wrong.
> >   (byte write only covers LATENCY, pci_set_master is called)
> 
> ?

	/* Set a good latency timer and cache line size value. */

The PCI config write only modifies the latency timer, not the cache line
size register.

#define PCI_CACHE_LINE_SIZE     0x0c    /* 8 bits */
#define PCI_LATENCY_TIMER       0x0d    /* 8 bits */

	/* FIXME: use pci_set_master() to ensure good latency timer value */

This has been in fact already been fixed.
That's why I submitted the patch to delete the code.

thanks,
grant
