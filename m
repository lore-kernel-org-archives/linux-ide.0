From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [2.6 patch] drivers/ide/: cleanups
Date: Tue, 11 Jul 2006 16:33:24 +0200
Message-ID: <1152628404.3128.68.camel@laptopd505.fenrus.org>
References: <20060711141637.GS13938@stusta.de> <44B3B61B.4010206@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:60872 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750870AbWGKOeL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Jul 2006 10:34:11 -0400
In-Reply-To: <44B3B61B.4010206@tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 18:30 +0400, Michael Tokarev wrote:
> Adrian Bunk wrote:
> > This patch contains the following clenups:
> > - setup-pci.c: #if 0 the unused ide_pci_unregister_driver()
> 
> Hmm.  So, ide drivers will be unloadable forever, without
> a chance to fix it someday? ;)

that's why it's #if 0... so that if someone goes in to fix it he only
has to remove the if 0 line...


