From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 0/5] AHCI and SATA PHY support for Broadcom STB SoCs
Date: Thu, 21 May 2015 18:52:51 +0530
Message-ID: <555DDC2B.1040608@ti.com>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Kevin Cernekee <cernekee@gmail.com>
List-Id: linux-ide@vger.kernel.org

Hi Tejun,

On Wednesday 13 May 2015 04:58 AM, Brian Norris wrote:
> Few changes since v2, and the changes are *only* to the SATA driver, not to any
> of the DT bindings or the PHY driver. I'm resending the whole series for
> completeness.
>
> I'll list the changelog in each patch, but in summary:
>
> v2 -> v3:
>   - straighten out endianness for big endian MIPS and ARM in AHCI driver
>   - rename sata_brcmstb.c to ahci_brcmstb.c
>   - bind ahci_brcmstb.c against the specific string, "brcm,bcm7445-ahci" instead
>     of the generic one
>
> Brian
>
> Brian Norris (5):
>    Documentation: devicetree: add Broadcom SATA binding
>    Documentation: devicetree: add Broadcom SATA PHY binding
>    ata: add Broadcom AHCI SATA3 driver for STB chips
>    phy: add Broadcom SATA3 PHY driver for Broadcom STB SoCs
>    ARM: dts: brcmstb: add nodes for SATA controller and PHY

I'll pick "[PATCH v3 2/5] Documentation: devicetree: add Broadcom SATA PHY 
binding" and
"[PATCH v4] phy: add Broadcom SATA3 PHY driver for Broadcom STB SoCs"
in the linux-phy tree.

Thanks
Kishon
