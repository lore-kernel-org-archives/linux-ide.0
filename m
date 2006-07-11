From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] drivers/ide/: cleanups
Date: Tue, 11 Jul 2006 17:19:04 +0100
Message-ID: <1152634744.18028.26.camel@localhost.localdomain>
References: <20060711141637.GS13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28062 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751097AbWGKQD1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Jul 2006 12:03:27 -0400
In-Reply-To: <20060711141637.GS13938@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Ar Maw, 2006-07-11 am 16:16 +0200, ysgrifennodd Adrian Bunk:
> This patch contains the following cleanups:

> - ide.c: remove the unused EXPORT_SYMBOL(ide_register_hw)

NAK. A simple grep shows ide_register_hw has users, 5 in fact as of
2.6.17.


