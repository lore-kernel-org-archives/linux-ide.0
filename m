From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] drivers: ata: wake port before DMA stop for ALPM
Date: Mon, 25 Jan 2016 15:23:03 -0500
Message-ID: <20160125202303.GK3628@mtj.duckdns.org>
References: <1452547346-31735-1-git-send-email-dpetigara@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33992 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbcAYUXG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jan 2016 15:23:06 -0500
Content-Disposition: inline
In-Reply-To: <1452547346-31735-1-git-send-email-dpetigara@broadcom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Danesh Petigara <dpetigara@broadcom.com>
Cc: linux-ide@vger.kernel.org, f.fainelli@gmail.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com

On Mon, Jan 11, 2016 at 01:22:26PM -0800, Danesh Petigara wrote:
> The AHCI driver code stops and starts port DMA engines at will
> without considering the power state of the particular port. The
> AHCI specification isn't very clear on how to handle this scenario,
> leaving implementation open to interpretation.
> 
> Broadcom's STB SATA host controller is unable to handle port DMA
> controller restarts when the port in question is in low power mode.
> When a port enters partial or slumber mode, its PHY is powered down.
> When a controller restart is requested, the controller's internal
> state machine expects the PHY to be brought back up by software which
> never happens in this case, resulting in failures.
> 
> To avoid this situation, logic is added to manually wake up the port
> just before its DMA engine is stopped, if the port happens to be in
> a low power state. HBA initiated power management ensures that the port
> eventually returns to its configured low power state, when the link is
> idle (as per the conditions listed in the spec). A new host flag is also
> added to ensure this logic is only exercised for hosts with the above
> limitation.
> 
> Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
> Reviewed-by: Markus Mayer <mmayer@broadcom.com>

Applied to libata/for-4.5-fixes w/ some formatting changes.

Thanks.

-- 
tejun
