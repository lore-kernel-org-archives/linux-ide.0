From: David Miller <davem@davemloft.net>
Subject: Re: [GIT] IDE
Date: Mon, 18 Jan 2016 14:33:40 -0500 (EST)
Message-ID: <20160118.143340.1919427430379516811.davem@davemloft.net>
References: <20160118.143241.1114572935099360375.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:42124 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756468AbcARTdm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2016 14:33:42 -0500
In-Reply-To: <20160118.143241.1114572935099360375.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 18 Jan 2016 14:32:41 -0500 (EST)

I'm really batting 1000 today, proper CC:'s added, sorry about
that. :(

> Just a few small changes this merge window, marking ops const,
> printf string type fixes, etc.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit 5807fcaa9bf7dd87241df739161c119cf78a6bc4:
> 
>   Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security (2016-01-17 19:13:15 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git 
> 
> for you to fetch changes up to e04a2bd6d8c95608cbb2c803ee2875cebfd89f52:
> 
>   drivers/ide: make ide-scan-pci.c driver explicitly non-modular (2016-01-18 14:12:33 -0500)
> 
> ----------------------------------------------------------------
> Dan Carpenter (1):
>       ide: silence some underflow warnings
> 
> Julia Lawall (1):
>       ide: constify ide_dma_ops structures
> 
> Paul Gortmaker (1):
>       drivers/ide: make ide-scan-pci.c driver explicitly non-modular
> 
>  drivers/ide/ide-scan-pci.c |  3 +--
>  drivers/ide/ide.c          | 16 ++++++++--------
>  drivers/ide/it821x.c       |  2 +-
>  drivers/ide/trm290.c       |  2 +-
>  4 files changed, 11 insertions(+), 12 deletions(-)
