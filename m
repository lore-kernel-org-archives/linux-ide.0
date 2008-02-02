From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.23.11]: [sata_svw]: Add ATAPI DMA support for HT1x00
 SATA controller
Date: Fri, 01 Feb 2008 19:30:56 -0500
Message-ID: <47A3B9C0.4000309@garzik.org>
References: <03235919BBDE634289BB6A0758A20B3602F39355@NT-SJCA-0751.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59055 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765959AbYBBAbA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 19:31:00 -0500
In-Reply-To: <03235919BBDE634289BB6A0758A20B3602F39355@NT-SJCA-0751.brcm.ad.broadcom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anantha Subramanyam <ananth@broadcom.com>
Cc: linux-ide@vger.kernel.org

Anantha Subramanyam wrote:
> This patch adds ATAPI DMA support for HT1000 (aka BCM5785) & HT1100
> (aka BCM11000) SATA Controller.
> 
> Signed-off-by: Anantha Subramanyam <ananth@broadcom.com>

Thanks much for your patience.  Feedback:

Engineering process issues:

1) patch is word-wrapped, and cannot be applied by automatic tools.  In
Linux, email is second only to the C compiler as a tool critical to
development work.  It might take some time to get things set up
correctly -- but that's a one-time cost.


2) several occurences of "whitespace mangling": tabs were converted to
spaces, again making our automated tools unable to apply the patch.


Consistency (with other Linux drivers) issues:

1) avoid C++ comments.  The rest of the driver exclusively uses /* style
(and 95% of the rest of the kernel does too).  You should follow the
existing coding style whenever modifying existing code.


2) don't define a struct twice, once for each endian
(_k2_sata_cmd_desc_s).  We use a very specific style, which the "sparse"
source code checking tool knows and checks:

	a) define a single version of the struct

	b) use C types that indicate endianness:  __le32, __be16, etc.

	c) in the source code, add endian conversions:

		foo->prd_tbl_base_lo = cpu_to_le32(address);

	   These endian conversions are automatically optimized out
	   on like-endian platforms, and are heavily optimized on
	   unlike-endian platforms.


3) use POSIX-style struct definitions:

	OK:

		struct foo {
			...
		};

	Not OK:

		typedef struct _foo {
			...
		} foo_t;


4) avoid what we call "StudlyCaps" :)  The preferred Linux style used in
the vast majority of code is lower case, with underscores separating words:

	OK:
		prd_tbl_hi
		prd_cnt
		prd_tbl_lo

	Not OK:

		sl_PrdTblBaseLow
		sw_PrdCount
		sw_PrdTblBaseHigh


5) similarly, avoid Hungarian notation, where the type is indicated in
the variable/member name.

	OK:	prd_tbl_lo
	Not OK:	sl_prd_tbl_lo


6) No need to add an extra indentation level after a 'return' statement:

> static int k2_sata_check_atapi_dma(struct ata_queued_cmd *qc) { +	u8
> command = qc->scsicmd->cmnd[0]; + if (qc->ap->flags &
> K2_FLAG_NO_ATAPI_DMA) return -1;	/* ATAPI DMA not supported */ +	else
>  +	{


7) static inline functions are preferred over cpp macros, because they
are far more type-safe.

> +#define K2_IS_SATA_STS_GOOD(sata_sts)      \ +    (((sata_sts &
> K2_SATA_DET_MASK) == K2_DEV_DET_PHY_RDY) && (((sata_sts &
> K2_SATA_INTF_MASK)>>8) == K2_SATA_INFT_ACTIVE))

The C compiler is smart enough to ensure there is no penalty for using a
function rather than a macro.


8) in k2_ht1x_port_start(), use the standard Linux 'goto unwind' method
of error handling:

	pspi = kmalloc(sizeof(k2_sata_port_info), GFP_KERNEL);
	if (!pspi)
		goto err_out;

	pspi->pcmd_desc = dma_alloc_coherent(dev, ...);
	if (!pspi->pcmd_desc)
		goto err_out_pspi;

	pspi->pcdb_cpybuf = dma_alloc_coherent(dev, ...);
	if (!pspi->pcdb_cpybuf)
		goto err_out_pcmd;

	/* ... etc ... */

	return 0;

     err_out_pcmd:
	dma_free_coherent(pspi->pcmd_desc);
     err_out_pspi:
	kfree(pspi);
     err_out:
	return rc;


9) don't add unnecessary casts from a void pointer:

> k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;


10) remove redundant comment...  by definition this statement is always 
true, since your patch will be merged into a kernel later than 2.6.18.

> +/*
> +later version of libata (kernel 2.6.18 & later) have a elaborate
> +error handling mech that includes multilevel of resets (soft, hard,
> post...)  
> +so we plug into that
> +
> +*/


11) K2_SATA_WAIT_MDIO_DONE() should be a function, not a macro


12) overall, make sure your patch passes 'sparse' (see 
Documentation/sparse.txt) and 'checkpatch' (see scripts/checkpatch.pl) 
checks before submission.  There are other minor issues I did not bother 
to outline here.





Operational issues:

1) Use of 'volatile' is almost always the wrong thing to do:

> int k2_ht1x_qdma_pause(struct ata_port *ap, int pause)
> +{
> +	k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;
> +	u32 qsr;
> +	volatile int i = 0;

In Linux, if you feel you need 'volatile', then really you most likely 
need (a) to remove it, (b) to use a barrier(), or (c) use a spinlock. 
'volatile' across SMP machines is rather useless, and ill-defined in the 
C specifications.


2) remove redundant initialization of static var.  Static variables are, 
by definition, initialized to zero.  Explicit initialization simply 
wastes space in the initialized variable area.


> -	static int printed_version;
> +	static int printed_version = 0;


3) we try _very_ hard to avoid all dependencies on the state produced by 
BIOS.  The three main reasons:

	a) the driver may be used on non-x86 platforms, where
	   x86 BIOS code simply cannot be executed

	b) during suspend/resume, the driver must be able to
	   initialize the controller fully after transition
	   from PCI D3 to PCI D0

	c) PCI controller hotplug

Thus, I would like to avoid the need for the 'skip_init' module 
parameter.  Users and automated Linux install tools will be completely 
unaware of skip_init, and will not have enough knowledge to use it.  It 
is best to simply Do The Right Thing in all cases.


4) don't use udelay/mdelay when you can sleep:

> +inline void k2_lnx_sleep( u32 usec_delay)
> +{
> +    (usec_delay > 1000) ? mdelay(usec_delay/1000 + 1):
> udelay(usec_delay);
> +}


5) is it reasonable to use QDMA for ATA also?


6) use spin_lock() rather than spin_lock_irqsave() in 
k2_ht1x_interrupt().  You're not competing with other interrupts AFAICS.


7) in k2_ht1x_qdma_intr(), ap->hsm_task_state generally refers to PIO 
state.  ditto for the use of ata_hsm_move() in k2_ht1x_handle_qdma_error().

Can you explain the need, there?

It is more likely that you should override ->qc_issue and handle things 
at a top level, rather than overriding specific pieces of the ATAPI host 
state machine.  The HSM was not really designed to be overridden piecemeal.

