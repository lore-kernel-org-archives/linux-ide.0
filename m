From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: port and host should be
	stopped before hardware resources are released
Date: Thu, 8 Nov 2007 13:14:47 -0500
Message-ID: <20071108181447.GH3491@havoc.gtf.org>
References: <47328BDC.3090105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:37045 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761766AbXKHSOs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 13:14:48 -0500
Content-Disposition: inline
In-Reply-To: <47328BDC.3090105@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, Nov 08, 2007 at 01:09:00PM +0900, Tejun Heo wrote:
> Port / host stop calls used to be made from ata_host_release() which
> is called after all hardware resources acquired after host allocation
> are released.  This is wrong as port and host stop routines often
> access the hardware.
> 
> Add separate devres for port / host stop which is invoked right after
> IRQ is released but with all other hardware resources intact.  The
> devres is added iff ->host_stop and/or ->port_stop exist.
> 
> This problem has been spotted by Mark Lord.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mark Lord <liml@rtr.ca>
> ---
> Jeff, this really needs to get into 2.6.24.  Although it hasn't caused
> any real problem (yet), ahci is one of the affected drivers and it's
> poking released iomems in its port_ops.

applied


