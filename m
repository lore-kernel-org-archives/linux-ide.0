From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: [PATCH 0/3] Add PATA host controller support for Cirrus Logic EP93xx
 CPU
Date: Thu, 29 Mar 2012 10:10:15 +0200
Message-ID: <4F7418E7.4060500@metasoft.pl>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, hsweeten@visionengravers.com, ryan@bluewatersys.com, sshtylyov@ru.montavista.com, joao.ramos@inov.pt, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

Hi.

The following patchset adds support for IDE interface controller found on
Cirrus Logic's EP931x CPUs. It is based on an earlier work done by
Alessandro Zummo, Lennert Buytenhek, Joao Ramos and Bartlomiej
Zolnierkiewicz. I tried to take the best parts of code from previous
attempts for inclusion and added dma support. The driver is working
correctly in both PIO and DMA mode (with exception that it could give
timeouts in DMA mode occasionally - the problem has been solved by me
and solution proposed to LAKML; it's not related to this driver, but
DMA/interrupt handling of ep93xx IMHO).

I'm not sure about correctness of the following in the driver:
- module copyrights/authorship - I just added all copyrights of the
  earlier drivers and MODULE_AUTHOR macro lists their authors,
- timeout in IORDY polling (how long to wait for IORDY?),
- GPIO/IDE pin muxing - I hope it's done in a way acceptable for
  ep93xx maintainers (patch 2/3). I would like for the driver to refuse
  loading when muxing is wrong (first commented out lines of
  ep93xx_pata_probe, patch 1/3), but some api is needed as raw access
  to SYSCON register is prohibited in drivers.

Patchset is against current mainline kernel.

Regards,
RP


[PATCH 1/3] PATA host controller driver for ep93xx
[PATCH 2/3] ep93xx: IDE driver platform support code
[PATCH 3/3] ep93xx: Add IDE support to edb93xx boards

 arch/arm/mach-ep93xx/core.c                  |   36
 arch/arm/mach-ep93xx/edb93xx.c               |   23
 arch/arm/mach-ep93xx/include/mach/platform.h |    1
 arch/arm/mach-ep93xx/soc.h                   |    1
 drivers/ata/Kconfig                          |    9
 drivers/ata/Makefile                         |    1
 drivers/ata/pata_ep93xx.c                    |  949 +++++++++++++++++
 7 files changed, 1020 insertions(+)
