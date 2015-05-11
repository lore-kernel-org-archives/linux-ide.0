From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 0/5] AHCI and SATA PHY support for Broadcom STB SoCs
Date: Mon, 11 May 2015 20:11:01 +0530
Message-ID: <5550BF7D.6010107@ti.com>
References: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-ide@vger.kernel.org

Hi,

On Thursday 23 April 2015 08:29 AM, Brian Norris wrote:
> Hi,
>
> Here are my updates based on everyone's feedback. I'll try to include most of
> the changelog info in each patch, but a few summary points for v1 -> v2:
>
>   - reworked the PHY DT binding so that we don't need do any custom xlate in the
>     PHY driver
>
>   - moved all handling of the 'SATA_TOP_CTRL' block into the SATA driver,
>     instead of sharing it between SATA and PHY drivers. This means we have to do
>     a little extra work in sata_brcmstb.c to decide which ports to power on, but
>     at least this way, we're really describing the hardware, not just how the SW
>     frameworks want to use the hardware.

I don't see any problems with the PHY patches. Let me know If I can take this 
via linux-phy tree.

Cheers
Kishon

>
> Enjoy,
> Brian
>
> Brian Norris (5):
>    Documentation: devicetree: add Broadcom SATA binding
>    Documentation: devicetree: add Broadcom SATA PHY binding
>    ata: add Broadcom AHCI SATA3 driver for STB chips
>    phy: add Broadcom SATA3 PHY driver for Broadcom STB SoCs
>    ARM: dts: brcmstb: add nodes for SATA controller and PHY
>
>   .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  35 +++
>   .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  40 +++
>   arch/arm/boot/dts/bcm7445.dtsi                     |  37 +++
>   drivers/ata/Kconfig                                |   9 +
>   drivers/ata/Makefile                               |   1 +
>   drivers/ata/sata_brcmstb.c                         | 285 +++++++++++++++++++++
>   drivers/phy/Kconfig                                |   9 +
>   drivers/phy/Makefile                               |   1 +
>   drivers/phy/phy-brcmstb-sata.c                     | 216 ++++++++++++++++
>   9 files changed, 632 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
>   create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt
>   create mode 100644 drivers/ata/sata_brcmstb.c
>   create mode 100644 drivers/phy/phy-brcmstb-sata.c
>
