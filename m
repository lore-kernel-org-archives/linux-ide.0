From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/3] ATA/ARM: convert ARM/DaVinci to use libata PATA drivers
Date: Thu, 09 Mar 2017 14:01:33 +0100
Message-ID: <1489064496-6270-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20170309130212epcas5p28ee9f513f932008f0222f9e95cfc4e57@epcas5p2.samsung.com>
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
To: Tejun Heo <tj@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Arnd Bergmann <arnd@arndb.de>, b.zolnierkie@samsung.com, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi,

This patchset adds Palmchip BK3710 IDE controller driver to
libata and switches ARM/DaVinci to use it instead of the old
IDE driver.

Sekhar, please check that it still works after changes, thanks.

Changes since v0.1 draft patch version
(https://www.spinics.net/lists/arm-kernel/msg566932.html):
- fixed cycle_time build warning
- added platform support fixes from Sekhar
- added defconfig changes from Sekhar
- preserved platform support for the old IDE driver
- split it on 3 patches

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (1):
  ata: add Palmchip BK3710 PATA controller driver

Sekhar Nori (2):
  ARM: davinci: add pata_bk3710 libata driver support
  ARM: davinci_all_defconfig: convert to use libata PATA

 arch/arm/configs/davinci_all_defconfig    |   4 +-
 arch/arm/mach-davinci/board-dm644x-evm.c  |   3 +-
 arch/arm/mach-davinci/board-dm646x-evm.c  |   3 +-
 arch/arm/mach-davinci/board-neuros-osd2.c |   3 +-
 drivers/ata/Kconfig                       |   9 +
 drivers/ata/Makefile                      |   1 +
 drivers/ata/pata_bk3710.c                 | 395 ++++++++++++++++++++++++++++++
 7 files changed, 412 insertions(+), 6 deletions(-)
 create mode 100644 drivers/ata/pata_bk3710.c

-- 
1.9.1
