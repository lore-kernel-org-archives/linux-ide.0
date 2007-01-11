From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 2/2] drivers/ata: export some static functions in
 libata-core.c
Date: Thu, 11 Jan 2007 18:30:55 +0900
Message-ID: <200701110928.l0B9SUvS018849@toshiba.co.jp>
References: <200701110853.l0B8rtGK009404@toshiba.co.jp>
 <200701111008.34866.arnd@arndb.de>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx12.toshiba.co.jp ([61.202.160.132]:59915 "EHLO
	imx12.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965346AbXAKJ2d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 04:28:33 -0500
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0B9SWU9009282
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 18:28:32 +0900 (JST)
Received: (from root@localhost)
	by wall11.toshiba.co.jp  id l0B9SVAg023594
	for linux-ide@vger.kernel.org; Thu, 11 Jan 2007 18:28:31 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0B9SVIi006419
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 18:28:31 +0900 (JST)
In-Reply-To: (Your message of "Thu, 11 Jan 2007 10:08:34 +0100")
  <200701111008.34866.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, paulus@samba.org

Hi, Arnd-san.

Thank you for checking our patches.

>On Thursday 11 January 2007 09:56, Akira Iguchi wrote:
>> This patch modifies some static functions in libata-core.c
>> and libata.h to use them in ata_scc.c.
>
>Exporting new symbols needs some explanation here about why they
>should now be global for ata_scc while the existing drivers
>did not need them. Since the patch otherwise only moves stuff
>around as needed, I assume it's good.

I thought it was better to use common functions as far as possible.
But if it is preferable to copy them in ata_scc.c, I will do so.

Best regards,
Akira Iguchi
