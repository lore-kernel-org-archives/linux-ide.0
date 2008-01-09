From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH v4 0/3] OF-platform PATA driver
Date: Wed, 9 Jan 2008 22:08:52 +0300
Message-ID: <20080109190852.GA18827@localhost.localdomain>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:61968 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755717AbYAIS7r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 13:59:47 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>, Kumar Gala <galak@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>

Hi all,

Here is the resend (aka v4) version of the OF-platform PATA
driver and related patches.

Changes since v3:
- Acked-by: Paul Mundt <lethal@linux-sh.org>
- In the powerpc specific patch: update defconfig and use
  machine_device_initcall -- this is new call found in the
  galak/powerpc.git.

Changes since v2:
- "PPC" added to PATA_PLATFORM "depends on" Kconfig entry;
  I didn't remove EMBEDDED "depends on" -- this wasn't discussed
  much and these patches should not depend on the decision.
- cosmetic fixes;
- "s/ioport_shift/reg_shift/g" patch dropped.

Changes since v1:
- __pata_platform_probe now accepts pio_mask argument;
- pata-platform compatible property renamed to ata-generic;
- pata_of_platform understands pio-mode property. It's used to pass
  pio_mask to the __pata_platform_probe. That is, in ata-generic
  context pio-mode means "pio mode the bus already configured for";
- New optional patch that renames pata_platform_info's
  ioport_shift to reg_shift.

Changes since RFC:
- nuked drivers/ata/pata_platform.h;
- powerpc bits: proper localbus node added.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
