From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: [PATCH v3 0/3] Add PATA host controller support for Cirrus Logic
 EP93xx CPU
Date: Thu, 12 Apr 2012 14:10:36 +0200
Message-ID: <4F86C63C.6030908@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:55285 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380Ab2DLMLT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Apr 2012 08:11:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: "bzolnier@gmail.com" <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, hsweeten@visionengravers.com, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "rmallon@gmail.com" <rmallon@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

this is a third version of EP93xx PATA driver (PATCH v3 1/3),
IDE platform code for ep93xx (PATCH v3 2/3) and IDE support
for EDB93xx boards (PATCH v3 3/3).
Patches apply to current mainline (v3.4rc2).

v2:
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

v3:
- use custom delay loop (ep93xx_pata_delay()) instead of ndelay(),
- use ata_timing_compute() and ata_timing_merge() to properly calculate
  timings for the delay loop,
- use single ata_timing struct in ep93xx_pata_data for both IDE register
  and PIO data transfers,
- IORDY timeout handling using custom delay loop,
- move common parts of code from ep93xx_pata_{read/write}() to
  ep93xx_pata_rw_begin(), ep93xx_pata_rw_end(),
- introduce ep93xx_pata_{read/write}_{reg/data}() - wrappers which call
  ep93xx_pata_{read/write}() with proper timings selected,
- corrected delays in ep93xx_pata_{read/write}: time waited for IORDY
  is added to t2; wait (t0 - t2) or t2i (whichever is greater) after
  deassertion of DIOW-/DIOR-,
- removed DPRINTK, VPRINTK.

The reason for using custom delay loop is that currently ndelay() has
only 1us resolution on ep93xx. Using ndelay() gives us about 6 - 7us
total execution time for each IDE register/PIO data transfer. This
results in ~250kB/s transfers, no matter what PIO mode is selected.
Using custom delay loop, this driver transfers data at ~2,1MB/s (PIO4).
Is using such delay loop in the driver acceptable?

Thanks,
RP

[PATCH v3 1/3] PATA host controller driver for ep93xx
[PATCH v3 2/3] ep93xx: IDE driver platform support code
[PATCH v3 3/3] ep93xx: Add IDE support to edb93xx boards

 arch/arm/mach-ep93xx/core.c                  |   96 +
 arch/arm/mach-ep93xx/edb93xx.c               |   24
 arch/arm/mach-ep93xx/include/mach/platform.h |    3
 arch/arm/mach-ep93xx/soc.h                   |    1
 drivers/ata/Kconfig                          |    9
 drivers/ata/Makefile                         |    1
 drivers/ata/pata_ep93xx.c                    | 1044 +++++++++++++++++
 7 files changed, 1178 insertions(+)
