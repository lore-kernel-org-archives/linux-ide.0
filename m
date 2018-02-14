From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH V7 0/7] Refactor and add AHCI support for tegra210
Date: Wed, 14 Feb 2018 15:11:15 +0200
Message-ID: <3cda27d3-bb42-9e00-2e9f-ac52fbe66630@kapsi.fi>
References: <1518456406-21564-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([91.232.154.25]:42223 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967729AbeBNNLS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 14 Feb 2018 08:11:18 -0500
In-Reply-To: <1518456406-21564-1-git-send-email-pchandru@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Preetham Chandru Ramchandra <pchandru@nvidia.com>, thierry.reding@gmail.com, tj@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: preetham260@gmail.com, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com

I think this now looks good enough to merge - others please take a look 
as well.

Series,
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

On 12.02.2018 19:26, Preetham Chandru Ramchandra wrote:
> From: Preetham Ramchandra <pchandru@nvidia.com>
>
> 1. ADD AHCI support for tegra210
> 2. Extend the tegra AHCI controller device tree binding with tegra210
> 3. Update initialization sequence
> 4. Initialize regulators based on chip
> 5. Disable DevSlp
> 6. Disable DIPM
> ---
> Preetham Ramchandra (7):
>   dt-bindings: ahci-tegra: add binding documentation
>   arm64: tegra: Enable AHCI on Jetson TX1
>   ata: ahci_tegra: Update initialization sequence
>   ata: ahci_tegra: initialize regulators from soc_data
>   ata: ahci_tegra: disable devslp for t124
>   ata: ahci_tegra: disable DIPM
>   ata: ahci_tegra: Add AHCI support for Tegra210
>
>  .../bindings/ata/nvidia,tegra124-ahci.txt          |  35 +-
>  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   6 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  16 +
>  drivers/ata/ahci_tegra.c                           | 362 ++++++++++++++++-----
>  4 files changed, 329 insertions(+), 90 deletions(-)
>
