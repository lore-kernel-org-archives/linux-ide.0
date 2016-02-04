From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 00/19] ide: remove deprecated host drivers (part 1)
Date: Thu, 04 Feb 2016 14:43:57 +0100
Message-ID: <1454593456-3162-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58650 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbcBDNpU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Feb 2016 08:45:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, b.zolnierkie@samsung.com

Hi,

IDE subsystem has been deprecated since 2009 and the majority
(if not all) of Linux distributions have switched to use
libata for ATA support exclusively.

This patchset removes IDE host drivers that:
- have been replaced by their corresponding libata PATA host
  drivers (which have been available since 2006/2007)
- are not used by any defconfig

Having duplicated drivers for the same hardware doesn't seem
to be good thing in the long-term perspective for Linux as
- testing efforts are divided between two drivers/subsystems
  (while there is less and less PATA systems left in use)
- having two drivers for the same hardware confuses users

Please note that all the hardware supported by IDE host drivers
nominated for removal remains supported by correspoding libata
PATA host drivers.

PS If this patchset is accepted I would like to continue
removal of IDE host drivers in part 2 which will happen after
remaining defconfigs which still are using IDE host drivers
get converted to use corresponding libata PATA host drivers.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (19):
  ide: remove deprecated atiixp host driver
  ide: remove deprecated cs5520 host driver
  ide: remove deprecated cs5530 host driver
  ide: remove deprecated cs5535 host driver
  ide: remove deprecated cs5536 host driver
  ide: remove deprecated sc1200 host driver
  ide: remove deprecated delkin_cb host driver
  ide: remove deprecated it8213 host driver
  ide: remove deprecated it821x host driver
  ide: remove deprecated jmicron host driver
  ide: remove deprecated opti621 host driver
  ide: remove deprecated pdc202xx_old host driver
  ide: remove deprecated rz1000 host driver
  ide: remove deprecated serverworks host driver
  ide: remove deprecated sis5513 host driver
  ide: remove deprecated slc90e66 host driver
  ide: remove deprecated triflex host driver
  ide: remove deprecated ide-pnp host driver
  ide: remove deprecated icside host driver

 drivers/ide/Kconfig        | 200 +------------
 drivers/ide/Makefile       |  19 --
 drivers/ide/atiixp.c       | 211 -------------
 drivers/ide/cs5520.c       | 168 -----------
 drivers/ide/cs5530.c       | 295 -------------------
 drivers/ide/cs5535.c       | 219 --------------
 drivers/ide/cs5536.c       | 306 -------------------
 drivers/ide/delkin_cb.c    | 181 ------------
 drivers/ide/icside.c       | 691 -------------------------------------------
 drivers/ide/ide-pnp.c      | 100 -------
 drivers/ide/it8213.c       | 216 --------------
 drivers/ide/it821x.c       | 715 ---------------------------------------------
 drivers/ide/jmicron.c      | 176 -----------
 drivers/ide/opti621.c      | 178 -----------
 drivers/ide/pdc202xx_old.c | 361 -----------------------
 drivers/ide/rz1000.c       |  99 -------
 drivers/ide/sc1200.c       | 355 ----------------------
 drivers/ide/serverworks.c  | 449 ----------------------------
 drivers/ide/sis5513.c      | 636 ----------------------------------------
 drivers/ide/slc90e66.c     | 181 ------------
 drivers/ide/triflex.c      | 155 ----------
 21 files changed, 2 insertions(+), 5909 deletions(-)
 delete mode 100644 drivers/ide/atiixp.c
 delete mode 100644 drivers/ide/cs5520.c
 delete mode 100644 drivers/ide/cs5530.c
 delete mode 100644 drivers/ide/cs5535.c
 delete mode 100644 drivers/ide/cs5536.c
 delete mode 100644 drivers/ide/delkin_cb.c
 delete mode 100644 drivers/ide/icside.c
 delete mode 100644 drivers/ide/ide-pnp.c
 delete mode 100644 drivers/ide/it8213.c
 delete mode 100644 drivers/ide/it821x.c
 delete mode 100644 drivers/ide/jmicron.c
 delete mode 100644 drivers/ide/opti621.c
 delete mode 100644 drivers/ide/pdc202xx_old.c
 delete mode 100644 drivers/ide/rz1000.c
 delete mode 100644 drivers/ide/sc1200.c
 delete mode 100644 drivers/ide/serverworks.c
 delete mode 100644 drivers/ide/sis5513.c
 delete mode 100644 drivers/ide/slc90e66.c
 delete mode 100644 drivers/ide/triflex.c

-- 
1.9.1

