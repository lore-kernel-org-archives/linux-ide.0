From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.21-rc1] sata_vsc: refactor vsc_sata_interrupt and
 hook up	error handling
Date: Sat, 24 Feb 2007 13:06:16 +0900
Message-ID: <45DFB9B8.60905@gmail.com>
References: <20070223233643.8535.1788.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:62897 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933363AbXBXEGS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 23:06:18 -0500
Received: by nz-out-0506.google.com with SMTP id s1so651501nze
        for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 20:06:18 -0800 (PST)
In-Reply-To: <20070223233643.8535.1788.stgit@dwillia2-linux.ch.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jeremy@sgi.com

Dan Williams wrote:
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

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
