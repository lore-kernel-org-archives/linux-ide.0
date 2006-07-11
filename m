From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] drivers/ide/: cleanups
Date: Tue, 11 Jul 2006 17:20:04 +0100
Message-ID: <1152634804.18028.27.camel@localhost.localdomain>
References: <20060711141637.GS13938@stusta.de> <44B3B61B.4010206@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29854 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751088AbWGKQFc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Jul 2006 12:05:32 -0400
In-Reply-To: <44B3B61B.4010206@tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Ar Maw, 2006-07-11 am 18:30 +0400, ysgrifennodd Michael Tokarev:
> Adrian Bunk wrote:
> > This patch contains the following clenups:
> > - setup-pci.c: #if 0 the unused ide_pci_unregister_driver()
> 
> Hmm.  So, ide drivers will be unloadable forever, without
> a chance to fix it someday? ;)

If you want removable IDE drivers use 2.4-ac or follow the libata work.
drivers/ide is on its way out. In fact Adrian, just deleting that
function would be a better patch.

Alan

