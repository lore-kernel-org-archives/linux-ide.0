From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH V5 1/3] ata: ahci_tegra: Add AHCI support for tegra210
Date: Tue, 18 Jul 2017 18:16:25 +0200
Message-ID: <2330130.R7nNpdRms5@amdc3058>
References: <1498830993-24666-1-git-send-email-pchandru@nvidia.com>
        <1498830993-24666-2-git-send-email-pchandru@nvidia.com>
        <CGME20170718161627epcas5p16d97b0c718cc9ba1fa7483a727f6c2a3@epcas5p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36484 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdGRQQa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jul 2017 12:16:30 -0400
In-reply-to: <1498830993-24666-2-git-send-email-pchandru@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Preetham Chandru Ramchandra <pchandru@nvidia.com>
Cc: thierry.reding@gmail.com, tj@kernel.org, cyndis@kapsi.fi, preetham260@gmail.com, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com


Hi,

On Friday, June 30, 2017 07:26:31 PM Preetham Chandru Ramchandra wrote:
> From: Preetham Chandru R <pchandru@nvidia.com>
> 
> 1. Move tegra124 specifics to tegra124_ahci_init.
> 2. Separate the regulators needed for tegra124 and tegra210.
> 3. Disable DIPM for t210 and t124 as there are known issues.
> 4. Disable Devslp for t210 since devslp pin is shared with
> pcie clkreq.
> 
> Signed-off-by: Preetham Chandru R <pchandru@nvidia.com>

Please consider splitting this combined patch on smaller logical
parts (adding new initialization code used on both chipsets to
tegra_ahci_controller_init() should be done in preparatory
patch before adding T210 support, same for addition of NO_DIPM
flag) to ease the review, potential handling of regressions and
backporting of fixes to older kernels.  The code changes itself
look good to me.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

