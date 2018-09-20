From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 0/9] AHCI and SATA PHY support for BCM63138
Date: Thu, 20 Sep 2018 12:19:41 -0700
Message-ID: <7b6e1671-8efe-20d2-d3a2-51a521ce7f22@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>, Al Cooper <alcooperx@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

On 09/20/2018 12:16 PM, Florian Fainelli wrote:
> Hi Kishon, Tejun,
> 
> This patch series adds support for the SATA AHCI and PHY found on the
> ARM-basd BCM63138 DSL SoCs.
> 
> It would probably make sense for patches 1-3 to go through Kishon's
> tree, patches 4-7 through Tejun's tree, and I would be merging the last
> two patches through the Broadcom ARM-SoC tree.
> 
> Let me know if this is not a workable plan, thank you very much!

Looks like I had left patches with the incorrect subject, please
disregard the following patches:

[PATCH 2/9] phy: broadcom: allow PHY_BRCM_SATA driver to be built for
DSL SoCs
[PATCH 5/9] ata: sata_brcmstb: Allow optional reset controller to be used
[PATCH 6/9] ata: ahci_brcmstb: Match 63138 compatible strings

since they have incorrect/inconsistent titles, the other patches are
fine though. Sorry about that.

> 
> Florian Fainelli (9):
>   dt-bindings: phy: Document BCM63138 compatible string
>   phy: brcm-sata: allow PHY_BRCM_SATA driver to be built for DSL SoCs
>   phy: brcm-sata: Add BCM63138 (DSL) PHY init sequence
>   dt-bindings: ata: Document BCM63138 compatible string
>   ata: ahci_brcm: Allow optional reset controller to be used
>   ata: ahci_brcm: Match BCM63138 compatible strings
>   ata: ahci_brcm: Allow using driver or DSL SoCs
>   ARM: dts: BCM63xx: enable SATA PHY and AHCI controller
>   ARM: bcm63138: Enable SATA AHCI and PHY
> 
>  .../bindings/ata/brcm,sata-brcm.txt           |  1 +
>  .../devicetree/bindings/phy/brcm-sata-phy.txt |  1 +
>  arch/arm/boot/dts/bcm63138.dtsi               | 30 ++++++++
>  arch/arm/boot/dts/bcm963138dvt.dts            |  8 +++
>  drivers/ata/Kconfig                           |  3 +-
>  drivers/ata/ahci_brcm.c                       | 10 +++
>  drivers/phy/broadcom/Kconfig                  |  3 +-
>  drivers/phy/broadcom/phy-brcm-sata.c          | 70 +++++++++++++++++++
>  8 files changed, 124 insertions(+), 2 deletions(-)
> 


-- 
Florian
