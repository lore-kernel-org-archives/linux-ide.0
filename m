From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH  2/2] ata: ahci_tegra: add support for tegra210
Date: Wed, 19 Oct 2016 14:39:28 -0400
Message-ID: <20161019183928.GM18532@htj.duckdns.org>
References: <1476900956-23719-1-git-send-email-pchandru@nvidia.com>
 <1476900956-23719-3-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36083 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942817AbcJSSja (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2016 14:39:30 -0400
Received: by mail-yb0-f195.google.com with SMTP id 184so613840yby.3
        for <linux-ide@vger.kernel.org>; Wed, 19 Oct 2016 11:39:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1476900956-23719-3-git-send-email-pchandru@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Preetham Chandru Ramchandra <pchandru@nvidia.com>
Cc: swarren@wwwdotorg.org, thierry.reding@gmail.com, preetham260@gmail.com, ldewangan@nvidia.com, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com

On Wed, Oct 19, 2016 at 11:45:56PM +0530, Preetham Chandru Ramchandra wrote:
> From: Preetham Chandru R <pchandru@nvidia.com>
> 
> Add AHCI support for tegra210.
> 1. Moved tegra124 specifics to tegra124_ahci_init.
> 2. Separated out the regulators needed for tegra124 and tegra210.
> 3. Set the LPM capabilities
> 4. Added support to disable features through DT
> 5. Created inline functions for read/write and modify to
>    SATA, SATA Config and SATA Aux registers.

Can you please read Documentation/CodingStyle and reformat the patch?

Thanks.

-- 
tejun
