From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [2.6 patch] drivers/ide/: possible cleanups
Date: Tue, 31 May 2005 07:44:36 +1000
Message-ID: <1117489476.5194.6.camel@gaston>
References: <20050530205631.GP10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:27307 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261723AbVE3VwS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 May 2005 17:52:18 -0400
In-Reply-To: <20050530205631.GP10441@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, 2005-05-30 at 22:56 +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - pci/cy82c693.c: make a needlessly global function static
> - remove the following unneeded EXPORT_SYMBOL's:
>   - ide-taskfile.c: do_rw_taskfile
>   - ide-iops.c: default_hwif_iops
>   - ide-iops.c: default_hwif_transport
>   - ide-iops.c: wait_for_ready

Are we sure we want to do that ? That would mean never having IDE host
controller drivers as modules...

I was thinking about toying with that again for pmac one of these
days ...

It may be worth, however, to rename those exported symbols to ide_*

Ben.

