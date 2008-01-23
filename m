From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ppc: fix #ifdef-s in mediabay driver
Date: Wed, 23 Jan 2008 13:47:38 +0100
Message-ID: <200801231347.38853.bzolnier@gmail.com>
References: <200801230012.38516.bzolnier@gmail.com> <200801230158.42017.bzolnier@gmail.com> <1201061832.6807.64.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753986AbYAWMfZ@vger.kernel.org>
In-Reply-To: <1201061832.6807.64.camel@pasglop>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 23 January 2008, Benjamin Herrenschmidt wrote:
> 
> On Wed, 2008-01-23 at 01:58 +0100, Bartlomiej Zolnierkiewicz wrote:
> > I'm more worried about breaking automatic build checking (make randconfig)
> > than a few extra bytes so if you remove all #ifdefs you'll have to either
> > make BLK_DEV_IDE_PMAC select PMAC_MEDIABAY or make PMAC_MEDIABAY depend
> > on BLK_DEV_IDE_PMAC (otherwise BLK_DEV_IDE=n && PMAC_MEDIABAY=y will fail
> > since mediabay.c is referencing IDE code).
> 
> I was thinking about having the pmac arch code provide an exported
> function pointer to put the hook in to avoid that problem.

BTW the other pending IDE patches (yet to posted) include rework of IDE
hot-plug support for PMAC media-bay so ide_init_hwif_ports()/ide_register_hw()
/ide_unregister() calls in mediabay.c will be replaced by "something else".
