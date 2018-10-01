From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 0/4] AHCI support for BCM63138
Date: Mon,  1 Oct 2018 10:32:58 -0700
Message-ID: <20181001173302.25398-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Jens,

This is a resend of the previous series posted here:

https://lkml.org/lkml/2018/9/20/1060

With a few minor changes:

- rebased against your for-4.20/libata branch
- added Rob's Reviewed-by to patch
- fixed the use of the reset controller API

Thank you!

Florian Fainelli (4):
  dt-bindings: ata: Document BCM63138 compatible string
  ata: ahci_brcm: Allow optional reset controller to be used
  ata: ahci_brcm: Match BCM63138 compatible strings
  ata: ahci_brcm: Allow using driver or DSL SoCs

 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt | 1 +
 drivers/ata/Kconfig                                      | 3 ++-
 drivers/ata/ahci_brcm.c                                  | 8 ++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.17.1
