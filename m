From: Alan Ott <alan@signal11.us>
Subject: [PATCH v2 0/2] ata: AT91 ata driver requires specific platforms
Date: Sat, 10 Mar 2012 16:36:20 -0500
Message-ID: <1331415380-10928-1-git-send-email-alan@signal11.us>
References: <1331405617-4053-1-git-send-email-alan@signal11.us>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37099 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab2CJVgb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2012 16:36:31 -0500
Received: by yenl12 with SMTP id l12so1682739yen.19
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2012 13:36:30 -0800 (PST)
In-Reply-To: <1331405617-4053-1-git-send-email-alan@signal11.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Russell King <linux@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ben Dooks <ben-linux@fluff.org>
Cc: Alan Ott <alan@signal11.us>

Based on suggestions from Ben Dooks, This patch now adds an AT91_HAS_PATA
kconfig item and the AT91 CPUs which have PATA now select it. The
AT91 PATA driver how depends on this kconfig item.

Ben, let me know if this is what you had in mind.


Alan Ott (2):
  ARM: AT91: Add parameter for AT91_HAS_PATA
  ata: AT91 ata driver requires AT91_HAS_PATA

 arch/arm/mach-at91/Kconfig |   11 +++++++++++
 drivers/ata/Kconfig        |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

