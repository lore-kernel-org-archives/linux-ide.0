From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5 1/8] of: Add NVIDIA Tegra SATA controller binding
Date: Fri, 18 Jul 2014 12:26:45 +0200
Message-ID: <53C8F665.3070006@redhat.com>
References: <1405500863-19696-2-git-send-email-mperttunen@nvidia.com> <1405667500-7402-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405667500-7402-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>, swarren@wwwdotorg.org, thierry.reding@gmail.com, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 07/18/2014 09:11 AM, Mikko Perttunen wrote:
> This patch adds device tree binding documentation for the SATA
> controller found on NVIDIA Tegra SoCs.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v5: remove ordering requirement again

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
>  .../devicetree/bindings/ata/tegra-sata.txt         | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/tegra-sata.txt
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
