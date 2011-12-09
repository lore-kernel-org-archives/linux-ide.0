From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] ide/at91: use new introduce smc accessor
Date: Fri, 9 Dec 2011 13:59:26 +0000
Message-ID: <201112091359.26439.arnd@arndb.de>
References: <20111208150348.GD23884@game.jcrosoft.org> <1323357784-17555-3-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53850 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab1LIOCA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Dec 2011 09:02:00 -0500
In-Reply-To: <1323357784-17555-3-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-ide@vger.kernel.org

On Thursday 08 December 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> this will allow to use the pata_at91 on a single zImage
> 
> J.
>  drivers/ide/at91_ide.c |   65 +++++++++++++++++++++++++++--------------------
>  1 files changed, 37 insertions(+), 28 deletions(-)

The description doesn't match the file you are changing. Is there still
a strong reason to keep using the at91_ide driver instead of migrating
everybody to pata_at91 now?

	Arnd
