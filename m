From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v5 1/8] of: Add NVIDIA Tegra SATA controller binding
Date: Fri, 18 Jul 2014 10:16:13 +0300
Message-ID: <53C8C9BD.3070709@nvidia.com>
References: <1405500863-19696-2-git-send-email-mperttunen@nvidia.com> <1405667500-7402-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1110 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760166AbaGRHQR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jul 2014 03:16:17 -0400
In-Reply-To: <1405667500-7402-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "tj@kernel.org" <tj@kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

So here's v5: this time, as suggested, I handle the sata clock myself 
and let ahci_platform handle it too, leading it to be prepared+enabled 
twice. This works fine, and allows us to remove the DT ordering requirement.

I also have in the works a patchset that adds the name-based 
ahci_platform_get_resources function, but that is not quite ready yet, 
even if it is quite far along. Also, I am going on vacation and 
returning on 28.7., so if this v5 is acceptable maybe it could be merged 
for 3.17 and I could work on the new get_resources scheme after I get 
back from vacation?

Thanks, Mikko

On 18/07/14 10:11, Mikko Perttunen wrote:
> This patch adds device tree binding documentation for the SATA
> controller found on NVIDIA Tegra SoCs.
>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v5: remove ordering requirement again
>
>   .../devicetree/bindings/ata/tegra-sata.txt         | 30 ++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/ata/tegra-sata.txt
>
> diff --git a/Documentation/devicetree/bindings/ata/tegra-sata.txt b/Documentation/devicetree/bindings/ata/tegra-sata.txt
> new file mode 100644
> index 0000000..946f207
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/tegra-sata.txt
> @@ -0,0 +1,30 @@
> +Tegra124 SoC SATA AHCI controller
> +
> +Required properties :
> +- compatible : "nvidia,tegra124-ahci".
> +- reg : Should contain 2 entries:
> +  - AHCI register set (SATA BAR5)
> +  - SATA register set
> +- interrupts : Defines the interrupt used by SATA
> +- clocks : Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names : Must include the following entries:
> +  - sata
> +  - sata-oob
> +  - cml1
> +  - pll_e
> +- resets : Must contain an entry for each entry in reset-names.
> +  See ../reset/reset.txt for details.
> +- reset-names : Must include the following entries:
> +  - sata
> +  - sata-oob
> +  - sata-cold
> +- phys : Must contain an entry for each entry in phy-names.
> +  See ../phy/phy-bindings.txt for details.
> +- phy-names : Must include the following entries:
> +  - sata-phy : XUSB PADCTL SATA PHY
> +- hvdd-supply : Defines the SATA HVDD regulator
> +- vddio-supply : Defines the SATA VDDIO regulator
> +- avdd-supply : Defines the SATA AVDD regulator
> +- target-5v-supply : Defines the SATA 5V power regulator
> +- target-12v-supply : Defines the SATA 12V power regulator
>
