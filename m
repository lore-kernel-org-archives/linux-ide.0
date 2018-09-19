From: Aditya Prayoga <aditya@kobol.io>
Subject: [PATCH 0/2] Add support per ATA port ledtrigger on armada 38x
Date: Wed, 19 Sep 2018 11:45:28 +0800
Message-ID: <1537328730-9156-1-git-send-email-aditya@kobol.io>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-leds@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Daniel Golle <daniel@makrotopia.org>, Aditya Prayoga <aditya@kobol.io>
List-Id: linux-ide@vger.kernel.org

Hi everyone,

This series adds support LED trigger for each ATA port indicating disk activity
in Armada 38x. I pick up the work done by Daniel Golle which can be found at [1]

Helios4 which is based on Armada 388, has four LEDs designed to indicate disk
activity on each SATA ports. As the final switch (CONFIG_ATA_LEDS) to enable
the codepath by default is no, it should not affect the rest of Armada 38x 
based boards.

[1] https://patchwork.ozlabs.org/patch/420733/ 
---
Notes
  checkpatch.pl complains about "WARNING: please write a paragraph that
    describes the config symbol fully" but I think the description is clear
    enough to ignore the warning.

  Some performance number tested on Western Digital Red 2TB WD20EFRX
    using fio randrw
    * CONFIG_ATA_LEDS disabled and selected trigger is none
      read : iops=326
      write : iops=109
    * CONFIG_ATA_LEDS disabled and selected trigger is disk-activity
      read : iops=325
      write : iops=108
    * CONFIG_ATA_LEDS enabled and selected trigger is ata1
      read : iops=325
      write : iops=108

---
Aditya Prayoga (1):
  ARM: mvebu: Enable ARCH_WANT_LIBATA_LEDS in Armada 38x

Daniel Golle (1):
  libata: add ledtrig support

 arch/arm/mach-mvebu/Kconfig |  1 +
 drivers/ata/Kconfig         | 16 +++++++++++++
 drivers/ata/libata-core.c   | 56 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h      |  7 ++++++
 4 files changed, 80 insertions(+)

-- 
2.7.4
