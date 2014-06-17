From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RESEND] libahci_platform: Fail when PHY required but PHY
 support disabled
Date: Tue, 17 Jun 2014 10:27:27 -0400
Message-ID: <20140617142727.GB31819@htj.dyndns.org>
References: <1403006875-22556-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:46498 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932696AbaFQO1a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2014 10:27:30 -0400
Content-Disposition: inline
In-Reply-To: <1403006875-22556-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 17, 2014 at 03:07:55PM +0300, Mikko Perttunen wrote:
> ahci_platform_get_resources handles resource management for
> platform AHCI drivers, including getting a possible PHY
> from the device tree. Since not all drivers need a PHY, it
> ignores -ENODEV and -ENOSYS from devm_get_phy. However, when
> the PHY subsystem is mistakenly disabled, -ENOSYS can be
> returned even when a PHY is needed.
> 
> This patch modifies the -ENOSYS case to check if a "phys"
> device tree node exists. If it exists, then clearly the PHY
> subsystem is mistakenly disabled and the driver cannot work,
> ahci_platform_get_resources will fail and propagate the error.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Applied to libata/for-3.17.

Thanks.

-- 
tejun
