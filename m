From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH v2 0/4] OF-platform PATA driver
Date: Tue, 4 Dec 2007 20:04:42 +0300
Message-ID: <20071204170442.GA10460@localhost.localdomain>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:4913 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754006AbXLDRAl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 12:00:41 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Olof Johansson <olof@lixom.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala <galak@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>

Hi all,

Here is the second version of the OF-platform PATA driver and
related patches.


Arnd, the first patch has been changed, so technically it lost your
Acked-by.

- - -
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
