From: Simon Horman <horms@verge.net.au>
Subject: Re: drivers/ata/sata_rcar.c:183:2: warning: large integer implicitly
 truncated to unsigned type
Date: Tue, 4 Jun 2013 10:45:21 +0900
Message-ID: <20130604014521.GN23054@verge.net.au>
References: <51a59c1b.AMyrU/XAl1VcZ02t%fengguang.wu@intel.com>
 <20130529072447.GC12650@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130529072447.GC12650@localhost>
Sender: linux-sh-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, Tejun Heo <tj@kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-ide@vger.kernel.org, Vladimir Barinov <vladimir.barinov@cogentembedded.com>
List-Id: linux-ide@vger.kernel.org

Hi Sergei, Hi Vladimir,

could you look into a fix for this?

I believe that it is a result of my patch "libata: do not limit R-Car SATA
driver to shmobile", which now allows the R-Car SATA driver to be compiled
for a (much) wider range of hardware.

On Wed, May 29, 2013 at 03:24:47PM +0800, Fengguang Wu wrote:
> 
> Hi Simon,
> 
> First bad commit might be:
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next master
> head:   1ca94a12e6c269b0dfc10424c27ff295b3420e9c
> commit: 5c23341ff66c9280c2e76dc9795cd14497ea780f libata: do not limit R-Car SATA driver to shmobile
> date:   5 days ago
> config: make ARCH=powerpc allmodconfig
> 
> All warnings:
> 
>    drivers/ata/sata_rcar.c: In function 'sata_rcar_thaw':
> >> drivers/ata/sata_rcar.c:183:2: warning: large integer implicitly truncated to unsigned type [-Woverflow]
> 
> vim +183 drivers/ata/sata_rcar.c
> 
> 163cf81d Vladimir Barinov 2013-02-20  167  
> 163cf81d Vladimir Barinov 2013-02-20  168  static void sata_rcar_freeze(struct ata_port *ap)
> 163cf81d Vladimir Barinov 2013-02-20  169  {
> 163cf81d Vladimir Barinov 2013-02-20  170  	struct sata_rcar_priv *priv = ap->host->private_data;
> 163cf81d Vladimir Barinov 2013-02-20  171  
> 163cf81d Vladimir Barinov 2013-02-20  172  	/* mask */
> 163cf81d Vladimir Barinov 2013-02-20  173  	iowrite32(0x7ff, priv->base + SATAINTMASK_REG);
> 163cf81d Vladimir Barinov 2013-02-20  174  
> 163cf81d Vladimir Barinov 2013-02-20  175  	ata_sff_freeze(ap);
> 163cf81d Vladimir Barinov 2013-02-20  176  }
> 163cf81d Vladimir Barinov 2013-02-20  177  
> 163cf81d Vladimir Barinov 2013-02-20  178  static void sata_rcar_thaw(struct ata_port *ap)
> 163cf81d Vladimir Barinov 2013-02-20  179  {
> 163cf81d Vladimir Barinov 2013-02-20  180  	struct sata_rcar_priv *priv = ap->host->private_data;
> 163cf81d Vladimir Barinov 2013-02-20  181  
> 163cf81d Vladimir Barinov 2013-02-20  182  	/* ack */
> 163cf81d Vladimir Barinov 2013-02-20 @183  	iowrite32(~SATA_RCAR_INT_MASK, priv->base + SATAINTSTAT_REG);
> 163cf81d Vladimir Barinov 2013-02-20  184  
> 163cf81d Vladimir Barinov 2013-02-20  185  	ata_sff_thaw(ap);
> 163cf81d Vladimir Barinov 2013-02-20  186  
> 163cf81d Vladimir Barinov 2013-02-20  187  	/* unmask */
> 163cf81d Vladimir Barinov 2013-02-20  188  	iowrite32(0x7ff & ~SATA_RCAR_INT_MASK, priv->base + SATAINTMASK_REG);
> 163cf81d Vladimir Barinov 2013-02-20  189  }
> 163cf81d Vladimir Barinov 2013-02-20  190  
> 163cf81d Vladimir Barinov 2013-02-20  191  static void sata_rcar_ioread16_rep(void __iomem *reg, void *buffer, int count)
> 
> 
> 
> ---
> 0-DAY kernel build testing backend              Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
> 
