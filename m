From: Alan Ott <alan@signal11.us>
Subject: [PATCH 0/1] ARM: AT91: drivers: cleanup patches from Arnd Bergmann
Date: Sat, 10 Mar 2012 13:53:37 -0500
Message-ID: <1331405617-4053-1-git-send-email-alan@signal11.us>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62025 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2CJSyH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2012 13:54:07 -0500
Received: by yenl12 with SMTP id l12so1638579yen.19
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2012 10:54:05 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alan Ott <alan@signal11.us>

Hello,

I'm helping Arnd Bergmann get some of his cleanup patches upstream. This
covers the AT91 related drivers.

Thanks,

Alan.

Arnd Bergmann (1):
  ata: AT91 ata driver requires specific platforms

 drivers/ata/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

