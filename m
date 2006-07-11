From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [2.6 patch] drivers/ide/: cleanups
Date: Tue, 11 Jul 2006 18:30:51 +0400
Message-ID: <44B3B61B.4010206@tls.msk.ru>
References: <20060711141637.GS13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:30545 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750829AbWGKOaz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jul 2006 10:30:55 -0400
In-Reply-To: <20060711141637.GS13938@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following clenups:
> - setup-pci.c: #if 0 the unused ide_pci_unregister_driver()

Hmm.  So, ide drivers will be unloadable forever, without
a chance to fix it someday? ;)

Thanks.

/mjt
