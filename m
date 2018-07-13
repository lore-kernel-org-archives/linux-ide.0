From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 0/9] ata: ahci_platform: support allwinner R40 AHCI
Date: Fri, 13 Jul 2018 11:02:57 +0000
Message-ID: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com, thierry.reding@gmail.com, Corentin Labbe <clabbe@baylibre.com>, linux-arm-kernel@lists.infradead.org, icenowy@aosc.io
List-Id: linux-ide@vger.kernel.org

Hello

This patchset add support for allwinner R40 AHCI controller.

This controller need two regulator and one reset which is unsupported
for the moment on ahci_platform.

So this patchset add support for reset and regulator for AHCI
controller.
It add also support for non-target regulator per SATA port.

The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
by this serie, so no regression should come with it.

Since just before sending this patchset, I discovered the revert of
f0f56716fc3e ("ata: ahci-platform: add reset control support")
I have also tested this serie on a tegra124-jetson-tk1.

Changes since V2
- Moved all ressources management to ahci_platform

Corentin Labbe (9):
  ata: ahci_platform: add support for AHCI controller regulator
  dt-bindings: ata: ahci-platform: document ahci-supply
  ata: ahci_platform: add support for AHCI controller reset
  dt-bindings: ata: ahci-platform: document AHCI reset
  dt-bindings: ata: ahci-platform: fix indentation of target-supply
  ata: ahci_platform: add support for port regulator
  dt-bindings: ata: ahci-platform: document port-supply
  ARM: dts: sun8i: r40: add sata node
  ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI

 .../devicetree/bindings/ata/ahci-platform.txt      |   7 +-
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  21 +++++
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  16 ++++
 drivers/ata/ahci.h                                 |   4 +
 drivers/ata/libahci_platform.c                     | 102 ++++++++++++++++++---
 5 files changed, 138 insertions(+), 12 deletions(-)

-- 
2.16.4
