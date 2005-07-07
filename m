From: Jens Axboe <axboe@suse.de>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Thu, 7 Jul 2005 19:31:03 +0200
Message-ID: <20050707173103.GK24401@suse.de>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net> <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org> <Pine.LNX.4.62.0507071022480.7105@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261492AbVGGRdA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507071022480.7105@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <christoph@lameter.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jul 07 2005, Christoph Lameter wrote:
> On Thu, 7 Jul 2005, Linus Torvalds wrote:
> 
> > If you make it use a trivial inline function for the thing, I think that 
> > would be ok, though.
> 
> Like this?
> 
> Index: linux-2.6.git/drivers/ide/ide-probe.c
> ===================================================================
> --- linux-2.6.git.orig/drivers/ide/ide-probe.c	2005-06-23 11:38:02.000000000 -0700
> +++ linux-2.6.git/drivers/ide/ide-probe.c	2005-07-07 10:22:02.000000000 -0700
> @@ -960,6 +960,15 @@
>  }
>  #endif /* MAX_HWIFS > 1 */
>  
> +static inline int hwif_to_node(ide_hwif_t *hwif)
> +{
> +	if (hwif && hwif->pci_dev)
> +		return pcibus_to_node(hwif->pci_dev->bus);
> +	else
> +		/* Add ways to determine the node of other busses here */
> +		return -1;
> +}

When is hwif ever NULL?

-- 
Jens Axboe
