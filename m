From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Fix SMART reporting on 2.6.22
Date: Fri, 20 Jul 2007 07:44:52 -0400
Message-ID: <46A0A034.7070609@garzik.org>
References: <20070713065600.GB8320@vana.vc.cvut.cz> <46972519.80703@gmail.com> <46980AFD.3000503@shaw.ca> <6.2.0.14.2.20070713175627.031aada0@linux.sysreset.com> <4698356D.60605@gmail.com> <4698BE05.2080003@vandrovec.name> <469B4959.8010109@gmail.com> <20070717105459.GA15382@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49726 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbXGTLpC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 07:45:02 -0400
In-Reply-To: <20070717105459.GA15382@vana.vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <petr@vandrovec.name>
Cc: Tejun Heo <htejun@gmail.com>, Ryan Power <rpower@sysreset.com>, Robert Hancock <hancockr@shaw.ca>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

Petr Vandrovec wrote:
> On Mon, Jul 16, 2007 at 07:32:57PM +0900, Tejun Heo wrote:
>> [cc'ing Jeff and Albert]
>>
>> Petr Vandrovec wrote:
>>> Fix reported task file values in sense data
>>>
>>> ata_tf_read was setting HOB bit when lba48 command was submitted, but
>>> was not clearing it before reading "normal" data.  Maybe it would be
>>> better to just clear HOB bit immediately after reading upper halves
>>> for lba48 command, but I just decided to clear HOB bit in each
>>> ata_tf_read...
>>>
>>> Signed-off-by: Petr Vandrovec <petr@vandrovec.name>
>> Acked-by: Tejun Heo <htejun@gmail.com>
>>
>> Gee, thanks a lot for spotting this.  This is definitely for -stable.
>> Hmm... it's a separate issue and not your fault but ap->last_ctl caching
>> is broken in the function.  Albert is about to remove ap->last_ctl
>> caching but we still need to fix it for -stable.  Petr, are you
>> interested in submitting a separate patch for fixing ap->last_ctl
>> handling in the function?
> 
> OK, that pushed me over edge so this replaces my previous patch.  Now
> there is no ctl access when 24bit commands are issued back to back, and
> ctl is touched (twice...) only for 48bit commands.  smartctl still works...
> Any other email address I should CC?
> 					Thanks,
> 						Petr Vandrovec
> 
> 
> Fix reported task file values in sense data
> 
> ata_tf_read was setting HOB bit when lba48 command was submitted, but
> was not clearing it before reading "normal" data.  As it is only place
> which sets HOB bit in control register, and register reads should not
> be affected by other bits, let's just clear it when we are done with
> reading upper bytes so non-48bit commands do not have to touch ctl
> at all.
> 
> pata_scc suffered from same problem...
> 
> Signed-off-by: Petr Vandrovec <petr@vandrovec.name>
> 
> ---
> commit d09591edad8e75c9bc850d47b68a9a6f6f107998
> tree 1bd5a79c9cade9b7ebf68b13bf24a879b969e4c8
> parent a5fcaa210626a79465321e344c91a6a7dc3881fa
> author Petr Vandrovec <petr@vandrovec.name> Tue, 17 Jul 2007 03:45:43 -0700
> committer Petr Vandrovec <petr@vandrovec.name> Tue, 17 Jul 2007 03:45:43 -0700
> 
>  drivers/ata/libata-sff.c |    2 ++
>  drivers/ata/pata_scc.c   |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index ca7d224..6a579a9 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -211,6 +211,8 @@ void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
>  		tf->hob_lbal = ioread8(ioaddr->lbal_addr);
>  		tf->hob_lbam = ioread8(ioaddr->lbam_addr);
>  		tf->hob_lbah = ioread8(ioaddr->lbah_addr);
> +		iowrite8(tf->ctl, ioaddr->ctl_addr);
> +		ap->last_ctl = tf->ctl;
>  	}
>  }
>  
> diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
> index c55667e..60cce07 100644
> --- a/drivers/ata/pata_scc.c
> +++ b/drivers/ata/pata_scc.c
> @@ -358,6 +358,8 @@ static void scc_tf_read (struct ata_port *ap, struct ata_taskfile *tf)
>  		tf->hob_lbal = in_be32(ioaddr->lbal_addr);
>  		tf->hob_lbam = in_be32(ioaddr->lbam_addr);
>  		tf->hob_lbah = in_be32(ioaddr->lbah_addr);
> +		out_be32(ioaddr->ctl_addr, tf->ctl);
> +		ap->last_ctl = tf->ctl;
>  	}
>  }
>  
> 
> 
> ------------------------------------------------------------------------
> 
> Fix reported task file values in sense data
> 
> ata_tf_read was setting HOB bit when lba48 command was submitted, but
> was not clearing it before reading "normal" data.  As it is only place
> which sets HOB bit in control register, and register reads should not
> be affected by other bits, let's just clear it when we are done with
> reading upper bytes so non-48bit commands do not have to touch ctl
> at all.
> 
> pata_scc suffered from same problem...
> 
> Signed-off-by: Petr Vandrovec <petr@vandrovec.name>
> 
> ---
> commit d09591edad8e75c9bc850d47b68a9a6f6f107998
> tree 1bd5a79c9cade9b7ebf68b13bf24a879b969e4c8
> parent a5fcaa210626a79465321e344c91a6a7dc3881fa
> author Petr Vandrovec <petr@vandrovec.name> Tue, 17 Jul 2007 03:45:43 -0700
> committer Petr Vandrovec <petr@vandrovec.name> Tue, 17 Jul 2007 03:45:43 -0700
> 
>  drivers/ata/libata-sff.c |    2 ++
>  drivers/ata/pata_scc.c   |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index ca7d224..6a579a9 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -211,6 +211,8 @@ void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
>  		tf->hob_lbal = ioread8(ioaddr->lbal_addr);
>  		tf->hob_lbam = ioread8(ioaddr->lbam_addr);
>  		tf->hob_lbah = ioread8(ioaddr->lbah_addr);
> +		iowrite8(tf->ctl, ioaddr->ctl_addr);
> +		ap->last_ctl = tf->ctl;
>  	}
>  }
>  
> diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
> index c55667e..60cce07 100644
> --- a/drivers/ata/pata_scc.c
> +++ b/drivers/ata/pata_scc.c
> @@ -358,6 +358,8 @@ static void scc_tf_read (struct ata_port *ap, struct ata_taskfile *tf)
>  		tf->hob_lbal = in_be32(ioaddr->lbal_addr);
>  		tf->hob_lbam = in_be32(ioaddr->lbam_addr);
>  		tf->hob_lbah = in_be32(ioaddr->lbah_addr);
> +		out_be32(ioaddr->ctl_addr, tf->ctl);
> +		ap->last_ctl = tf->ctl;

applied


