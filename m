From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH 2.6.21-rc1] sata_vsc: refactor vsc_sata_interrupt and hook up error handling
Date: Wed, 28 Feb 2007 00:02:50 -0800
Message-ID: <20070228080250.GE210096@sgi.com>
References: <20070223233643.8535.1788.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:45620 "EHLO
	netops-testserver-3.corp.sgi.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751286AbXB1IWq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Feb 2007 03:22:46 -0500
Content-Disposition: inline
In-Reply-To: <20070223233643.8535.1788.stgit@dwillia2-linux.ch.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: htejun@gmail.com, jeff@garzik.org, linux-ide@vger.kernel.org

On Fri, Feb 23, 2007 at 04:36:43PM -0700, Dan Williams wrote:
> Separate sata_vsc interrupt handling into a normal (per-port) path and an
> error path with the addition of vsc_port_intr and vsc_error_intr
> respectively.  The error path handles interrupt based
> hotplug events which requires the definition of vsc_freeze and vsc_thaw.
> 
> Note: vsc_port_intr has a workaround for unexpected interrupts that occur
> during polled commands.  This fixes a regression between 2.6.19 and 2.6.20.
> 
> Changes in take2:
> * removed definition of invalid fis bit
> * let standard ata-error-handling handle the serror register
> * clear all unhandled interrupts
> * revert changes to vsc_intr_mask_update (vsc_thaw enables all interrupts)
> * use unlikely() for the pci-abort and not-our-interrupt cases in vsc_sata_interrupt
> 
> Changes in take3:
> * Unify the "add" + "hook-up" patches into this single patch
> 
> [htejun@gmail.com: clean up comments and suggestions]
> Cc: Jeremy Higdon <jeremy@sgi.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


I checked this on our Altix system using this chip, and it works fine.
But then 2.6.20 also worked fine on the Altix, but then we never saw
the interrupt handling problems before, either.

Thanks for doing this Dan.

jeremy
