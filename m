From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: make DVD Drive recognisable on systems with
 Intel Sandybridge chipsets(v1)
Date: Fri, 30 Sep 2011 21:38:06 -0700
Message-ID: <20111001043806.GA31799@mtj.dyndns.org>
References: <1317433412-15963-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55550 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab1JAEiL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Oct 2011 00:38:11 -0400
Received: by iaqq3 with SMTP id q3so2510449iaq.19
        for <linux-ide@vger.kernel.org>; Fri, 30 Sep 2011 21:38:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317433412-15963-1-git-send-email-ming.lei@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ming.lei@canonical.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, seth.heasley@intel.com, Alan Cox <alan@linux.intel.com>

On Sat, Oct 01, 2011 at 09:43:32AM +0800, ming.lei@canonical.com wrote:
> From: Ming Lei <ming.lei@canonical.com>
> 
> This quirk patch fixes one kind of bug inside some Intel Sandybridge
> chipsets, see reports from
> 
>        https://bugzilla.kernel.org/show_bug.cgi?id=40592.
> 
> Many guys also have reported the problem before:
> 
> 	https://bugs.launchpad.net/bugs/737388
> 	https://bugs.launchpad.net/bugs/794642
> 	https://bugs.launchpad.net/bugs/782389
> 	......
> 
> With help from Tejun, the problem is found to be caused by 32bit PIO
> mode, so introduce the quirk patch to disable 32bit PIO on SATA piix
> for some Sandybridge CPT chipsets.
> 
> Seth also tested the patch on all five affected chipsets
> (pci device ID: 0x1c00, 0x1c01, 0x1d00, 0x1e00, 0x1e01), and found
> the patch does fix the problem.
> 
> Tested-by: Heasley, Seth <seth.heasley@intel.com>
> Cc: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Looks good to me but this should have been Acked-by.  SOB is used to
annotate how a patch travels upstream.

Thanks.

-- 
tejun
