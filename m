From: Tejun Heo <tj@kernel.org>
Subject: Re: Potential race condition in drivers/ata/sata_mv.ko
Date: Tue, 9 Aug 2016 23:51:33 -0400
Message-ID: <20160810035133.GD25053@mtj.duckdns.org>
References: <8d7d8958-1a77-7c39-d008-fb6362e15d57@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f169.google.com ([209.85.213.169]:35402 "EHLO
	mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584AbcHJDvg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2016 23:51:36 -0400
Content-Disposition: inline
In-Reply-To: <8d7d8958-1a77-7c39-d008-fb6362e15d57@ispras.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Andrianov <andrianov@ispras.ru>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Vaishali Thakkar <vaishali.thakkar@oracle.com>

Hello,

On Fri, Aug 05, 2016 at 03:43:30PM +0300, Pavel Andrianov wrote:
> In drivers/ata/sata_mv.ko function mv_set_main_irq_mask is called several
> times. Twice with a spinlock, twice from init function and once without any
> protection. The call without protection rises to several handlers from
> ata_port_operations. The structure with the ata_port_operations is included
> into a structure 'host' in mv_platform_probe and in mv_pci_init_one. At the
> end of these functions ata_host operations are activated together with
> interrupt handler. The conclusion is: interrupt handler may be executed in
> parallel with handlers from ata_port_operations, or, more formally, it may
> interrupt its execution.
> 
> In mv_set_main_irq_mask and in interrupt handler mv_interrupt the interrupt
> mask is modified, but, as I said, handlers from ata_port_operations do not
> acquire any lock. Thus, the interrupt mask may be set incorrectly if the are
> two conflicting modifications.

It depends on which operations.  Most are only called from EH context
and racing there isn't likely to cause any actual issues.  Care to
submit a patch to fix the issue?

Thanks.

-- 
tejun
