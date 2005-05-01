From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/ide/: possible cleanups
Date: Sun, 1 May 2005 16:29:15 +0200
Message-ID: <20050501142915.GF3592@stusta.de>
References: <20050430200750.GM3571@stusta.de> <1114954660.11309.154.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39175 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261634AbVEAO3Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 May 2005 10:29:16 -0400
Content-Disposition: inline
In-Reply-To: <1114954660.11309.154.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Sun, May 01, 2005 at 02:37:43PM +0100, Alan Cox wrote:
> On Sad, 2005-04-30 at 21:07, Adrian Bunk wrote:
> > This patch contains the following possible cleanups:
> > - pci/cy82c693.c: make a needlessly global function static
> > - remove the following unneeded EXPORT_SYMBOL's:
> >   - ide-taskfile.c: do_rw_taskfile
> >   - ide-iops.c: default_hwif_iops
> >   - ide-iops.c: default_hwif_transport
> >   - ide-iops.c: wait_for_ready
> 
> default_*_ops are very much API items not currently used. You need them
> if you
> want to switch from mmio back to pio (eg doing S3 resume) although
> nobody is currently doing that.

My patch only removes the EXPORT_SYMBOL's.

The functions themselves stay (since they are used), and if someone 
wants at some time in the future use them from a module, re-adding them 
will be trivial.

> wait_for_ready used to be used by ide-probe as a module so seems sane.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

