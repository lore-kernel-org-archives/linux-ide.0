From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: Fix file references in drivers/ide/
Date: Mon, 10 Oct 2011 15:17:51 -0400 (EDT)
Message-ID: <20111010.151751.157914839044682434.davem@davemloft.net>
References: <1317683499.5990.2.camel@LAPJFS>
	<4E933B4C.5050104@xenotime.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E933B4C.5050104@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
To: rdunlap@xenotime.net
Cc: johfel@gmx.de, torvalds@linux-foundation.org, trivial@kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>
Date: Mon, 10 Oct 2011 11:37:00 -0700

> From: Johann Felix Soden <johfel@users.sourceforge.net>
> 
> Fix file references in drivers/ide/
> 
> There are a lot of file references to now moved or deleted files in the
> whole tree, especially in documentation and Kconfig files. This patch
> fixes the references in drivers/ide/.
> 
> Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

Acked-by: David S. Miller <davem@davemloft.net>
