From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.21-rc1 1/2] sata_vsc: factor the error and normal
 intr	paths into separate routines
Date: Fri, 23 Feb 2007 13:08:50 +0900
Message-ID: <45DE68D2.4010306@gmail.com>
References: <20070221175354.21231.15372.stgit@dwillia2-linux.ch.intel.com> <20070221175646.21231.90731.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:16649 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbXBWEIw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Feb 2007 23:08:52 -0500
Received: by nz-out-0506.google.com with SMTP id s1so360359nze
        for <linux-ide@vger.kernel.org>; Thu, 22 Feb 2007 20:08:51 -0800 (PST)
In-Reply-To: <20070221175646.21231.90731.stgit@dwillia2-linux.ch.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jeremy@sgi.com

Hello, Dan.

Dan Williams wrote:
> +static inline void vsc_error_intr(u8 port_status, struct ata_port *ap)
> +{
> +	if (port_status & (VSC_SATA_INT_PHY_CHANGE | VSC_SATA_INT_ERROR_M))
> +		ata_port_freeze(ap);
> +	else
> +		ata_port_abort(ap);
> +}
> +
> +static void vsc_port_intr(u8 port_status, struct ata_port *ap)
> +{
> +	struct ata_queued_cmd *qc;
> +	int handled = 0;
> +
> +	if (unlikely(port_status & VSC_SATA_INT_ERROR)) {
> +		vsc_error_intr(port_status, ap);
> +		return;
> +	}
> +
> +	qc = ata_qc_from_tag(ap, ap->active_tag);
> +	if (qc && likely(!(qc->tf.flags & ATA_TFLAG_POLLING)))
> +		handled = ata_host_intr(ap, qc);
> +
> +	/* We received an interrupt during a polled command,
> +	 * or some other spurious condition.  Interrupt reporting
> +	 * with this hardware is fairly reliable so it is safe to
> +	 * simply clear the interrupt
> +	 */
> +	if (unlikely(!handled))
> +		ata_chk_status(ap);
> +}

Sorry to keep nagging about patch separation and your way could be okay
too, but IMHO this can be done better in one of the following ways.

1. Keep two patches.  One to break down the interrupt handler the other
to improve it.  In this case the first one shouldn't introduce major new
features but just focus on breaking down existing one.

2. Do it in single patch.  It seems the changes are localized enough.
Just name it something like 'reimplement irq handler' and list changes
in the commit message.

After seeing the change, I'm leaning toward #2.  Thanks.  :-)

-- 
tejun
