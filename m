From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [PATCH] PA-RISC update to 87415
Date: Wed, 3 Nov 2004 14:33:51 -0700
Message-ID: <20041103213351.GB23415@colo.lackof.org>
References: <20041103200059.GC17672@colo.lackof.org> <58cb370e04110312215ee851e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:17546 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261915AbUKCVdw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Nov 2004 16:33:52 -0500
Content-Disposition: inline
In-Reply-To: <58cb370e04110312215ee851e4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: matthew@wil.cx, linux-ide@vger.kernel.org

On Wed, Nov 03, 2004 at 09:21:02PM +0100, Bartlomiej Zolnierkiewicz wrote:
> I only wonder about this change:
> 
> > @@ -132,10 +212,6 @@ static void __init init_hwif_ns87415 (id
> >         hwif->autodma = 0;
> >         hwif->selectproc = &ns87415_selectproc;
> > 
> > -       /* Set a good latency timer and cache line size value. */
> > -       (void) pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
> > -       /* FIXME: use pci_set_master() to ensure good latency timer value */

Bartlomiej,
two more notes:
1) both comments are wrong.
  (byte write only covers LATENCY, pci_set_master is called)

2) I realize now this should have been submitted this as a seperate patch.
   Sorry about that. I didn't review the patch today (again) as thoroughly
   as I should have. I started glossing over it when I saw all the suckyio
   code that I've stared at more than a few times...*sigh*
   You want a seperate patch+changelog entry for this one or was the
   previous email sufficient?

thanks,
grant
