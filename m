From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: [PATCH v2 0/3] Add PATA host controller support for Cirrus Logic
 EP93xx CPU
Date: Tue, 03 Apr 2012 16:42:28 +0200
Message-ID: <4F7B0C54.8010804@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:34447 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413Ab2DCOnU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Apr 2012 10:43:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, hsweeten@visionengravers.com, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>

Hi,

this is a second version of EP93xx PATA driver (PATCH v2 1/3),
IDE platform code for ep93xx (PATCH v2 2/3) and IDE support
for EDB93xx boards (PATCH v2 3/3).

Changes since first version:
- don't BUG() in ep93xx_pata_dma_start(), ep93xx_pata_dma_setup(),
- don't use ata_ioports structure for EP93xx IDECTRL register values,
- IORDY timeout handling using jiffies (ep93xx_pata_wait_for_iordy),
- IDE/GPIO pin muxing solved by adding ep93xx_ide_acquire/release_gpio,
- register the driver also for EDB9312 and EDB9315 boards,
- corrected many coding style issues,
- dma initialization changed: request and configure channels in
  ep93xx_pata_dma_init (was: request in ep93xx_pata_dma_init,
  configuration in ep93xx_pata_dma_setup - channels were needlessly
  configured to the same values before each transfer).

Changes were made based on comments from Hartley, Ryan and Arnd.
Thanks!

[PATCH v2 1/3] PATA host controller driver for ep93xx
[PATCH v2 2/3] ep93xx: IDE driver platform support code
[PATCH v2 3/3] ep93xx: Add IDE support to edb93xx boards

 arch/arm/mach-ep93xx/core.c                  |   85 +
 arch/arm/mach-ep93xx/edb93xx.c               |   24
 arch/arm/mach-ep93xx/include/mach/platform.h |    3
 arch/arm/mach-ep93xx/soc.h                   |    1
 drivers/ata/Kconfig                          |    9
 drivers/ata/Makefile                         |    1
 drivers/ata/pata_ep93xx.c                    |  976 +++++++++++++++++
 7 files changed, 1099 insertions(+)


RP
