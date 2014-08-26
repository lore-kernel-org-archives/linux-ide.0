From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: ahci_tegra: Read calibration fuse
Date: Tue, 26 Aug 2014 10:50:59 -0400
Message-ID: <20140826145059.GA29286@htj.dyndns.org>
References: <1409043630-9674-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:61578 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758250AbaHZOvD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2014 10:51:03 -0400
Content-Disposition: inline
In-Reply-To: <1409043630-9674-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: swarren@wwwdotorg.org, thierry.reding@gmail.com, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 26, 2014 at 12:00:30PM +0300, Mikko Perttunen wrote:
> The original version of the driver did not read the SATA calibration
> fuse to remove the dependency to the fuse driver. The fuse driver
> is now merged, so add this functionality.
> 
> The calibration fuse contains a 2-bit value used to pick a set
> of calibration values for the SATA pad.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Applied to libata/for-3.17-fixes.  One comment below.

>  #include <linux/ahci_platform.h>
> -#include <linux/reset.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>

You moved the include of reset.h w/o any explanation in the patch
description.  The description doesn't have to be super verbose on
trivial stuff but it at least has to cover all changes included in the
patch w/ their rationales, however trivial they may be.

Thanks.

-- 
tejun
